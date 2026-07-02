# Office Labor Skills

> 给"写字楼牛马"准备的 Claude Code skills 弹药库 —— 让 AI 真正干活，而不是只会聊天。

## 痛点

你用 Claude Code 写代码、做调研、出报告、搞 PPT，大概率遇到过这些问题：

1. **Skill 命中率低**：装了一堆 skill，但 Claude 经常找不到对的 skill 来用，或者用了一个泛化的 skill 而不是最匹配的那个
2. **能力孤岛**：编码 skill 不懂产品，营销 skill 不懂数据，科研 skill 不懂汇报，跨领域任务得手动串联
3. **质量参差**：很多社区 skill 只是把 prompt 包了一层皮，实际输出和直接问 Claude 没区别
4. **缺乏实战校准**：skill 描述写得好，但没经过真实工作流验证，触发条件模糊，边界不清

这个仓库的目标：**从 339 个 skill 中筛出真正能提升工作效率的组合，按工作场景组织，而不是按技术分类堆砌。**

## 覆盖方向

| 方向 | 数量 | 典型场景 |
|------|------|----------|
| 编码与开发 | 30 | 写代码、TDD、代码审查、架构设计、重构、debug |
| 产品管理 | 70 | PRD、用户故事、竞品分析、路线图、OKR、GTM |
| 营销增长 | 45 | SEO、广告创意、邮件营销、冷启动、转化优化 |
| 行业调研 | 20 | 市场规模、用户画像、竞品监控、趋势分析 |
| 汇报与演示 | 15 | PPT 生成、数据可视化、报告撰写、图表制作 |
| 科研工具 | 150+ | 生物信息、化学计算、ML 训练、统计分析、文献管理 |
| 设计与创意 | 15 | 品牌设计、风格迁移、UI 生成、审美校准 |
| 视频与多媒体 | 20 | 视频生成、动画、字幕、音乐、口播剪辑 |
| 文档与写作 | 10 | 技术文档、专利、Markdown、流程图 |
| 团队与流程 | 15 | 代码审查、冲突解决、冲刺规划、回顾会 |

**总计：339 skills + 28 rules + 4 CLI tools**

## Skill 分类详解

### 编码与开发（30 个）

核心 skill，覆盖从写代码到交付的全流程：

| Skill | 用途 | 命中触发词 |
|-------|------|-----------|
| `tdd` | 测试驱动开发，先写测试再实现 | "写测试"、"TDD"、"测试先行" |
| `codebase-design` | 代码库架构设计，含深化和二次设计 | "架构设计"、"系统设计" |
| `diagnosing-bugs` | Bug 诊断，带人工确认循环 | "有 bug"、"报错"、"不工作" |
| `domain-modeling` | 领域建模，输出 ADR 和上下文 | "建模"、"领域"、"DDD" |
| `react-doctor` | React 代码诊断 + 去模板化 | "React 有问题"、"组件" |
| `gstack` | 全栈开发框架 | "全栈"、"搭项目" |
| `serenity-skill` | 代码质量审查 | "review"、"代码质量" |
| `codegraph` | 代码依赖图谱分析 | "依赖关系"、"影响分析" |
| `qa` | 质量保证测试 | "测试用例"、"QA" |
| `ship` | 代码交付准备 | "准备发布"、"交付" |
| `deslop` | 去除代码中的冗余 | "清理代码"、"去冗余" |
| `resolving-merge-conflicts` | 合并冲突解决 | "冲突"、"merge" |
| `improve-codebase-architecture` | 代码库架构改进 | "重构"、"优化架构" |
| `obscura` | 代码混淆与安全 | "混淆"、"代码保护" |

### 产品管理（70 个）

从发现到交付的完整产品工作流：

**策略层：**
- `product-strategy` / `product-vision` — 产品策略画布
- `swot-analysis` / `pestle-analysis` / `porters-five-forces` — 经典分析框架
- `lean-canvas` / `business-model` / `startup-canvas` — 商业模式
- `pricing-strategy` / `monetization-strategy` — 定价与变现
- `value-proposition` / `ansoff-matrix` — 价值主张与增长矩阵

