---
name: hood1-iteration
description: >
  hood1 (lens-stain) 算法迭代发版全流程 skill。
  覆盖：代码同步 → 代码修改 → 编译打包 → 设备部署运行 → 日志分析 → 阈值调优 → git提交推送 → 发版zip。
  需要人工确认的环节用 [HUMAN] 标注，其余全自动。
trigger: 用户要求对 hood1 产品做算法迭代、调参、发版
---

# hood1 (Lens-Stain) 迭代发版 Skill

## 前置条件

- 项目根目录: `/home/spark/share/mint-alg`
- 平台: Ingenic T32, MIPS uclibc, GCC 5.4.0
- 模型格式: `.mgk` (sinfer framework)
- 设备访问: SSH 到 `192.168.72.100` (root, NFS 挂载)
- 分支: `hood` → 远端 `feat/liupan/hood`

---

## Phase 1: 环境准备

### Step 1.1 [HUMAN] 确认更新范围

向用户确认：
- 是否需要拉取最新代码？（主仓库 + 子模块 3rdparty/opencv, s-infer, sort）
- 本次迭代的参考产品是哪个？（hood2 / hood3 / m5pro）
- 需要修改哪些文件？（预处理、后处理、推理流程）

### Step 1.2 同步代码（如用户确认需要）

```bash
cd /home/spark/share/mint-alg
git pull origin feat/liupan/hood
git submodule update --init --recursive
```

> **注意**: 3rdparty 子模块如有独立分支更新（如 opencv 的 fix/add-4.5-include），需手动切到对应分支 pull。

---

## Phase 2: 代码修改

### Step 2.1 [HUMAN] 确认修改内容

根据用户需求和参考产品代码，列出需要修改的文件和具体改动点，让用户确认后再执行。

### Step 2.2 模型文件管理

- 模型路径: `examples/src/hood1/models/`
- model.json: `examples/src/hood1/model.json`

**model.json 字段说明：**
```json
{
  "num_class": 2,                          // 类别数，固定为2
  "high_frequency_threshold": 0.68,        // 高频阈值（低于此值判定为脏污）
  "high_frequency_clean_threshold": 0.95,  // 高频清洁阈值（高于此值判定为干净）
  "stain_threshold": 0.5,                  // 模型输出脏污概率阈值
  "history_window_size": 10,               // 滑动窗口大小
  "stain_count_threshold": 5,              // 窗口内脏污帧数阈值
  "model_path": "/mnt/nfs/mint-alg/examples/src/hood1/models/xxx.mgk",
  "image_width": 576,
  "image_height": 320,
  "images_list_path": "/mnt/nfs/.../data/xxx/",  // 评测图片目录
  "frame_interval": 0.1,                   // 喂图间隔（秒）
  "repeat_count": 10                       // 每张图重复喂入次数（评测用，在线运行设为1）
}
```

**重要规则：**
- 所有阈值/路径/参数必须在 model.json 中配置，**禁止硬编码**
- `frame_interval` 单位为秒，代码内部转微秒
- `repeat_count` 用于评测时填满滑动窗口，在线运行必须设为 1

### Step 2.3 关键代码模式

**NV12 预处理（classifier_stain.cpp → preprocess）：**
```cpp
// 直接 NV12 域 resize，不做 RGB 转换
auto sinfer_input = m_net->GetInputTensorByIndex(0);
uint8_t* model_input_ptr = static_cast<uint8_t*>(sinfer_input->GetInputData());
nv12_nearest_scale_zgr(yuv.p_vir[0], model_input_ptr,
                       yuv.width, yuv.height, m_model_input_w, m_model_input_h);
```

**NV12 内存布局（run_hood1.cpp / hood1.cpp）：**
- `p_vir[0]` = Y plane
- `p_vir[1]` = UV interleaved plane (独立内存，非 Y 之后连续)
- `p_vir[2]` = NULL (NV12 无第三平面)

