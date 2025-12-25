# God Mode: The Complete AI Agency Workflow

**Version:** 2.0.0
**Created:** December 25, 2025
**Status:** Design Complete - Ready for Implementation

---

## Vision

**"One command to rule them all"**

The God Mode workflow is where:
- Claude Desktop IS the Brain (strategic orchestrator)
- Claude Code sessions ARE the Arms (parallel workers)
- GitHub IS the nervous system (memory, tasks, communication)
- The 13 agents ARE specialized departments
- Everything is automated, tracked, and recoverable

**Result:** You say "build me a website for X" and the system:
1. Intakes the project
2. Creates the repo
3. Breaks down into tasks
4. Assigns to specialized agents
5. Monitors progress
6. Reviews output
7. Delivers to client

---

## System Components

### 1. The Brain (Claude Desktop)

**Environment:** Claude Desktop with MCPs
**MCPs Required:**
- `github-full` (40+ tools, 5 prompts)
- `filesystem` (local file access)

**Capabilities:**
| Function | How |
|----------|-----|
| Read any repo | `github_get_file_contents`, `github_get_tree` |
| Create tasks | `github_create_issue` with agent labels |
| Assign work | `github_update_issue` with assignees |
| Monitor progress | `github_list_commits`, `github_list_workflow_runs` |
| Review PRs | `github_get_pull_request`, `github_create_pr_review` |
| Merge work | `github_merge_pull_request` |
| Release | `github_create_release` |
| Full overview | `repo-overview` prompt |

**The Brain's Job:**
- Strategic planning
- Task decomposition
- Delegation to workers
- Quality control
- Client communication
- Decision making

### 2. The Arms (Claude Code Workers)

**Environment:** Claude Code terminal sessions (or async subagents)
**Number:** Unlimited (spawn as needed)

**Worker Types (13 Departments):**

| Department | Agent | Label | Focus |
|------------|-------|-------|-------|
| **CORE** | strategy | `dept:strategy` | Requirements, planning |
| | design | `dept:design` | UI/UX, visual |
| | content | `dept:content` | Copy, SEO content |
| | dev | `dept:dev` | Frontend, backend |
| | security | `dept:security` | Auth, encryption, headers |
| **QUALITY** | qa | `dept:qa` | Testing, bugs |
| | audit | `dept:audit` | Code review, standards |
| **SPECIALIST** | seo | `dept:seo` | Search optimization |
| | analytics | `dept:analytics` | Tracking, metrics |
| | devops | `dept:devops` | CI/CD, deployment |
| **SUPPORT** | assets | `dept:assets` | Images, media |
| | client | `dept:client` | Communication |
| | docs | `dept:docs` | Documentation |

**Worker Lifecycle:**
```
1. Brain creates issue with dept label
2. Human (or automation) spawns Claude Code
3. Worker reads CLAUDE.md + assigned issue
4. Worker executes task
5. Worker creates PR with results
6. Brain reviews and merges
7. Worker session ends (disposable)
```

### 3. The Nervous System (GitHub)

**Repository Structure:**
```
project-repo/
├── CLAUDE.md              # Core memory (lean, <500 lines)
├── SESSION-LOG.md         # Session history
├── STATUS.md              # Current state
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   └── task.md        # Standard task format
│   └── workflows/
│       └── ci.yml         # Auto-tests on PR
├── tasks/                 # Detailed task definitions
├── results/               # Worker outputs
├── docs/                  # Project documentation
└── src/                   # Source code
```

**GitHub as Task Queue:**
- Issues = Tasks
- Labels = Agent assignment + priority + status
- Milestones = Sprints/phases
- Projects = Kanban board
- PRs = Completed work for review

**Label System:**
```
# Agent Assignment
dept:strategy, dept:design, dept:content, dept:dev, dept:security
dept:qa, dept:audit, dept:seo, dept:analytics, dept:devops
dept:assets, dept:client, dept:docs

# Priority
priority:critical, priority:high, priority:medium, priority:low

# Status
status:ready, status:in-progress, status:blocked, status:review

# Type
type:feature, type:bug, type:refactor, type:docs
```

---

## The 5 Built-in Prompts (from GitHub MCP)

| Prompt | When Brain Uses It |
|--------|-------------------|
| `decision-guide` | Deciding API vs clone, tool selection |
| `repo-overview` | Starting work on any project |
| `issue-triage-workflow` | Organizing tasks, assigning agents |
| `pr-review-workflow` | Reviewing worker submissions |
| `release-workflow` | Shipping completed milestones |

---

## NEW PROMPTS NEEDED

### 6. `agency-dashboard`
**Purpose:** Multi-project overview for the agency