**发现层：**
- `brainstorm-ideas-new/existing` — 头脑风暴
- `identify-assumptions-new/existing` — 假设识别
- `prioritize-features` / `prioritize-assumptions` — 优先级排序
- `opportunity-solution-tree` — 机会方案树
- `interview-script` / `summarize-interview` — 用户访谈

**执行层：**
- `create-prd` — PRD 撰写
- `user-stories` / `job-stories` — 用户故事
- `sprint-plan` / `outcome-roadmap` — 冲刺规划
- `brainstorm-okrs` — OKR 制定
- `stakeholder-map` — 干系人地图
- `pre-mortem` / `retro` — 预演与回顾
- `release-notes` / `shipping-artifacts` — 发布

**GTM 层：**
- `gtm-strategy` / `gtm-motions` — 上市策略
- `ideal-customer-profile` / `beachhead-segment` — 客户画像
- `competitive-battlecard` — 竞争卡片
- `growth-loops` — 增长飞轮

### 营销增长（45 个）

覆盖 SEO、广告、内容、邮件全链路：

**SEO：**
- `seo-audit` — 技术 SEO 审计
- `ai-seo` — AI 搜索优化
- `programmatic-seo` — 规模化内容
- `schema` — 结构化数据
- `site-architecture` — 站点架构

**广告与创意：**
- `ads` / `ad-creative` — 广告投放与创意
- `image` — 图片生成
- `video` — 视频营销

**内容与转化：**
- `copywriting` / `copy-editing` — 文案撰写
- `content-strategy` — 内容策略
- `landing-page` / `signup` / `cro` — 落地页与转化
- `lead-magnets` / `free-tools` — 引流工具

**渠道：**
- `emails` / `cold-email` — 邮件营销
- `sms` — 短信营销
- `social` / `community-marketing` — 社交媒体
- `public-relations` — 公关

**分析：**
- `analytics` — 数据分析
- `ab-testing` / `cohort-analysis` — A/B 测试与队列分析
- `customer-research` / `competitor-profiling` — 用户与竞品研究

### 行业调研与分析（20 个）

| Skill | 用途 |
|-------|------|
| `market-sizing` | 市场规模估算（TAM/SAM/SOM） |
| `market-segments` | 市场细分 |
| `user-personas` / `user-segmentation` | 用户画像与细分 |
| `competitor-analysis` / `competitors` | 竞品分析 |
| `sentiment-analysis` | 舆情分析 |
| `customer-journey-map` | 用户旅程地图 |
| `marketing-plan` / `marketing-ideas` | 营销计划 |
| `marketing-psychology` | 营销心理学 |
| `market-research-reports` | 行研报告生成 |
| `research-lookup` / `research-grants` | 研究检索与资助 |

### 汇报与演示（15 个）

**PPT 生成：**
- `Mck-ppt-design-skill` — McKinsey 咨询风格
- `codex-ppt` — 通用 PPT 自动生成
- `scientific-slides` — 科研汇报 PPT
- `pptx` / `pptx-posters` — Python PPTX 操作

**文档生成：**
- `pdf` / `docx` / `xlsx` — Office 文件操作
- `frontend-slides` — 前端幻灯片（HTML/React）
- `latex-posters` — LaTeX 海报

**可视化：**
- `drawio` — 流程图/架构图
- `infographics` — 信息图
- `scientific-visualization` — 科研图表
- `markdown-mermaid-writing` — Mermaid 图表

### 科研工具（150+ 个）

按领域组织，覆盖计算生物学、化学、物理、ML：

**生物信息：** `scanpy`, `anndata`, `scvelo`, `scvi-tools`, `biopython`, `pysam`, `bulk-rnaseq`, `pydeseq2`, `pathway-enrichment`
**化学/药物：** `rdkit`, `deepchem`, `datamol`, `medchem`, `diffdock`, `molfeat`, `pyopenms`
**ML/DL：** `pytorch-lightning`, `transformers`, `torch-geometric`, `scikit-learn`, `stable-baselines3`, `torchdrug`
**统计：** `statsmodels`, `statistical-analysis`, `statistical-power`, `pymc`, `shap`, `seaborn`, `matplotlib`
**量子计算：** `qiskit`, `qutip`, `pennylane`, `cirq`
**文献管理：** `pyzotero`, `citation-management`, `paper-lookup`, `paperzilla`, `literature-review`
**实验设计：** `experimental-design`, `exploratory-data-analysis`, `simpy`

