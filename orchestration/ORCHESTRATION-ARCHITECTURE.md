# One Brain, 10 Arms: Claude Orchestration Architecture

**Version:** 2.0.0
**Created:** December 23, 2025
**Updated:** December 25, 2025
**Status:** God Mode Ready

---

## What's New in v2.0

### GitHub MCP Integration
- **9 prompts** (5 original + 4 new) for guided workflows
- **40+ tools** for full GitHub control
- Brain (Claude Desktop) can now orchestrate directly via GitHub API

### New Prompts Added
| Prompt | Purpose |
|--------|---------|
| `agency-dashboard` | Multi-project status overview |
| `project-intake` | Onboard new client projects |
| `worker-delegation` | Create and assign tasks |
| `daily-standup` | Morning status check |

### New Files
- `BRAIN.md` - Master instructions for Claude Desktop as Brain
- `WORKER.md` - Standard instructions for all workers
- `GOD-MODE-ARCHITECTURE.md` - Complete workflow design

---

## 🎯 Vision

**"One brain I give the project to we can talk about brainstorming and when it comes to execution this brain delegate to other sessions tools, agents, whatever it takes"**

### What This Solves

**The Problem:**
- Claude sessions are unreliable (hang, corrupt, reset)
- Can't trust sessions for production client work
- Need scalable execution without session limitations
- One session can't handle massive parallel workloads

**The Solution:**
- **Brain:** Claude orchestrator (strategic planning, delegation)
- **Arms:** Worker sessions/agents (parallel execution)
- **Memory:** Repo-based Custom Memory System (persistent, reliable)
- **Communication:** GitHub (task queue, results, state)

**Result:** Reliable, scalable AI web development that can handle client projects professionally.

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    ORCHESTRATOR (Brain)                      │
│                                                              │
│  - Claude in stable environment (PC or persistent VM)       │
│  - Strategic planning & brainstorming                       │
│  - Task decomposition & delegation                          │
│  - Progress monitoring & quality control                    │
│  - Client communication & decisions                         │
│                                                              │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       │ (Commits to GitHub)
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    GITHUB REPOSITORY                         │
│                                                              │
│  Memory System:                                              │
│  ├── CLAUDE.md (core project memory)                        │
│  ├── WORK-PLAN.md (task queue & assignments)                │
│  ├── docs/ (knowledge base, loaded on-demand)               │
│  ├── tasks/ (individual task definitions)                   │
│  └── results/ (worker outputs & status)                     │
│                                                              │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       │ (Workers pull tasks)
                       │
        ┌──────────────┼──────────────┬──────────────┐
        │              │              │              │
        ▼              ▼              ▼              ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│  Worker 1    │ │  Worker 2    │ │  Worker 3    │ │  Worker N    │