**异步缓冲区安全（hood1.cpp → set_input_data(const&)）：**
```cpp
// 必须 deep copy，因为 caller 可能复用 buffer
int nv12_size = yuv.width * yuv.height * 3 / 2;
uint8_t* buf = new uint8_t[nv12_size];
memcpy(buf, yuv.p_vir[0], nv12_size);
data_copy.data_info.yuv.p_vir[0] = buf;
data_copy.data_info.yuv.p_vir[1] = buf + yuv.width * yuv.height;
// classifier thread 完成后 delete[] p_vir[0]
```

**帧池（run_hood1.cpp）：**
```cpp
// 消息队列容量 3 + 1 处理中 + 1 写入 = 5 个缓冲区轮转
static constexpr int FRAME_POOL_SIZE = 5;
unsigned char* frame_pool[FRAME_POOL_SIZE];
```

---

## Phase 3: 编译打包

### Step 3.1 编译

```bash
cd /home/spark/share/mint-alg
python3 scripts/release.py hood1
```

### Step 3.2 复制运行时库（自动，不修改 release.py）

编译成功后**必须**手动复制 sinfer 和 opencv 的运行时库：

```bash
cp 3rdparty/s-infer/3rdparty/ingenic/t32/uranus/tnna/540/lib/uclibc/*.so release/lib/
cp 3rdparty/opencv/4.5/ingenic_t32_r337/uclibc/lib/*.so* release/lib/
```

### Step 3.3 验证产物完整性

检查 `release/lib/` 下包含以下关键库：
- `libaie.so`
- `liburanus_core.so`, `liburanus_extend.so`, `liburanus_tensor.so`
- `libopencv_core.so.4.5`, `libopencv_imgproc.so.4.5`
- `libmi_alg.so` (或对应 product so)

---

## Phase 4: 设备部署运行

### Step 4.1 确认设备运行脚本

检查 `~/share/run_hood1.sh` 是否指向本次编译产物：

```bash
cat ~/share/run_hood1.sh
# 应包含: ./run_hood1 /mnt/nfs/mint-alg/examples/src/hood1/model.json
```

### Step 4.2 运行

设备端通过 NFS 直接访问编译产物，无需额外拷贝。

运行命令（设备端）：
```bash
cd /mnt/nfs/mint-alg/release
./run_hood1 /mnt/nfs/mint-alg/examples/src/hood1/model.json
```

### Step 4.3 评测配置

评测时将 model.json 中的：
- `images_list_path` 指向带 normal/stain 子目录或文件名标记的数据集
- `repeat_count` 设为 10（填满滑动窗口）
- `frame_interval` 设为 0.1（控制节奏）

---

## Phase 5: 日志分析

### Step 5.1 收集日志

用户将设备端 MobaXterm 日志保存到 `C:\Users\spark\Desktop\`。

### Step 5.2 自动分析

使用 `~/share/extract_hood1_results.py` 分析：

```bash
python3 /home/spark/share/extract_hood1_results.py \
  "/mnt/c/Users/spark/Desktop/<log-file>.txt" \
  "/mnt/c/Users/spark/Desktop/<log-file>_results.csv"
