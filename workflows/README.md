# God Mode Workflows

These workflows are the standard procedures for the God Mode framework. They work identically whether you're:
- Using Claude Desktop with MCP (prompts auto-triggered)
- Using Claude Code in terminal (follow manually)
- Using Claude on phone/web (follow what you can, capture what you can't)

## Available Workflows

| Workflow | Purpose | Trigger Intent |
|----------|---------|----------------|
| [decision-guide](./decision-guide.md) | When to use API vs cloning, tool selection | "which tool should I use" |
| [repo-overview](./repo-overview.md) | Complete status of a single project | "status of X", "how's X" |
| [daily-standup](./daily-standup.md) | Morning check-in across all projects | "standup", "catch me up" |
| [agency-dashboard](./agency-dashboard.md) | Multi-project overview | "what are we working on" |
| [pr-review](./pr-review-workflow.md) | Review a pull request | "review PR #X" |
| [issue-triage](./issue-triage-workflow.md) | Organize and prioritize issues | "organize the issues" |
| [release](./release-workflow.md) | Create a new release | "let's release X" |
| [project-intake](./project-intake.md) | Onboard new client project | "new project" |
| [worker-delegation](./worker-delegation.md) | Create and assign a task | "create task for dev" |

## How to Use

### With MCP (Claude Desktop)
Workflows are triggered automatically via prompts. Just express the intent.

### Without MCP (Claude Code, Phone, Web)
1. Open the relevant workflow markdown
2. Follow the steps manually
3. Use available tools (git, file editing, etc.)
4. Capture tasks you can't complete as issues or notes

## Graceful Degradation

| Environment | Full Access | Partial Access | Capture Mode |
|-------------|-------------|----------------|--------------|
| Claude Desktop + MCP | All tools + prompts | - | - |
| Claude Code | Git, files, bash | No gh CLI prompts | Use file edits |
| Claude Mobile | Git, files | No GitHub API | Capture in files |
| Claude Web | Chat only | - | Log decisions in chat |

**Principle:** Never block, always capture. If you can't do something, document it for later.