│              │ │              │ │              │ │              │
│  Task:       │ │  Task:       │ │  Task:       │ │  Task:       │
│  Build UI    │ │  Write Tests │ │  API Routes  │ │  Deploy      │
│              │ │              │ │              │ │              │
│  Stateless   │ │  Stateless   │ │  Stateless   │ │  Stateless   │
│  Ephemeral   │ │  Ephemeral   │ │  Ephemeral   │ │  Ephemeral   │
└──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘
```

---

## 🔄 Methodology: Agile vs Waterfall

**The orchestration system is methodology-agnostic** - you choose how to use it.

### ✅ Agile (Recommended for Client Work)

**Work in sprints (1-2 weeks):**
- Plan 3-5 tasks per sprint
- Ship something live every sprint
- Get client feedback early and often
- Adjust based on real usage

**Benefits:**
- Lower risk (client sees progress weekly)
- Easier to pivot if requirements change
- Faster time-to-first-value
- Can charge per milestone
- Better client satisfaction

**Use when:**
- Building for external clients
- Requirements may evolve
- Need to show progress early
- Want incremental payments

### Waterfall (Use Sparingly)

**Plan all tasks upfront:**
- Define complete scope at start
- Build everything sequentially
- Deliver at end

**Use only when:**
- Internal project (you control everything)
- Requirements are 100% locked
- Fixed-price, no-changes contract

**Warning:** High risk for client work - feedback comes too late.

### Evidence from Session Extractions

Your actual work pattern across 4 sessions was **naturally Agile**:
- Session 1: "Incremental building without overwhelming initial scope"
- Session 4: "Multiple design iteration cycles with client feedback"
- Session 4: "3 rounds on colors, 2 rounds on share buttons - this is the process"

**Recommendation:** Use Agile sprints with weekly demos to clients.

---

## 🧠 Brain: Orchestrator Role

### Primary Responsibilities

**1. Strategic Planning**
- Brainstorm with user on project vision
- Break down client requirements into tasks (sprint-by-sprint for Agile)
- Identify dependencies and priorities
- Make architectural decisions

**2. Task Delegation**
- Create task definitions in `tasks/`
- Assign tasks to workers in WORK-PLAN.md
- Provide each task with necessary context
- Set acceptance criteria and deadlines

**3. Progress Monitoring**
- Check `results/` for worker outputs
- Validate completed work against criteria
- Handle blockers and errors
- Report status to user

**4. Quality Control**
- Review worker outputs
- Run integration tests
- Ensure consistency across tasks
- Final approval before delivery

**5. Client Interface**
- Communicate with user (the business owner)
- Make decisions requiring judgment
- Handle ambiguity and edge cases
- Maintain project vision

### Brain Environment

**Stable options:**
1. **User's PC** (`/home/wasim/`)
   - Most stable
   - Direct file access
   - No session timeouts
   - Can run 24/7

2. **Persistent Cloud VM**
   - Always-on environment
   - SSH access
   - Not ephemeral like sessions
   - More reliable than sessions

3. **Container (Docker)**
   - Reproducible environment
   - Version controlled
   - Can run locally or cloud
   - Easy to restart if needed

**NOT recommended:**
- ❌ Claude Code web sessions (ephemeral, unreliable)
- ❌ Phone-based sessions (temporary)

---

## 💪 Arms: Worker Sessions

### Worker Characteristics

**Stateless:**
- No memory between tasks
- Repo is single source of truth
- Each task starts fresh

**Ephemeral:**
- Created for one task
- Destroyed when done
- Can hang/fail without project impact
- Easily replaced

**Specialized:**
- Each worker handles one task type
- Frontend, backend, testing, deployment, etc.
- Can run in parallel
- Independent execution

### Worker Lifecycle

```bash
1. CREATE
   - Spin up new Claude Code session
   - Or launch agent with specific prompt

2. BOOTSTRAP
   git clone <repo>
   cd <project>
   # Read CLAUDE.md (core memory)
   # Read WORK-PLAN.md (find assigned task)

3. LOAD CONTEXT
   # Read task definition: tasks/task-123.md
   # Load only relevant docs (on-demand)
   # Example: @docs/api-architecture.md

4. EXECUTE
   # Complete the assigned task
   # Follow acceptance criteria
   # Commit progress frequently (auto-backup)

5. DELIVER
   # Write results to results/task-123-output.md
   # Update WORK-PLAN.md status
   # Commit and push
   git add .
   git commit -m "task-123: Complete API endpoints"
   git push origin main

6. TERMINATE
   # Exit session
   # Worker is disposable
```

### Worker Protocol

**Required files for each task:**
```
tasks/task-123.md          # Task definition
results/task-123-output.md # Worker output
results/task-123-status.md # Status updates
```

**Worker must:**
- ✅ Read CLAUDE.md on startup (core memory)
- ✅ Read assigned task from WORK-PLAN.md
- ✅ Load only necessary docs (not everything)
- ✅ Commit frequently (leverage auto-backup)
- ✅ Write output to results/
- ✅ Update status before exiting
- ❌ Never make strategic decisions (ask brain)
- ❌ Never change architecture without approval

---

## 🧬 Custom Memory System

Based on Anthropic's best practices for Claude Memory.

### Memory Hierarchy

```
CLAUDE.md (Root - Core Memory)
├── Project overview (2-3 sentences)
├── Tech stack (bullet points)
├── Key conventions (coding style, naming)
└── Import references to detailed docs

