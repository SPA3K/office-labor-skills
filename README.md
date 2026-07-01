# 牛马 Skills

Claude Code 跨设备 skills 同步仓库。包含代码撰写、行业调研、报告撰写、PPT 生成、可视化图素生成等能力。

## Quick Start

```bash
git clone git@github.com:<you>/numa-skills.git ~/claude-skills
cd ~/claude-skills && bash install.sh
```

`install.sh` 会将 `skills/` 和 `rules/` 以 symlink 方式链接到 `~/.claude/`，修改即生效。

## 目录结构

```
claude-skills/
├── skills/                 # 所有 skill（symlink 到 ~/.claude/skills/）
│   ├── _local/             # 原有本地 skill（39 个，不链接）
│   ├── humanizer/          # AI 文本人性化
│   ├── gstack/             # 全栈开发框架
│   ├── serenity-skill/     # 代码质量审查
│   ├── frontend-slides/    # 前端幻灯片生成
│   ├── Mck-ppt-design-skill/ # McKinsey 风格 PPT
│   ├── codex-ppt/          # PPT 生成
│   ├── hyperframes/        # 视频/动画生成（19 个子 skill）
│   ├── marketingskills/    # 营销全链路（44 个子 skill）
│   ├── scientific-agent-skills/ # 科研工具链（150+ 个子 skill）
│   ├── taste-skill/        # 设计审美（14 个子 skill）
│   ├── react-doctor/       # React 诊断 + 代码质量（12 个子 skill）
│   ├── codegraph/          # 代码图谱分析
│   ├── obscura/            # 代码混淆/安全
│   ├── product-strategy/   # 产品策略画布
│   ├── swot-analysis/      # SWOT 分析
│   └── ...                 # 共 348 个 skill
├── rules/                  # 编码规则（symlink 到 ~/.claude/rules/ecc/）
│   ├── common/             # 通用规则（10 个）
│   ├── python/             # Python 规则（6 个）
│   ├── cpp/                # C++ 规则（5 个）
│   └── web/                # Web 前端规则（7 个）
├── tools/                  # 独立 CLI 工具（需手动安装）
│   ├── headroom/           # AI 代码审查（Docker）
│   ├── openclacky/         # 开发环境管理（Ruby gem）
│   ├── codegraph/          # 代码依赖图谱（standalone binary）
│   └── autoresearch/       # Karpathy 自动研究（Python）
├── install.sh              # 安装脚本
└── README.md
```

## Skill 来源

| 来源 | Repo | 内容 | 数量 |
|------|------|------|------|
| **local** | 本地积累 | 代码设计、TDD、Obsidian 等 | 39 |
| **humanizer** | blader/humanizer | AI 文本人性化改写 | 1 |
| **gstack** | garrytan/gstack | 全栈开发框架 | 1 |
| **serenity** | muxuuu/serenity-skill | 代码审查与质量 | 1 |
| **frontend-slides** | zarazhangrui/frontend-slides | 前端幻灯片/演示 | 1 |
| **Mck-ppt** | likaku/Mck-ppt-design-skill | McKinsey 风格 PPT 设计 | 1 |
| **codex-ppt** | ningzimu/codex-ppt-skill | PPT 自动生成 | 1 |
| **hyperframes** | heygen-com/hyperframes | 视频/动画/动态图形 | 19 |
| **marketingskills** | coreyhaines31/marketingskills | 营销全链路（SEO/广告/邮件等） | 44 |
| **scientific** | K-Dense-AI/scientific-agent-skills | 科研工具链（生物/化学/ML/统计） | 150+ |
| **taste** | Leonxlnx/taste-skill | 设计审美/风格迁移 | 14 |
| **react-doctor** | millionco/react-doctor | React 代码诊断 | 12 |
| **codegraph** | colbymchenry/codegraph | 代码依赖图谱 | 2 |
| **obscura** | h4ckf0r0day/obscura | 代码混淆/安全 | 1 |
| **pm-skills** | phuryn/pm-skills | PM 全链路（策略/发现/执行/GTM） | 69 |
| **headroom** | headroomlabs-ai/headroom | AI 代码审查 CLI | tool |
| **openclacky** | clacky-ai/openclacky | 开发环境管理 | tool |
| **autoresearch** | karpathy/autoresearch | 自动化研究 | tool |

## Standalone Tools

以下工具需要单独安装，`install.sh` 会提示是否执行：

### Headroom (AI 代码审查)
```bash
bash tools/headroom/install.sh
# 需要 Docker
```

### OpenClacky (开发环境)
```bash
bash tools/openclacky/install.sh
# 需要 Ruby >= 2.6
```

### CodeGraph (代码图谱)
```bash
bash tools/codegraph/install.sh
# 自下载 standalone binary，无需 Node.js
```

### AutoResearch (自动研究)
```bash
cd tools/autoresearch
pip install uv
uv sync
uv run python prepare.py
```

## 更新

```bash
cd ~/claude-skills
git pull
# symlink 自动生效，无需重新 install
```

## 添加新 Skill

```bash
# 1. 将 skill 目录复制到 skills/
cp -r /path/to/my-skill ~/claude-skills/skills/

# 2. 提交
cd ~/claude-skills
git add skills/my-skill && git commit -m "feat: add my-skill" && git push
```

## 卸载

```bash
bash install.sh uninstall
```

会移除所有指向本仓库的 symlink，保留 `*.bak.*` 备份。
