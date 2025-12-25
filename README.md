# God Mode Framework

**AI-Powered Project Orchestration with Claude**

A framework for running an AI agency where Claude Desktop orchestrates (Brain), Claude Code executes (Workers), and GitHub serves as permanent memory.

## The Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      GOD MODE                                │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│   ┌──────────────┐                                          │
│   │    BRAIN     │  Claude Desktop + MCP                    │
│   │  (Orchestrator)  Decides what to do                     │
│   └──────┬───────┘                                          │
│          │                                                   │
│          │ delegates via GitHub Issues                       │
│          │                                                   │
│   ┌──────▼───────┐                                          │
│   │   WORKERS    │  Claude Code instances                   │
│   │  (Executors) │  Do the actual work                      │
│   └──────┬───────┘                                          │
│          │                                                   │
│          │ reads/writes                                      │
│          │                                                   │
│   ┌──────▼───────┐                                          │
│   │    GITHUB    │  Issues, PRs, Files                      │
│   │   (Memory)   │  Source of Truth                         │
│   └──────────────┘                                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Quick Start

### For Humans
1. Clone this repo
2. Read [SETUP.md](./SETUP.md) for installation
3. Follow [BRAIN.md](./BRAIN.md) or [WORKER.md](./WORKER.md) based on your role

### For AI
Read [CLAUDE.md](./CLAUDE.md) - it will direct you based on your environment.

## Features

- **9 Workflow Prompts** - Guided procedures for common tasks
- **13 Department Agents** - Specialized roles (dev, design, security, etc.)
- **Graceful Degradation** - Works everywhere (desktop, terminal, mobile)
- **Continuous Saving** - Never lose progress
- **GitHub as Memory** - Conversations are temporary, commits are permanent

## Key Files

| File | Purpose |
|------|---------|
| [CLAUDE.md](./CLAUDE.md) | AI entry point |
| [SESSION-LOG.md](./SESSION-LOG.md) | What was done, what's next |
| [BRAIN.md](./BRAIN.md) | Instructions for orchestrator |
| [WORKER.md](./WORKER.md) | Instructions for executors |
| [PROJECTS.md](./PROJECTS.md) | Active projects registry |
| [SETUP.md](./SETUP.md) | Installation guide |
| [workflows/](./workflows/) | All 9 workflow guides |
| [agents/](./agents/) | 13 department definitions |

## Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| repo-overview | "status of X" | Check a project |
| daily-standup | "catch me up" | Morning check-in |
| agency-dashboard | "all projects" | Multi-project view |
| worker-delegation | "create task" | Assign work |
| project-intake | "new project" | Onboard client |
| pr-review | "review PR" | Code review |
| issue-triage | "organize issues" | Clean up issues |
| release | "create release" | Ship a version |
| decision-guide | "which tool" | Tool selection |

## The 13 Departments

| Category | Departments |
|----------|-------------|
| **Core** | strategy, design, content, dev, security |
| **Quality** | qa, audit |
| **Specialist** | seo, analytics, devops |
| **Support** | assets, client, docs |

Each department has a GitHub label (`dept:X`) for task assignment.

## Environment Capabilities

| Environment | Full | Partial | Capture |
|-------------|------|---------|---------|
| Claude Desktop + MCP | All tools | - | - |
| Claude Code | Git, files | No GitHub API | Files |
| Claude Mobile | Git, files | No gh CLI | STATUS.md |
| Claude Web | Read only | - | Chat |

**Principle:** Never block, always capture.

## Related Repos

| Repo | Purpose |
|------|---------|
| [github-full-mcp](https://github.com/WasimNagy77/github-full-mcp) | The MCP engine (40+ tools, 9 prompts) |
| [agency](https://github.com/WasimNagy77/agency) | Brainstorming project |
| [nail-candy-website](https://github.com/WasimNagy77/nail-candy-website) | Client project example |

## Installation

See [SETUP.md](./SETUP.md) for complete instructions.

Quick version:
```bash
# Clone the framework
git clone https://github.com/WasimNagy77/claude-project-template.git

# (Optional) Install MCP for Claude Desktop
git clone https://github.com/WasimNagy77/github-full-mcp.git
cd github-full-mcp && npm install && npm run build
```

## License

MIT

---

**Maintained by [WasimNagy77](https://github.com/WasimNagy77)**