docs/ (Knowledge Base - Loaded On-Demand)
├── architecture/
│   ├── frontend-structure.md
│   ├── backend-api.md
│   └── database-schema.md
├── guides/
│   ├── contributing.md
│   ├── testing-strategy.md
│   └── deployment-process.md
└── decisions/
    ├── 001-framework-choice.md
    └── 002-state-management.md

tasks/ (Task Definitions)
├── task-001-user-auth.md
├── task-002-product-catalog.md
└── task-003-checkout-flow.md

WORK-PLAN.md (Active Task Queue)
├── Pending tasks
├── In-progress assignments
└── Completed tasks
```

### CLAUDE.md Design Principles

**Keep It Lean:**
```markdown
# Nail Candy Website

E-commerce website for nail salon with booking system.

**Stack:** Next.js 14, TypeScript, Tailwind, Vercel

**Conventions:**
- Components in `components/` (PascalCase)
- API routes in `app/api/`
- Use shadcn/ui for UI components

**Documentation:**
- Architecture: @docs/architecture/
- API: @docs/api-reference.md
- Contributing: @CONTRIBUTING.md
```

**NOT This (Too Heavy):**
```markdown
# ❌ DON'T DO THIS

[10 pages of detailed architecture]
[Complete API documentation]
[Every decision ever made]
[Full code examples]

This bloats memory and slows down every session!
```

### Dynamic Context Loading

**Brain orchestrator:**
```markdown
# When creating task for worker

Task: Build user authentication

Context needed:
- @docs/architecture/auth-system.md
- @docs/security-requirements.md
- @tasks/task-001-user-auth.md

Worker will load these on-demand, not everything in repo.
```

**Worker session:**
```bash
# Worker startup script
git clone repo
cd project

# 1. Read core memory (lightweight)
cat CLAUDE.md

# 2. Read assigned task
cat WORK-PLAN.md | grep "Worker-1"
# -> Points to tasks/task-001-user-auth.md

# 3. Load only what task needs
cat docs/architecture/auth-system.md
cat docs/security-requirements.md

# Now worker has exactly what it needs, no bloat
```

### Memory Update Protocol

**Who updates what:**

| File | Brain Updates | Worker Updates | User Updates |
|------|---------------|----------------|--------------|
| CLAUDE.md | ✅ Yes | ❌ No | ✅ Yes |
| WORK-PLAN.md | ✅ Yes | ✅ Status only | ❌ No |
| tasks/*.md | ✅ Yes | ❌ No | ❌ No |
| results/*.md | ❌ No | ✅ Yes | ❌ No |
| docs/*.md | ✅ Yes | ⚠️ If needed | ✅ Yes |

**Update frequency:**
- Brain: After each delegation decision
- Workers: After each meaningful progress
- Auto-backup daemon: Every 5 minutes (automatic)

---

## 📋 WORK-PLAN.md Structure

```markdown
# Work Plan

**Project:** Nail Candy Website
**Phase:** Client Launch Preparation
**Updated:** 2025-12-23 14:30

---

## 🎯 Current Sprint

**Goal:** Deploy production-ready booking system
**Deadline:** Dec 30, 2025

---

## 📊 Task Queue

### 🔴 Blocked
- None

### 🟡 In Progress

#### Task-005: Payment Integration
**Assigned to:** Worker-3
**Started:** Dec 23, 14:00
**Status:** 60% complete
**Blocker:** Waiting for Stripe API keys from client
**Files:**
- Definition: `tasks/task-005-payment.md`
- Output: `results/task-005-output.md`
- Status: `results/task-005-status.md`

### 🟢 Ready to Start

