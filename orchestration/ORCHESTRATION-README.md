# Orchestration System - Quick Start

**"One brain, 10 arms" - thinking is centralized, execution is distributed**

---

## 🎯 What Is This?

A complete system for managing AI-powered web development with:
- **Brain:** Claude orchestrator (you, making strategic decisions)
- **Arms:** Worker sessions (executing tasks in parallel)
- **Memory:** GitHub repository (persistent, reliable)
- **Communication:** Work plan and task files

**Result:** 3-5x faster development, survives session failures, scales infinitely.

---

## 🔄 Choose Your Workflow

**The system supports both Agile and Waterfall - you decide.**

### ✅ Agile (Recommended for Client Work)
- Work in 1-2 week sprints
- Ship something live every sprint
- Get client feedback early and often
- Lower risk, better client satisfaction

### Waterfall (Use Sparingly)
- Plan all tasks upfront
- Deliver at end
- Use only for internal projects or locked requirements

**Your actual pattern across 4 sessions was naturally Agile** with incremental builds and iteration cycles.

**See:** `docs/ORCHESTRATION-ARCHITECTURE.md` for detailed comparison.

---

## 🚀 Quick Start (5 Minutes)

### Step 1: Initialize System

```bash
# Run orchestrator setup
bash .claude/orchestrator.sh init

# Check health
bash .claude/orchestrator.sh health
```

### Step 2: Create Your First Task

```bash
# Create task
bash .claude/orchestrator.sh create-task 001 "Build homepage hero section"

# Edit task file with details
nano tasks/task-001.md

# Add to work plan
nano WORK-PLAN.md
# (Add Task-001 to "Ready to Start" section)

# Commit
git add tasks/ WORK-PLAN.md
git commit -m "Add Task-001: Homepage hero"
git push origin main
```

### Step 3: Spawn Worker

```bash
# Get worker instructions
bash .claude/orchestrator.sh worker-instructions 001

# Copy output to new Claude Code session
# Worker will bootstrap and execute task
```

### Step 4: Monitor Progress

```bash
# Check status
bash .claude/orchestrator.sh status

# Pull latest from workers
git pull origin main
```

### Step 5: Review Results

```bash
# When worker completes
bash .claude/orchestrator.sh review 001

# If approved, update work plan
nano WORK-PLAN.md
# (Move Task-001 to "Completed")

git add WORK-PLAN.md
git commit -m "Approve Task-001"
git push origin main
```

---

## 📚 Documentation

**Essential reading:**
1. **ORCHESTRATION-ARCHITECTURE.md** - Complete system design
2. **WORKER-PROTOCOL.md** - How workers operate
3. **WORK-PLAN.md** - Active task queue

**Supporting docs:**
- AUTO-BACKUP-SYSTEM.md (zero-token backup)
- ENVIRONMENT-SETUP.md (cloud vs PC vs GitHub)
- SESSION-RELIABILITY-GUIDE.md (data loss prevention)

---

## 🎮 Orchestrator Commands

```bash
# Initialize structure
bash .claude/orchestrator.sh init

# Create new task
bash .claude/orchestrator.sh create-task <id> <title>

# Check task status
bash .claude/orchestrator.sh status

# Review completed task
bash .claude/orchestrator.sh review <task-id>

# Generate worker bootstrap
bash .claude/orchestrator.sh worker-instructions <task-id>

# Health check
bash .claude/orchestrator.sh health

# Help
bash .claude/orchestrator.sh help
```

---

## 🧬 Memory Structure

```
project/
├── CLAUDE.md                    # Core memory (lean, <500 lines)
├── WORK-PLAN.md                 # Task queue & status
├── tasks/                       # Task definitions
│   ├── task-001.md
│   └── task-002.md
├── results/                     # Worker outputs
│   ├── task-001-output.md
│   ├── task-001-status.md
│   └── task-001-screenshots/
├── docs/                        # Knowledge base (loaded on-demand)
│   ├── architecture/
│   ├── guides/
│   └── decisions/
└── .claude/
    ├── orchestrator.sh          # Brain commands
    ├── auto-save-daemon.sh      # Background backup
    └── session-start-hook.sh    # Auto-start daemon
```

