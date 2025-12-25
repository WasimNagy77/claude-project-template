# God Mode Framework - AI Instructions

**Note:** This file contains AI-specific instructions. For the main entry point, see [README.md](./README.md).

## Quick Start

1. Read [README.md](./README.md) - the universal entry point
2. Read [SESSION-LOG.md](./SESSION-LOG.md) - what was done, what's next
3. Based on your role, read [BRAIN.md](./BRAIN.md) or [WORKER.md](./WORKER.md)

## Which Role Are You?

### Brain (Claude Desktop with MCP)
You orchestrate work across projects. Read:
1. [BRAIN.md](./BRAIN.md) - Your full instructions
2. [PROJECTS.md](./PROJECTS.md) - Active projects list
3. [workflows/](./workflows/) - Available workflows

### Worker (Claude Code)
You execute specific tasks. Read:
1. [WORKER.md](./WORKER.md) - Your protocol
2. Find your assigned issue in GitHub
3. Follow the task instructions

### Limited Environment (Mobile/Web)
You can still help! See [Graceful Degradation](#graceful-degradation) below.

## Key Files

### Role Instructions
| File | Purpose |
|------|---------|
| [BRAIN.md](./BRAIN.md) | Instructions for orchestrator |
| [WORKER.md](./WORKER.md) | Instructions for workers |
| [USER.md](./USER.md) | Human operator role definition |

### Project Management
| File | Purpose |
|------|---------|
| [README.md](./README.md) | Project overview (human entry point) |
| [CLAUDE.md](./CLAUDE.md) | This file (AI entry point) |
| [SESSION-LOG.md](./SESSION-LOG.md) | Session history and continuity |
| [PROJECTS.md](./PROJECTS.md) | Active projects registry |
| [SETUP.md](./SETUP.md) | Installation guide |

### Protocols
| File | Purpose |
|------|---------|
| [SYNC-PROTOCOL.md](./SYNC-PROTOCOL.md) | Source of truth rules |
| [HANDOFF-PROTOCOL.md](./HANDOFF-PROTOCOL.md) | Environment transitions |
| [RECOVERY.md](./RECOVERY.md) | Session death recovery |
| [CONFLICT-RESOLUTION.md](./CONFLICT-RESOLUTION.md) | Multi-worker conflicts |
| [NOTIFICATIONS.md](./NOTIFICATIONS.md) | Communication system |

### Reference
| File | Purpose |
|------|---------|
| [GLOSSARY.md](./GLOSSARY.md) | Standard terminology |
| [TESTING.md](./TESTING.md) | Framework testing procedures |
| [workflows/](./workflows/) | All 11 workflow guides |

## Workflows

These are in `workflows/` folder and also available as MCP prompts:

| Workflow | Trigger | Use For |
|----------|---------|---------|
| [repo-overview](./workflows/repo-overview.md) | "status of X" | Check a project |
| [daily-standup](./workflows/daily-standup.md) | "catch me up" | Morning check-in |
| [agency-dashboard](./workflows/agency-dashboard.md) | "all projects" | Multi-project view |
| [worker-delegation](./workflows/worker-delegation.md) | "create task" | Assign work |
| [project-intake](./workflows/project-intake.md) | "new project" | Onboard client |
| [pr-review](./workflows/pr-review-workflow.md) | "review PR" | Review code |
| [issue-triage](./workflows/issue-triage-workflow.md) | "organize issues" | Clean up issues |
| [release](./workflows/release-workflow.md) | "create release" | Ship a version |
| [decision-guide](./workflows/decision-guide.md) | "which tool" | Tool selection |
| [escalation](./workflows/escalation.md) | "blocked" | Handle blockers |
| [sprint-planning](./workflows/sprint-planning.md) | "plan sprint" | Plan work periods |

## Graceful Degradation

The framework works everywhere, with different capability levels:

| Environment | Level | Has | Missing |
|-------------|-------|-----|---------|
| Claude Desktop + MCP | Full | All tools, prompts | - |
| Claude Code | Partial | Git, files, bash | GitHub API |
| Claude Mobile | Partial | Git, files, bash | GitHub API |
| Claude Web | Minimal | Chat only | Everything else |

**Principle:** Never block, always capture.

If you can't complete something, document it for later:
```markdown
## Pending Actions
- [ ] Create issue: [title]
- [ ] Review PR #X
- [ ] Update project board
```

## Continuous Saving

Sessions die unexpectedly. Always:
1. Commit after every file change
2. Push every 2-3 commits
3. Update SESSION-LOG.md with progress
4. If session died now, would next session know what to do?

## Related Repos

| Repo | Purpose |
|------|---------|
| [claude-project-template](https://github.com/WasimNagy77/claude-project-template) | This framework |
| [github-full-mcp](https://github.com/WasimNagy77/github-full-mcp) | The MCP engine |
| [agency](https://github.com/WasimNagy77/agency) | Brainstorming project |
| [nail-candy-website](https://github.com/WasimNagy77/nail-candy-website) | Client project |
