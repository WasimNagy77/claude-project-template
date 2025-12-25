# Glossary - God Mode Terminology

Standard terms used throughout the God Mode framework. Use these consistently.

---

## Roles

| Term | Definition | Also Known As |
|------|------------|---------------|
| **Brain** | Claude Desktop with MCP. Orchestrates work. | Orchestrator, Manager |
| **Worker** | Claude Code in terminal. Executes tasks. | Agent, Claude Code |
| **User** | Human operator (Wasim). Makes decisions. | Owner, Operator |
| **Department** | Specialized worker type (dev, design, etc.) | Agent Type |

---

## Artifacts

| Term | Definition | Location |
|------|------------|----------|
| **Issue** | A task in GitHub Issues. | GitHub |
| **PR** | Pull Request. Code submission for review. | GitHub |
| **Milestone** | Group of issues for a release/phase. | GitHub |
| **Branch** | Git branch for feature work. | Git |
| **Commit** | Saved code change. | Git |

---

## Files

| Term | Definition | Purpose |
|------|------------|---------|
| **CLAUDE.md** | AI entry point for any project. | Instructions for Claude |
| **BRAIN.md** | Instructions for Brain role. | How to orchestrate |
| **WORKER.md** | Instructions for Worker role. | How to execute |
| **STATUS.md** | Project status summary. | Quick reference |
| **SESSION-LOG.md** | Session history and continuity. | Context recovery |
| **PROJECTS.md** | Active projects registry. | Multi-project management |

---

## States

### Issue States

| Term | Label | Meaning |
|------|-------|---------|
| **Ready** | `status:ready` | Can be worked on |
| **In Progress** | `status:in-progress` | Worker is working on it |
| **Blocked** | `status:blocked` | Cannot proceed |
| **In Review** | `status:in-review` | PR submitted, awaiting review |
| **Done** | (closed) | Completed and merged |

### PR States

| Term | Meaning |
|------|---------|
| **Open** | Awaiting review |
| **Changes Requested** | Needs fixes |
| **Approved** | Ready to merge |
| **Merged** | Complete |
| **Closed** | Rejected/abandoned |

---

## Actions

| Term | Definition | Who Does It |
|------|------------|-------------|
| **Delegate** | Create task and assign to department | Brain |
| **Execute** | Work on a task | Worker |
| **Review** | Check PR quality | Brain |
| **Merge** | Combine PR into main | Brain |
| **Escalate** | Flag issue for help | Worker |
| **Approve** | Give go-ahead | User or Brain |
| **Release** | Ship a version | Brain + User |

---

## Workflows

| Term | Definition |
|------|------------|
| **Standup** | Daily check-in across all projects |
| **Triage** | Organizing and prioritizing issues |
| **Sprint** | Time-boxed work period (usually weekly) |
| **Intake** | Onboarding a new project |
| **Handoff** | Transferring work between environments |
| **Recovery** | Resuming after session death |

---

## Environments

| Term | Definition | Capabilities |
|------|------------|--------------|
| **Full** | Claude Desktop + MCP | All GitHub API + files |
| **Partial** | Claude Code / Mobile | Git + files, no GitHub API |
| **Minimal** | Claude Web | Chat only |

---

## Labels

### Department Labels

| Label | Meaning |
|-------|---------|
| `dept:strategy` | Strategy/planning work |
| `dept:design` | UI/UX design work |
| `dept:content` | Content/copy work |
| `dept:dev` | Development work |
| `dept:security` | Security work |
| `dept:qa` | Testing work |
| `dept:audit` | Code review work |
| `dept:seo` | SEO work |
| `dept:analytics` | Analytics work |
| `dept:devops` | DevOps work |
| `dept:assets` | Media/assets work |
| `dept:client` | Client communication |
| `dept:docs` | Documentation work |

### Priority Labels

| Label | Meaning |
|-------|---------|
| `priority:critical` | Must be done immediately |
| `priority:high` | Important, do soon |
| `priority:medium` | Normal priority |
| `priority:low` | Nice to have |

### Status Labels

| Label | Meaning |
|-------|---------|
| `status:ready` | Ready to be worked on |
| `status:in-progress` | Currently being worked on |
| `status:blocked` | Cannot proceed |
| `status:in-review` | Awaiting review |

### Special Labels

| Label | Meaning |
|-------|---------|
| `escalation:needed` | Needs attention |
| `escalation:ci-failing` | CI keeps failing |
| `needs:decision` | User decision required |
| `needs:review` | Awaiting PR review |

---

## Abbreviations

| Abbrev | Full Term |
|--------|-----------|
| PR | Pull Request |
| CI | Continuous Integration |
| MCP | Model Context Protocol |
| API | Application Programming Interface |
| LGTM | Looks Good To Me (approval) |
| WIP | Work In Progress |
| ETA | Estimated Time of Arrival |

---

## Usage Examples

### Correct Usage

- "Brain, create an issue for the dev department"
- "Worker is blocked on issue #42"
- "PR #15 is in review"
- "Session died, need to recover"
- "Escalate this to the user"

### Incorrect Usage

- ~~"Manager"~~ → Use "Brain"
- ~~"Agent"~~ → Use "Worker" or "Department"
- ~~"Bug ticket"~~ → Use "Issue"
- ~~"Code request"~~ → Use "PR"
- ~~"Wasim's approval"~~ → Use "User approval"