```

**脚本逻辑：**
1. 自动检测 `repeat_count`（从 log header 解析）
2. 从 `IMAGES: N/M, IMAGE PATH:...` 建立 image_idx → filename 映射
3. 从 `SinferInfo + LensStainResult` 提取每帧结果
4. 每张图取**最后一次** repeat 的结果（滑动窗口已稳定）
5. 根据文件名中的 `normal`/`stain` 提取 GT
6. 输出 CSV + 统计指标

**输出指标：**
- Overall accuracy（总体准确率）
- Stain recall（脏污召回率，目标 >95%）
- Normal accuracy（正常正确率，目标 >95%）
- Stain FPR（误判率，目标 <5%）

### Step 5.3 常见问题诊断

| 现象 | 可能原因 | 排查方法 |
|------|---------|---------|
| 所有帧 high_freq 相同 | UV 平面数据错误 | 检查 p_vir[1] 是否正确传入 |
| stain_prob 始终 -1.0 | 滑动窗口未满（initializing） | 增大 repeat_count |
| 正常图片大量误判 | high_frequency_threshold 过高 | 降低阈值或分析 high_freq 分布 |
| 脏污图片大量漏判 | high_frequency_threshold 过低 | 提高阈值 |
| 帧间数据相同 | buffer 复用/未 deep copy | 检查 frame pool 和 deep copy |

---

## Phase 6: 阈值调优

### Step 6.1 自动推荐阈值

使用 `~/share/recommend_threshold.py` 分析 high_freq 分布并推荐阈值：

```bash
python3 /home/spark/share/recommend_threshold.py /mnt/c/Users/spark/Desktop/<results>.csv
```

**脚本输出：**
- Normal/Stain 图片的 high_freq 百分位分布（P10/P25/P50/P75/P90）
- 不同阈值下的 Accuracy / Recall / FPR / F1 模拟
- 三档推荐：Conservative（低误判）/ Balanced / Aggressive（高召回）

**推荐逻辑：**
- Conservative = normal_P10（降低误判）
- Balanced = (normal_P10 + stain_P90) / 2（平衡点）
- Aggressive = stain_P90（提高召回）
- Best accuracy = 遍历所有阈值找到最高准确率

> 如需更保守（降低误判），将阈值向 normal_P10 靠近；
> 如需更激进（提高召回），将阈值向 stain_P90 靠近。

### Step 6.2 [HUMAN] 确认阈值

将推荐阈值告知用户，由用户确认后修改 model.json。

### Step 6.3 迭代

修改阈值 → 重新编译 → 重新运行 → 重新分析，直到指标满足要求。

---

## Phase 7: 发版

### Step 7.1 [HUMAN] 确认提交内容

运行 `git status` 和 `git diff --stat`，向用户确认：
- 哪些文件需要提交（代码改动 + model.json + 模型文件）
- 哪些不提交（3rdparty 子模块变化）
- 模型文件的增删（如旧 .mgk 删除、新 .mgk 添加）

### Step 7.2 提交推送

```bash
# 暂存（按用户确认的范围）
git add <files>
git rm <deleted-models>

# 提交（commit message 由用户指定）
git commit -m "<message>"

# 推送到远端
git push origin hood:feat/liupan/hood
```

### Step 7.3 生成发版 zip

```bash
zip -r hood1_package_<date>V<N>.zip examples/src/hood1 build_hood1 release
```

- 文件名格式: `hood1_package_MMDDV<N>.zip`
- 包含: 配置文件 + 编译产物 + release 目录

---

## 完整 Checklist

- [ ] [HUMAN] 确认更新范围（git pull / 子模块 / 参考产品）
- [ ] [HUMAN] 确认代码修改内容
- [ ] model.json 无硬编码，所有参数可配置
- [ ] 编译成功（scripts/release.py hood1）
- [ ] 运时库已复制（sinfer + opencv）
- [ ] 评测模式: repeat_count=10, frame_interval=0.1
- [ ] 在线模式: repeat_count=1, frame_interval=0.1
- [ ] [HUMAN] 确认阈值调优结果
- [ ] [HUMAN] 确认 git 提交内容
- [ ] git push 到 feat/liupan/hood
- [ ] 发版 zip 已生成

---

## 关键文件索引

| 文件 | 作用 |
|------|------|
| `src/alg/impl/classifier_stain.cpp` | 脏污分类器核心实现（预处理/推理/后处理） |
| `src/alg/impl/classifier_stain.hpp` | 分类器头文件 |
| `src/product/hood1/hood1.cpp` | hood1 产品线程/消息队列/回调封装 |
| `examples/src/run_hood1.cpp` | 评测入口（帧池/喂图/日志） |
| `examples/src/hood1/model.json` | 运行时配置（阈值/模型路径/评测参数） |
| `examples/src/hood1/models/*.mgk` | 模型权重文件 |
| `scripts/release.py` | 编译脚本（hood1 产品配置已内置） |
| `~/share/extract_hood1_results.py` | 日志分析脚本 |
| `~/share/recommend_threshold.py` | 阈值自动推荐脚本 |
| `~/share/run_hood1.sh` | 设备端运行脚本 |
