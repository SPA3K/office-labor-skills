---
name: problem-solving-tracker
description: 从问题定义到解决方案的完整追踪系统，确保逻辑清晰、信息流明确，每个呈现的东西都有解释和来源。
---

# Problem Solving Tracker Skill

一个系统化的问题解决过程追踪工具，确保从问题提出到最终解决的整个过程中：
- 每个呈现的信息都有明确的来源和解释
- 信息流转经过完全可追溯
- 逻辑链条完整不断裂

## 使用方式

```bash
/track-problem init <problem-title>
/track-problem add-requirement <requirement-description>
/track-problem add-iteration <action> <reason> <result>
/track-problem analyze
/track-problem finalize
/track-problem report
```

## 工作流

### 1. 初始化问题 (INIT)
```
/track-problem init "Teaser图优化：逻辑清晰性"
```
输出:
- 问题ID
- 创建时间戳
- 初始状态记录

### 2. 定义需求 (REQUIREMENTS)
每个需求需要包含：
- **需求编号**: R1, R2, ...
- **需求描述**: 具体的改进需求
- **优先级**: HIGH/MEDIUM/LOW
- **来源**: 用户提出/发现/推导
- **关键指标**: 如何验证完成

示例:
```
/track-problem add-requirement \
  "问题1: Retain/Drop/Merge对Context的影响" \
  "HIGH" \
  "用户提出" \
  "检查：是否用图形清晰表达三种操作对context大小的影响"
```

### 3. 迭代追踪 (ITERATION)
每次迭代记录完整的信息流：

```
/track-problem add-iteration \
  "ACTION: 添加Frame数量可视化" \
  "REASON: Retain显示全部帧(5个)，Drop显示部分(3个，1个虚线)，Merge显示合并(2个大矩形)" \
  "WHY: 这样能直观表达context大小的变化，符合需求R1" \
  "RESULT: ✓ 完成 | 评分: 9/10"
```

每条迭代必须包含：
- **ACTION**: 具体做了什么（名词+动词）
- **REASON**: 为什么这么做（设计逻辑）
- **WHY**: 为什么选择这个方案而不是其他（对比+权衡）
- **RESULT**: 结果和评分
- **LINKS**: 关联的需求编号（R1, R2, ...）

### 4. 分析检查 (ANALYZE)
```
/track-problem analyze
```

输出：
- 需求覆盖情况 (矩阵)
- 信息流完整性检查
- 逻辑链条验证
- 缺失的解释

### 5. 最终报告 (REPORT)
```
/track-problem report
```

生成完整的追踪文档，包含：
1. **问题定义** → 信息来源 → 验证方法
2. **需求矩阵** → 优先级 → 对标指标
3. **迭代历史** (表格形式)
   - 迭代号 | 时间 | 行动 | 理由 | 依据 | 结果 | 关联需求
4. **信息流图** → 显示各部分如何串联
5. **最终评估** → 每个需求的完成度
6. **决策链条** → 展示逻辑推导过程

## 数据结构

### Problem JSON
```json
{
  "id": "problem-001",
  "title": "Teaser图优化",
  "created_at": "2026-03-27T16:30:00Z",
  "status": "TRACKING",
  "requirements": [
    {
      "id": "R1",
      "title": "Retain/Drop/Merge对Context影响",
      "priority": "HIGH",
      "source": "user-feedback",
      "metric": "visual-clarity-score",
      "status": "IN_PROGRESS",
      "iterations": [...]
    }
  ],
  "iterations": [...],
  "decision_log": [...]
}
```

### Iteration Record
```json
{
  "iteration_id": "iter-001",
  "timestamp": "2026-03-27T16:40:00Z",
  "requirement_links": ["R1"],
  "action": "Add frame rectangles showing quantity difference",
  "reason": "Visualize context size impact",
  "design_logic": "Retain(5), Drop(3+1 dashed), Merge(2 large)",
  "alternatives_considered": [
    {"option": "用文字标注", "reason": "rejected", "why": "违反show-not-tell原则"},
    {"option": "用箭头表达流向", "reason": "considered", "why": "可以结合使用"}
  ],
  "result_status": "COMPLETED",
  "score": 9,
  "validation": "Visual test passed",
  "artifacts": ["teaserv1.drawio#L42-50"]
}
```

## 信息流完整性检查 (Traceability Matrix)

每个呈现的元素都要能回答：
```
元素 ← 来自需求(R?) ← 基于什么理由 ← 怎么验证 ← 最终输出
```

示例：
```
Frame矩形可视化
  ← 来自 R1 (Retain/Drop/Merge对Context影响)
  ← 基于 "用数量和大小直观表达"
  ← 怎么验证: 用户看到能否理解三种操作的区别
  ← 最终输出: teaserv1.drawio 中的Frame行
```

## 逻辑链条验证

系统会自动检查：
1. **闭包性**: 每个需求都有对应的迭代吗？
2. **追踪性**: 每个迭代都能追溯到需求吗？
3. **完整性**: 是否有孤立的改动（没有需求支撑）？
4. **一致性**: 相关的改动是否逻辑一致？
5. **清晰性**: 每个决策的理由是否充分？

## 输出格式

### 简化报告
```
Problem: Teaser图优化
Status: 80% Complete

需求覆盖:
✓ R1: Retain/Drop/Merge → Context (9/10)
✓ R2: Frame-Label同步 (7/10)
⚠ R3: GRPO反馈循环 (5/10)
✗ R4: Output清晰化 (0/10)
⚠ R5: Action=Final Label (4/10)

信息流: 完整 ✓
逻辑链: 完整 ✓
```

### 详细报告
见 README.md

## 高级功能

### 对比分析
```
/track-problem compare v0 v1 v2
```
显示各版本如何逐步改进

### 决策审计
```
/track-problem audit --show-alternatives
```
显示每个决策考虑了哪些替代方案

### 信息流可视化
```
/track-problem graph
```
生成Mermaid图展示信息流向

## 集成点

与其他工具集成：
- **draw.io**: 追踪图的版本和改进
- **git**: 每次迭代自动生成commit信息
- **markdown**: 自动生成文档
- **notion/文档**: 导出为可读的报告