---

## 💪 Example Workflow

**User (to Brain):** "I need a contact form on the website"

**Brain:**
1. Breaks down into tasks:
   - Task-010: UI component
   - Task-011: API endpoint
   - Task-012: Email integration
2. Creates task files in `tasks/`
3. Updates WORK-PLAN.md
4. Commits and pushes

**Brain spawns 2 workers in parallel:**
- Worker-1: Task-010 (UI)
- Worker-2: Task-011 (API)

**Workers:**
1. Clone repo
2. Read CLAUDE.md (core memory)
3. Read assigned task
4. Load necessary docs
5. Execute task
6. Commit frequently
7. Deliver results
8. Exit

**Brain:**
1. Pulls latest commits
2. Reviews results
3. Approves or requests changes
4. Spawns Worker-3 for Task-012
5. Continues until complete

**Result:** Contact form delivered in hours, not days.

---

## ✅ Success Criteria

You're using the system correctly when:
- ✅ Workers execute tasks independently
- ✅ All work tracked in repo (not session memory)
- ✅ Session hangs don't block progress
- ✅ Can spawn unlimited parallel workers
- ✅ Brain reviews quality before approval
- ✅ Recovery from failure takes <5 minutes

---

## 🚨 Troubleshooting

### "Worker can't find task"
```bash
# Ensure task is committed and pushed
git add tasks/
git commit -m "Add task definition"
git push origin main

# Worker needs to pull
git pull origin main
```

### "Results not showing up"
```bash
# Pull from GitHub (workers push there)
git pull origin main

# Check results directory
ls -la results/
```

### "Auto-backup not running"
```bash
# Start daemon
bash .claude/session-start-hook.sh

# Check status
ps aux | grep auto-save-daemon
tail -f /tmp/auto-save-daemon.log
```

### "Worker doesn't understand task"
```bash
# Worker creates blocker file
# Check: results/task-XXX-blocker.md

# Update task with clarification
nano tasks/task-XXX.md
git commit -m "task-XXX: Add clarification"
git push

# Worker pulls and continues
```

---

## 🎓 Best Practices

**For the Brain:**
- Keep CLAUDE.md under 500 lines
- Create clear, self-contained tasks
- Review worker outputs promptly
- Use stable environment (PC, not sessions)

**For Workers:**
- Read CLAUDE.md first (always)
- Load only task-specific context
- Commit every 30 minutes
- Ask brain when unclear

**For the System:**
- GitHub is single source of truth
- Commit and push frequently
- Workers are stateless
- Brain makes all strategic decisions

---

## 🎯 Next Steps

1. **Read full architecture:**
   - docs/ORCHESTRATION-ARCHITECTURE.md

2. **Test with sample task:**
   - Create simple task (e.g., "Add README section")
   - Spawn worker manually
   - Complete workflow end-to-end

3. **Build real feature:**
   - Break down user requirement
   - Create 3-5 tasks
   - Spawn multiple workers
   - Experience parallel execution

4. **Integrate into workflow:**
   - Use for all client projects
   - Train team members
   - Document learnings

---

## 📈 Benefits

**Speed:**
- 3-5x faster with parallel workers
- No waiting for sequential tasks

**Reliability:**
- Session hangs don't lose work
- Auto-backup every 5 minutes
- Recover in <5 minutes

**Scalability:**
- Spawn unlimited workers
- Each task is independent
- Brain stays focused

**Quality:**
- Brain reviews all work
- Consistent standards
- Professional delivery

---

**You now have a bulletproof system for AI-powered web development.** 🚀

**Start delegating!**