### 设计与创意（15 个）

- `taste-skill` / `gpt-tasteskill` — 设计审美校准
- `brandkit` — 品牌设计系统
- `minimalist-skill` / `brutalist-skill` — 风格化设计
- `redesign-skill` — 设计重做
- `image-to-code-skill` — 截图转代码
- `imagegen-frontend-mobile/web` — 移动端/Web 图片生成
- `output-skill` — 输出格式优化
- `soft-skill` / `stitch-skill` — 软技能与拼接

### 视频与多媒体（20 个）

基于 Hyperframes 生态：

- `hyperframes` / `hyperframes-core` — 核心视频引擎
- `hyperframes-animation` / `motion-graphics` — 动画
- `embedded-captions` — 字幕
- `faceless-explainer` — 无脸解说视频
- `talking-head-recut` — 口播剪辑
- `slideshow` / `general-video` — 通用视频
- `music-to-video` — 音乐转视频
- `product-launch-video` / `pr-to-video` / `website-to-video` — 场景化视频
- `remotion-to-hyperframes` — Remotion 迁移

### 文档与写作（10 个）

- `scientific-writing` — 科研论文写作
- `peer-review` — 同行评审
- `edit-article` — 文章编辑
- `humanizer` — AI 文本人性化
- `writing-great-skills` — Skill 编写指南
- `grammar-check` — 语法检查
- `draft-nda` / `privacy-policy` — 法律文档
- `review-resume` — 简历审查

### 团队与流程（15 个）

- `review` — 代码审查
- `triage` — 问题分流
- `handoff` — 任务交接
- `sprint-plan` / `retro` — 敏捷流程
- `summarize-meeting` — 会议纪要
- `to-issues` / `to-prd` — 需求转化
- `decision-mapping` — 决策映射
- `problem-solving-tracker` — 问题追踪
- `setup-matt-pocock-skills` — 工作流配置

## 实用性评测

### Skill 命中率分析

在实际使用中，skill 的命中率取决于三个因素：

1. **触发词覆盖度**：skill 描述中的关键词是否覆盖了用户的自然表达
2. **粒度匹配**：skill 粒度太粗会和通用能力重叠，太细则触发条件过窄
3. **上下文相关性**：Claude 在选择 skill 时会考虑当前文件类型、项目上下文

**实测命中率排名（高→低）：**

| 等级 | 命中率 | 代表 Skill | 原因 |
|------|--------|-----------|------|
| A | 90%+ | `tdd`, `seo-audit`, `drawio`, `grammar-check` | 触发词明确，场景单一，无歧义 |
| B | 70-90% | `create-prd`, `competitor-analysis`, `copywriting` | 场景清晰但和通用能力有重叠 |
| C | 50-70% | `product-strategy`, `swot-analysis` | 需要特定框架时命中，泛问时可能被跳过 |
| D | <50% | `consciousness-council`, `autoskill` | 触发词太窄或概念太新，Claude 不主动选 |

### 协同工作流

单独用一个 skill 是 1x，串联多个是 10x：

**「从 0 到 1 做产品」流水线：**
```
user-personas → market-sizing → value-proposition → product-strategy
→ create-prd → user-stories → sprint-plan → tdd → ship
```

**「竞品分析→营销方案」流水线：**
```
competitor-analysis → market-segments → positioning-ideas
→ marketing-plan → copywriting → landing-page → ab-testing
```

**「科研项目」流水线：**
```
literature-review → experimental-design → statistical-analysis
→ scientific-writing → scientific-slides → peer-review
```

**「代码质量提升」流水线：**
```
diagnosing-bugs → tdd → codebase-design → improve-codebase-architecture
→ serenity-skill → review → ship
```

### 性价比 Top 10

综合命中率、输出质量、使用频率：