```markdown
# Agency Dashboard

## Active Projects
For each repo in the agency:
1. Use github_list_issues with state="open"
2. Count by label (dept:*, priority:*, status:*)
3. Check github_list_pull_requests for pending reviews

## Summary View
| Project | Open Tasks | In Progress | Blocked | PRs to Review |
|---------|------------|-------------|---------|---------------|
| nail-candy | X | Y | Z | N |
| agency | X | Y | Z | N |
| client-1 | X | Y | Z | N |

## Attention Needed
- Issues with priority:critical
- Issues with status:blocked
- PRs older than 24 hours
- Failed workflow runs
```

### 7. `project-intake`
**Purpose:** Onboard new client project

```markdown
# Project Intake Workflow

## Step 1: Create Repository
Use github_create_repository with:
- name: [client-project-name]
- private: true
- auto_init: true

## Step 2: Initialize Structure
Create files using github_create_or_update_file:
- CLAUDE.md (from template)
- SESSION-LOG.md
- STATUS.md
- .github/ISSUE_TEMPLATE/task.md

## Step 3: Create Milestone
Use github_create_milestone for Phase 1

## Step 4: Create Initial Issues
Based on project scope, create issues for:
- dept:strategy - Requirements gathering
- dept:design - Design system setup
- dept:dev - Project scaffold

## Step 5: Update Agency Dashboard
Add project to tracked repos list
```

### 8. `worker-delegation`
**Purpose:** Create and assign task to worker

```markdown
# Worker Delegation Workflow

## Step 1: Define Task
Create issue with github_create_issue:
- Title: Clear, actionable
- Body: Context, acceptance criteria, files to read
- Labels: dept:[agent], priority:[level], status:ready

## Step 2: Add to Project Board
Use add_item_to_project to add to kanban

## Step 3: Create Task File (optional for complex tasks)
Use github_create_or_update_file to create tasks/task-XXX.md

## Step 4: Notify for Worker Spawn
Update STATUS.md with:
- Task ready for worker
- Instructions to spawn Claude Code
- Context for worker

## Step 5: Monitor
Watch for:
- Commits from worker
- PR creation
- Status updates
```

### 9. `daily-standup`
**Purpose:** Quick morning status check

```markdown
# Daily Standup

## For each active project:

### What was done yesterday?
- github_list_commits with since=yesterday
- github_list_issues with state="closed" and since=yesterday

### What's in progress?
- github_list_issues with labels="status:in-progress"

### What's blocked?
- github_list_issues with labels="status:blocked"

### PRs needing review?
- github_list_pull_requests with state="open"

### Failed CI?
- github_list_workflow_runs with status="failure"

## Summary
Compile into daily status report
```

---

## God Mode Workflows

### Workflow 1: New Project Intake

```
User: "New project - coffee shop website for Bean Scene"

Brain (Claude Desktop):
1. Uses `project-intake` prompt
2. Creates repo: WasimNagy77/bean-scene-website
3. Initializes with CLAUDE.md, STATUS.md, SESSION-LOG.md
4. Creates Phase 1 milestone
5. Creates initial issues:
   - #1: [strategy] Requirements gathering
   - #2: [design] Visual direction
   - #3: [content] Copy inventory
   - #4: [dev] Project setup
6. Updates agency dashboard
7. Reports to user: "Project created. 4 tasks ready. Spawn workers?"
```

### Workflow 2: Daily Operations

```
User: "Morning standup"

Brain (Claude Desktop):
1. Uses `daily-standup` prompt on all active projects
2. Reports:
   - nail-candy: 1 PR ready to merge, 0 blocked
   - bean-scene: 3 tasks in progress, 1 blocked (waiting on assets)
   - agency: All good
3. Suggests: "Should I merge nail-candy PR #21?"
```

### Workflow 3: Task Delegation

```
User: "Bean Scene needs a booking system"

Brain (Claude Desktop):
1. Breaks down into subtasks:
   - [dev] Calendar component
   - [dev] Booking API
   - [dev] Confirmation emails
   - [design] Booking UX
   - [qa] Booking tests
2. Uses `worker-delegation` for each
3. Creates 5 issues with proper labels
4. Reports: "5 tasks created. Ready for parallel execution. Spawn workers?"

User: "Yes, spawn dev workers"

Brain:
1. Updates STATUS.md with worker instructions
2. User opens Claude Code sessions
3. Workers pull tasks, execute, create PRs
4. Brain monitors via commits/PRs
```

### Workflow 4: PR Review & Merge

```
[Worker completes task, creates PR]

Brain (Claude Desktop):
1. Gets notified (or checks periodically)
2. Uses `pr-review-workflow` prompt
3. Reviews:
   - Code changes
   - Tests pass?
   - Meets acceptance criteria?
4. Either:
   - Approves and merges
   - Requests changes with comments
5. Updates project board
6. Closes related issue
```

### Workflow 5: Release