#### Task-006: Email Notifications
**Assigned to:** Available
**Priority:** High
**Estimate:** 3 hours
**Dependencies:** None
**Context needed:**
- @docs/architecture/email-system.md
- @docs/guides/sendgrid-setup.md

#### Task-007: Mobile Responsive Fixes
**Assigned to:** Available
**Priority:** Medium
**Estimate:** 2 hours
**Dependencies:** None
**Context needed:**
- @docs/guides/mobile-testing.md

### ✅ Completed

#### Task-001: User Authentication
**Completed by:** Worker-1
**Finished:** Dec 22, 16:45
**Output:** `results/task-001-output.md`
**Status:** ✅ Approved by brain

#### Task-002: Product Catalog
**Completed by:** Worker-2
**Finished:** Dec 23, 10:30
**Output:** `results/task-002-output.md`
**Status:** ✅ Approved by brain

---

## 🚨 Issues & Blockers

### Issue-001: Stripe API Keys
**Impact:** Blocks Task-005
**Owner:** User (client communication)
**Expected resolution:** Dec 24

---

## 📈 Progress

- **Total tasks:** 15
- **Completed:** 4 (27%)
- **In progress:** 1 (7%)
- **Blocked:** 1 (7%)
- **Ready:** 9 (60%)

**On track:** ⚠️ Slightly behind (1 day)
**Action needed:** User to expedite API keys
```

---

## 🔄 Complete Workflow Example

### Scenario: User wants to add booking system

**Step 1: User → Brain (Brainstorming)**
```
User: "I need a booking system for nail appointments"

Brain: "Let's break this down:
1. Calendar UI (view available slots)
2. Appointment form (customer details)
3. Backend API (create/manage bookings)
4. Email confirmations
5. Admin dashboard

Which is highest priority?"

User: "Calendar UI first, then API"
```

**Step 2: Brain creates tasks**

Brain creates:
```
tasks/task-008-calendar-ui.md
tasks/task-009-booking-api.md
```

Updates WORK-PLAN.md:
```markdown
### 🟢 Ready to Start

#### Task-008: Calendar UI
**Priority:** High
**Estimate:** 4 hours
**Context needed:**
- @docs/architecture/booking-system.md
- @docs/design/calendar-mockup.png
```

Commits and pushes:
```bash
git add tasks/task-008-calendar-ui.md WORK-PLAN.md
git commit -m "Add Task-008: Calendar UI for booking system"
git push origin main
```

**Step 3: Spawn Worker-1**

Brain tells user: "Spawning Worker-1 for Calendar UI"

User opens new Claude Code session (or automated agent launch)

**Step 4: Worker-1 executes**

```bash
# Worker-1 startup
git clone https://github.com/user/nail-candy-website
cd nail-candy-website

# Read core memory
cat CLAUDE.md
# → "Next.js 14, TypeScript, Tailwind, shadcn/ui"

# Read work plan
cat WORK-PLAN.md | grep "Task-008"
# → Assigned to me, need to build calendar UI

# Load context
cat tasks/task-008-calendar-ui.md
cat docs/architecture/booking-system.md

# Execute task
# ... build calendar component ...
# ... write tests ...
# ... update documentation ...

# Auto-backup runs every 5 minutes (daemon)
# Commits: "WIP: Calendar component", "Add calendar tests", etc.

# Task complete, write output
cat > results/task-008-output.md << EOF
# Task-008: Calendar UI - Completed

## What was built
- Calendar component: components/BookingCalendar.tsx
- Availability logic: lib/availability.ts
- Tests: __tests__/booking-calendar.test.tsx

## How to use
import BookingCalendar from '@/components/BookingCalendar'
<BookingCalendar onSelectSlot={handleSlot} />

## Screenshots
See results/task-008-screenshots/

## Tests
✅ All 12 tests passing
EOF

# Update status
cat > results/task-008-status.md << EOF
Status: ✅ Complete
Completed: 2025-12-23 16:45
Worker: Worker-1
Time taken: 3.5 hours
Issues: None
EOF