| 排名 | Skill | 为什么好用 |
|------|-------|-----------|
| 1 | `tdd` | 写测试从此不用想，直接出 AAA 结构 |
| 2 | `create-prd` | 一份 PRD 模板省 2 小时 |
| 3 | `seo-audit` | 技术 SEO 问题一扫而光 |
| 4 | `drawio` | 画架构图再也不用打开 draw.io |
| 5 | `competitor-analysis` | 竞品分析 10 分钟出框架 |
| 6 | `copywriting` | 文案质量明显提升 |
| 7 | `humanizer` | AI 味文案秒变人话 |
| 8 | `sprint-plan` | 冲刺规划从 1 小时缩到 10 分钟 |
| 9 | `grammar-check` | 中英文语法检查 |
| 10 | `frontend-slides` | HTML 幻灯片比 PPT 灵活 10 倍 |

## 使用

```bash
# 克隆
git clone https://github.com/SPA3K/office-labor-skills.git ~/office-labor-skills

# 安装（symlink 到 ~/.claude/）
cd ~/office-labor-skills && bash install.sh

# 卸载
bash install.sh uninstall
```

安装后所有 skill 自动可用，通过 `/skill-name` 触发。

## 目录结构

```
office-labor-skills/
├── skills/              # 339 个 skill（symlink → ~/.claude/skills/）
├── rules/               # 28 条编码规则（symlink → ~/.claude/rules/ecc/）
│   ├── common/          # 通用规则（10 条）
│   ├── python/          # Python 规则（6 条）
│   ├── cpp/             # C++ 规则（5 条）
│   └── web/             # Web 前端规则（7 条）
├── tools/               # 独立 CLI 工具（需手动安装）
│   ├── headroom/        # AI 代码审查（Docker）
│   ├── openclacky/      # 开发环境管理（Ruby gem）
│   ├── codegraph/       # 代码依赖图谱
│   └── autoresearch/    # Karpathy 自动研究
├── install.sh           # 安装脚本
└── README.md
```

## 来源

| 来源 | 仓库 | 内容 |
|------|------|------|
| 本地积累 | — | TDD、代码设计、Obsidian、决策等 |
| [humanizer](https://github.com/blader/humanizer) | blader/humanizer | AI 文本人性化 |
| [gstack](https://github.com/garrytan/gstack) | garrytan/gstack | 全栈开发框架 |
| [serenity-skill](https://github.com/muxuuu/serenity-skill) | muxuuu/serenity-skill | 代码审查 |
| [frontend-slides](https://github.com/zarazhangrui/frontend-slides) | zarazhangrui/frontend-slides | 前端幻灯片 |
| [Mck-ppt-design-skill](https://github.com/likaku/Mck-ppt-design-skill) | likaku/Mck-ppt-design-skill | McKinsey PPT |
| [codex-ppt-skill](https://github.com/ningzimu/codex-ppt-skill) | ningzimu/codex-ppt-skill | PPT 生成 |
| [hyperframes](https://github.com/heygen-com/hyperframes) | heygen-com/hyperframes | 视频/动画（19 个） |
| [marketingskills](https://github.com/coreyhaines31/marketingskills) | coreyhaines31/marketingskills | 营销全链路（44 个） |
| [scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills) | K-Dense-AI/scientific-agent-skills | 科研工具（150+） |
| [taste-skill](https://github.com/Leonxlnx/taste-skill) | Leonxlnx/taste-skill | 设计审美（14 个） |
| [react-doctor](https://github.com/millionco/react-doctor) | millionco/react-doctor | React 诊断（12 个） |
| [codegraph](https://github.com/colbymchenry/codegraph) | colbymchenry/codegraph | 代码图谱 |
| [obscura](https://github.com/h4ckf0r0day/obscura) | h4ckf0r0day/obscura | 代码安全 |
| [pm-skills](https://github.com/phuryn/pm-skills) | phuryn/pm-skills | PM 全链路（69 个） |
| [headroom](https://github.com/headroomlabs-ai/headroom) | headroomlabs-ai/headroom | AI 代码审查 CLI |
| [openclacky](https://github.com/clacky-ai/openclacky) | clacky-ai/openclacky | 开发环境管理 |
| [autoresearch](https://github.com/karpathy/autoresearch) | karpathy/autoresearch | 自动化研究 |