```
User: "Bean Scene Phase 1 is done, release it"

Brain (Claude Desktop):
1. Uses `release-workflow` prompt
2. Checks all Phase 1 issues closed
3. Creates release v1.0.0
4. Generates release notes from PRs
5. Triggers deploy workflow (if configured)
6. Updates STATUS.md
7. Notifies: "Phase 1 released. Live at bean-scene.vercel.app"
```

---

## Integration Points

### Claude Desktop ↔ Claude Code

**Brain delegates via:**
1. Creates GitHub issue with full context
2. Updates STATUS.md with "Worker needed for issue #X"
3. User spawns Claude Code session
4. Worker reads CLAUDE.md → STATUS.md → Issue
5. Worker executes, creates PR
6. Brain reviews via GitHub

**Future automation:**
- API to spawn Claude Code sessions automatically
- Webhook to notify Brain when PR is ready
- Full autonomous loop

### 13 Agents ↔ GitHub

Each agent is a specialized worker that:
1. Reads its department's issues (`dept:dev`, `dept:design`, etc.)
2. Has specialized CLAUDE.md context for its domain
3. Creates PRs with standardized format
4. Updates results/ with outputs

**Agent Activation:**
```bash
# In Claude Code, to activate as specific agent:
"I am the dev-agent. Show me my assigned issues."
# Worker uses github_list_issues with labels="dept:dev,status:ready"
```

### MCP Prompts ↔ Workflow

| Workflow Step | MCP Prompt Used |
|---------------|-----------------|
| Start of day | `daily-standup` (new) |
| New project | `project-intake` (new) |
| Check project | `repo-overview` |
| Organize tasks | `issue-triage-workflow` |
| Delegate work | `worker-delegation` (new) |
| Review PR | `pr-review-workflow` |
| Ship milestone | `release-workflow` |
| Multi-project view | `agency-dashboard` (new) |

---

## Files to Create/Update

### 1. BRAIN.md (for Claude Desktop)
Master instructions for the Brain role

### 2. Update GitHub MCP
Add the 4 new prompts:
- agency-dashboard
- project-intake
- worker-delegation
- daily-standup

### 3. WORKER.md (for Claude Code)
Standard instructions for all workers

### 4. Agent-specific CLAUDE.md templates
13 templates, one per department

### 5. GitHub Issue Template
Standard format for tasks

### 6. Update ORCHESTRATION-ARCHITECTURE.md
Reflect MCP integration

---

## Success Metrics

**God Mode is achieved when:**

- [ ] Brain (Desktop) can manage multiple projects simultaneously
- [ ] Workers (Code) can be spawned and execute independently
- [ ] All work is tracked in GitHub (zero work lost)
- [ ] PRs are reviewed and merged via Brain
- [ ] Releases ship via Brain command
- [ ] New project intake takes <5 minutes
- [ ] Daily standup takes <2 minutes
- [ ] Any session crash has zero impact (work in GitHub)
- [ ] 50-100 projects/year is feasible

---

## Implementation Order

1. **Create BRAIN.md** - Brain's operating manual
2. **Add 4 prompts to MCP** - New workflows
3. **Create issue template** - Standardize tasks
4. **Create WORKER.md** - Worker instructions
5. **Update agent files** - Add GitHub integration
6. **Test with real project** - Agency website or test client
7. **Iterate and refine**

---

## The God Mode Command

When everything is set up, your morning workflow:

```
Open Claude Desktop

You: "Good morning. Standup."

Brain:
"Good morning! Here's your agency status:

📊 ACTIVE PROJECTS (3)

1. nail-candy-website
   ✅ 95% complete
   ⏳ 1 task remaining (email DNS)
   📝 1 PR ready to merge (#21)

2. agency
   🔄 Brainstorming phase
   📋 7 topics to explore

3. bean-scene (example)
   🚧 Phase 1 in progress
   ✅ 4/8 tasks complete
   🔄 2 in progress
   ❌ 1 blocked (waiting on logo)
   📝 2 PRs ready to review

🚨 NEEDS ATTENTION
- bean-scene #5 blocked 2 days
- nail-candy PR #21 ready to merge

💡 SUGGESTED ACTIONS
1. Merge nail-candy PR #21
2. Unblock bean-scene #5 (need logo from client)
3. Review bean-scene PRs #8, #9

What would you like to do?"

You: "Merge nail-candy PR and review bean-scene PRs"

Brain: [executes via GitHub MCP]
"Done:
✅ Merged nail-candy PR #21 - Vercel auto-deploying
📝 Reviewing bean-scene PR #8...
   - Calendar component looks good
   - Tests passing
   - Approving and merging
✅ Merged
📝 Reviewing bean-scene PR #9...
   [continues]"
```

**This is God Mode.**

---

**Next:** Implement this architecture.