# Update work plan
# (Change Task-008 from "In Progress" to "Pending Review")

# Final commit
git add .
git commit -m "task-008: Complete calendar UI component"
git push origin main

# Worker exits (disposable)
```

**Step 5: Brain reviews**

Brain pulls latest:
```bash
git pull origin main
```

Reads:
- `results/task-008-output.md`
- `results/task-008-status.md`
- Reviews code in `components/BookingCalendar.tsx`

Brain validates:
```markdown
✅ Meets acceptance criteria
✅ Tests passing
✅ Code quality good
✅ Documentation complete

APPROVED - Update WORK-PLAN.md to "Completed"
```

**Step 6: Next task**

Brain spawns Worker-2 for Task-009 (Booking API)

Parallel execution possible:
- Worker-2: Building API
- Worker-3: Building email system
- Worker-4: Building admin dashboard

All work independently, Brain monitors all.

---

## 🛡️ Integration with Auto-Backup System

### Brain's Daemon

**Brain environment has daemon running:**
```bash
# On brain's machine (PC or persistent VM)
bash .claude/session-start-hook.sh
# Daemon saves every 5 minutes
```

**What daemon protects:**
- Brain's work (task creation, reviews, decisions)
- WORK-PLAN.md updates
- Documentation updates
- Strategic planning notes

**Result:** Even if brain session hangs, max 5-min loss

### Worker Auto-Commits

**Workers should commit frequently:**
```bash
# Worker script includes frequent commits
git add .
git commit -m "WIP: Progress on task-008"
git push origin main

# Even if worker session dies, work is saved
```

**Best practice:**
- Worker commits every 15-30 minutes
- Or use daemon in worker session too
- Either way: work is protected

### Recovery from Session Hang

**If brain session hangs:**
1. Check GitHub for latest commits
2. Pull to local environment
3. Resume from WORK-PLAN.md
4. All context in repo (not lost in session)

**If worker session hangs:**
1. Brain checks last commit in results/
2. Spawn new worker to continue
3. New worker pulls repo, sees partial work
4. Can continue or restart task
5. No strategic context lost (that's in brain)

---

## 🎯 Best Practices

### For the Brain

**1. Minimize context bloat**
- Keep CLAUDE.md under 500 lines
- Use @references for details
- Update regularly

**2. Clear task definitions**
- Each task is self-contained
- Includes all needed context
- Has clear acceptance criteria

**3. Monitor don't micromanage**
- Workers are autonomous
- Check results, not every commit
- Trust but verify

**4. Use local/stable environment**
- Not web sessions
- PC or persistent VM
- Reliable git access

### For Workers

**1. Read core memory first**
- CLAUDE.md is foundation
- Don't skip this step

**2. Load only what's needed**
- Task tells you what to read
- Don't read entire repo
- Faster startup

**3. Commit frequently**
- Every meaningful progress
- Enable auto-backup if available
- Protect your work

**4. Write clear results**
- Document what was done
- Include how to use it
- Report any issues

### For the System

**1. GitHub is source of truth**
- Not session memory
- Not local uncommitted files
- What's pushed is what exists

**2. Stateless workers**
- Each task is independent
- Workers can be replaced
- No memory between tasks

**3. Brain makes decisions**
- Workers execute
- Ambiguity goes to brain
- Strategic choices need judgment

---

## 🚀 Getting Started

### Step 1: Setup Memory Structure

```bash
# In your project repo
mkdir -p docs/architecture docs/guides docs/decisions
mkdir -p tasks results

# Create core memory
cat > CLAUDE.md << EOF
# [Your Project Name]

[2-3 sentence description]

**Stack:** [List key technologies]

**Conventions:**
- [Key coding standards]
- [File organization]

**Documentation:**
- Architecture: @docs/architecture/
- Contributing: @CONTRIBUTING.md
EOF

# Create work plan
cat > WORK-PLAN.md << EOF
# Work Plan

**Project:** [Name]
**Phase:** [Current phase]
**Updated:** $(date)

## Task Queue

### Ready to Start
(Tasks will be added here by brain)

### Completed
(Completed tasks move here)
EOF

git add .
git commit -m "Initialize orchestration memory structure"
git push origin main
```

### Step 2: Setup Brain Environment

**Option A: Use your PC**
```bash
# On /home/wasim/
cd ~/projects
git clone <your-repo>
cd <your-repo>

# Install auto-backup daemon
mkdir -p .claude
# Copy daemon scripts from ai-web-framework

# Start daemon
bash .claude/session-start-hook.sh
```

**Option B: Use persistent VM**
```bash
# SSH into your VM
ssh user@your-vm

# Same setup as Option A
```

### Step 3: Create First Task

```bash
# Brain creates task definition
cat > tasks/task-001-homepage.md << EOF
# Task-001: Build Homepage

## Objective
Create responsive homepage with hero section and CTA

## Acceptance Criteria
- [ ] Hero with headline and image
- [ ] CTA button links to /contact
- [ ] Fully responsive (mobile, tablet, desktop)
- [ ] Lighthouse score > 90

## Context Needed
- @docs/design/homepage-mockup.png
- @docs/architecture/frontend-structure.md
- @CLAUDE.md

## Time Estimate
3 hours

## Output Required
- Component code
- Tests
- Screenshot
- Documentation in results/task-001-output.md
EOF

# Update work plan
# (Add Task-001 to "Ready to Start")

git add tasks/task-001-homepage.md WORK-PLAN.md
git commit -m "Create Task-001: Homepage"
git push origin main
```

### Step 4: Spawn Worker

**Manual (for testing):**
1. Open new Claude Code session
2. Clone repo
3. Read CLAUDE.md
4. Read WORK-PLAN.md
5. Find Task-001
6. Execute

**Automated (future):**
```bash
# Brain runs orchestrator script
bash orchestrate.sh spawn-worker task-001

# Script:
# 1. Opens new session via API
# 2. Passes bootstrap prompt
# 3. Worker auto-executes
# 4. Returns when complete
```

### Step 5: Brain Reviews Results

```bash
# Pull latest
git pull origin main

# Check output
cat results/task-001-output.md
cat results/task-001-status.md

# Review code
git log --oneline -n 5
git diff HEAD~4..HEAD

# If approved:
# Update WORK-PLAN.md (move to Completed)
git add WORK-PLAN.md
git commit -m "Approve Task-001: Homepage"
git push origin main
```

---

## 🔮 Future Enhancements

### Automated Worker Spawning

**Goal:** Brain doesn't manually open sessions

**Implementation:**
- Orchestrator script uses API to spawn sessions
- Passes bootstrap commands
- Monitors completion
- Collects results

**Benefit:** True "10 arms" parallelism

### Worker Specialization

**Different worker types:**
- Frontend Worker (UI components)
- Backend Worker (API, database)
- Testing Worker (QA, integration tests)
- Deployment Worker (CI/CD, production)

**Each has:**
- Custom CLAUDE.md context
- Specialized tools/environment
- Optimized for task type

### Intelligent Task Decomposition

**Brain uses AI to:**
- Analyze user requirement
- Auto-generate task definitions
- Estimate time and dependencies
- Suggest optimal worker assignment

**User says:** "Build e-commerce checkout"

**Brain outputs:**
```
Created 8 tasks:
- task-101: Cart UI
- task-102: Shipping form
- task-103: Payment integration
- task-104: Order confirmation
- task-105: Email receipts
- task-106: Admin order view
- task-107: Integration tests
- task-108: Deploy checkout flow

Parallel execution possible: 101, 102, 103, 106
Sequential: 104→105 (depends on 103)
Final: 107→108

Estimated total: 18 hours
With 4 workers: ~5 hours wall time
```

### Health Monitoring Dashboard

**Brain maintains:**
```markdown
## System Health

### Active Workers
- Worker-1: Task-008 (45% complete, on track)
- Worker-2: Task-009 (80% complete, ahead of schedule)
- Worker-3: Task-010 (HUNG - last commit 45 min ago)

### Actions Needed
⚠️ Worker-3 appears hung - spawn replacement?
```

**Automated recovery:**
- Detect hung workers (no commits >30 min)
- Auto-spawn replacement
- Resume from last commit

---

## 📊 Success Metrics

You have a working orchestration system when:

- ✅ Brain can delegate 5+ tasks to workers
- ✅ Workers execute independently and commit results
- ✅ Brain reviews and approves worker outputs
- ✅ Task completion time is 3-5x faster (parallel execution)
- ✅ Session hangs don't block project progress
- ✅ All work is tracked in repo (not session memory)
- ✅ Can recover from any session failure in <5 minutes
- ✅ Client projects run reliably without data loss

---

## 🎓 Learning Resources

### Custom Memory Systems

Based on research from:
- [Claude Memory: A Deep Dive](https://skywork.ai/blog/claude-memory-a-deep-dive-into-anthropics-persistent-context-solution/)
- [Manage Claude's memory - Anthropic Docs](https://docs.claude.com/en/docs/claude-code/memory)
- [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Using Claude Memory: Teams & Developers Guide](https://claude-ai.chat/blog/using-claude-memory/)
- [Managing context on the Claude Developer Platform](https://anthropic.com/news/context-management)

### Key Insights

**From Anthropic's best practices:**
1. Use file-based memory (CLAUDE.md)
2. Keep core memory lean (<500 lines)
3. Reference external docs (@docs/)
4. Load context dynamically (on-demand)
5. Regular updates as project evolves

**From our experience:**
1. GitHub is single source of truth
2. Sessions are disposable, repo is permanent
3. Auto-backup every 5 minutes (zero tokens)
4. Stateless workers scale infinitely
5. Brain makes decisions, workers execute

---

## 🎯 Summary

### The Architecture

**Brain (Orchestrator):**
- Stable environment (PC/VM, not sessions)
- Strategic planning and decisions
- Task creation and delegation
- Progress monitoring and QA
- Client communication

**Arms (Workers):**
- Ephemeral sessions/agents
- Stateless execution
- Task-specific context
- Frequent commits
- Disposable (can be replaced)

**Memory (Repo):**
- CLAUDE.md (core, lean)
- docs/ (knowledge base, on-demand)
- tasks/ (task definitions)
- WORK-PLAN.md (task queue)
- results/ (worker outputs)

**Communication (GitHub):**
- Single source of truth
- Task assignment via WORK-PLAN.md
- Results via results/ directory
- Auto-backup every 5 minutes
- Survives all session failures

### The Workflow

1. User talks to Brain (brainstorm, plan)
2. Brain creates tasks in repo
3. Brain spawns workers (parallel)
4. Workers pull, execute, commit, exit
5. Brain reviews, approves, delegates next
6. Repeat until project complete

### The Benefits

- ✅ 3-5x faster (parallel execution)
- ✅ Reliable (survives session failures)
- ✅ Scalable (spawn unlimited workers)
- ✅ Recoverable (repo is truth)
- ✅ Professional (client-ready)

---

**"One brain, 10 arms - thinking is centralized, execution is distributed"**

**Your AI web development business now has the architecture to scale.** 🚀

---

Sources:
- [Claude Memory: A Deep Dive into Anthropic's Persistent Context Solution](https://skywork.ai/blog/claude-memory-a-deep-dive-into-anthropics-persistent-context-solution/)
- [Manage Claude's memory - Anthropic](https://docs.claude.com/en/docs/claude-code/memory)
- [Effective Context Engineering for AI Agents - Anthropic](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Prompting best practices - Claude Docs](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)
- [Using Claude Memory: Teams & Developers Guide](https://claude-ai.chat/blog/using-claude-memory/)
- [Managing context on the Claude Developer Platform - Anthropic](https://anthropic.com/news/context-management)
