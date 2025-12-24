#!/bin/bash
# Orchestrator Script - "One Brain, 10 Arms" System
# Version: 1.0.0
# Purpose: Manage task delegation and worker coordination

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
WORK_PLAN="$PROJECT_ROOT/WORK-PLAN.md"
TASKS_DIR="$PROJECT_ROOT/tasks"
RESULTS_DIR="$PROJECT_ROOT/results"
CLAUDE_MD="$PROJECT_ROOT/CLAUDE.md"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }

# Banner
show_banner() {
    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║         🧠 ONE BRAIN, 10 ARMS ORCHESTRATOR 💪           ║"
    echo "║                                                           ║"
    echo "║         Brain: Claude Orchestrator                        ║"
    echo "║         Arms: Worker Sessions                             ║"
    echo "║         Memory: GitHub Repository                         ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""
}

# Initialize directory structure
init_structure() {
    log_info "Initializing orchestration structure..."

    mkdir -p "$TASKS_DIR"
    mkdir -p "$RESULTS_DIR"
    mkdir -p "$PROJECT_ROOT/docs/architecture"
    mkdir -p "$PROJECT_ROOT/docs/guides"
    mkdir -p "$PROJECT_ROOT/docs/decisions"

    if [[ ! -f "$CLAUDE_MD" ]]; then
        log_warning "CLAUDE.md not found. Creating template..."
        cat > "$CLAUDE_MD" << EOF
# $(basename "$PROJECT_ROOT")

[Project description - 2-3 sentences]

**Stack:** [List technologies]

**Conventions:**
- [Key coding standards]
- [File organization]

**Documentation:**
- Architecture: @docs/architecture/
- Contributing: @CONTRIBUTING.md
EOF
        log_success "Created CLAUDE.md template"
    fi

    if [[ ! -f "$WORK_PLAN" ]]; then
        log_warning "WORK-PLAN.md not found. Creating template..."
        cat > "$WORK_PLAN" << EOF
# Work Plan

**Project:** $(basename "$PROJECT_ROOT")
**Updated:** $(date '+%Y-%m-%d')

## Task Queue

### 🟢 Ready to Start

(Tasks will be added here)

### 🟡 In Progress

(Active tasks)

### ✅ Completed

(Completed tasks)
EOF
        log_success "Created WORK-PLAN.md template"
    fi

    log_success "Structure initialized"
}

# Create a new task
create_task() {
    local task_id="$1"
    local task_title="$2"

    if [[ -z "$task_id" ]] || [[ -z "$task_title" ]]; then
        log_error "Usage: orchestrator.sh create-task <task-id> <task-title>"
        exit 1
    fi

    local task_file="$TASKS_DIR/task-${task_id}.md"

    if [[ -f "$task_file" ]]; then
        log_error "Task $task_id already exists!"
        exit 1
    fi

    log_info "Creating Task-${task_id}: ${task_title}..."

    cat > "$task_file" << EOF
# Task-${task_id}: ${task_title}

**Created:** $(date '+%Y-%m-%d %H:%M')
**Status:** Pending
**Priority:** Medium
**Estimate:** [Hours]

---

## Objective

[Clear description of what needs to be done]

---

## Acceptance Criteria

- [ ] [Specific outcome 1]
- [ ] [Specific outcome 2]
- [ ] [Specific outcome 3]

---

## Context Needed

- @CLAUDE.md
- @docs/architecture/[relevant-doc].md

---

## Output Required

- [File or component to create]
- [Tests to write]
- Documentation in results/task-${task_id}-output.md

---

## Notes

[Any additional information or considerations]
EOF

    log_success "Created $task_file"
    log_info "Next steps:"
    log_info "1. Edit $task_file to fill in details"
    log_info "2. Add task to WORK-PLAN.md"
    log_info "3. Commit and push"
    log_info "4. Spawn worker for this task"
}

# Check task status
check_status() {
    log_info "Checking task status across system...\n"

    # Count tasks
    local total_tasks=$(ls -1 "$TASKS_DIR" 2>/dev/null | wc -l)
    local completed_tasks=$(ls -1 "$RESULTS_DIR"/*-output.md 2>/dev/null | wc -l)
    local in_progress=0
    local blocked=0

    # Check for blockers
    if ls "$RESULTS_DIR"/*-blocker.md >/dev/null 2>&1; then
        blocked=$(ls -1 "$RESULTS_DIR"/*-blocker.md 2>/dev/null | wc -l)
    fi

    # Calculate in-progress (has status file but no output file)
    for status_file in "$RESULTS_DIR"/*-status.md; do
        if [[ -f "$status_file" ]]; then
            local task_id=$(basename "$status_file" | sed 's/-status.md//')
            if [[ ! -f "$RESULTS_DIR/${task_id}-output.md" ]]; then
                ((in_progress++))
            fi
        fi
    done 2>/dev/null

    echo "📊 Task Overview"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Total tasks:      $total_tasks"
    echo "Completed:        $completed_tasks"
    echo "In progress:      $in_progress"
    echo "Blocked:          $blocked"
    echo "Ready to start:   $((total_tasks - completed_tasks - in_progress - blocked))"
    echo ""

    # Show recent activity
    if [[ -d "$RESULTS_DIR" ]]; then
        echo "📋 Recent Activity"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

        # Show recently updated status files
        for status_file in $(ls -t "$RESULTS_DIR"/*-status.md 2>/dev/null | head -5); do
            if [[ -f "$status_file" ]]; then
                local task_name=$(basename "$status_file" .md)
                local last_update=$(grep "Last updated:" "$status_file" 2>/dev/null | head -1)
                local status=$(grep "Status:" "$status_file" 2>/dev/null | head -1)

                echo "  $task_name"
                [[ -n "$last_update" ]] && echo "    $last_update"
                [[ -n "$status" ]] && echo "    $status"
                echo ""
            fi
        done

        # Show blockers if any
        if [[ $blocked -gt 0 ]]; then
            echo "🚨 Blocked Tasks (Require Brain Attention)"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            for blocker_file in "$RESULTS_DIR"/*-blocker.md; do
                if [[ -f "$blocker_file" ]]; then
                    local task_name=$(basename "$blocker_file" -blocker.md)
                    echo "  $task_name"
                    local issue=$(grep "Issue:" "$blocker_file" 2>/dev/null | head -1)
                    [[ -n "$issue" ]] && echo "    $issue"
                    echo ""
                fi
            done
        fi
    fi

    # Show last git commits
    echo "📜 Recent Commits"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    cd "$PROJECT_ROOT"
    git log --oneline --pretty=format:"  %C(yellow)%h%C(reset) %s %C(green)(%cr)%C(reset)" -n 5
    echo -e "\n"
}

# Review task results
review_task() {
    local task_id="$1"

    if [[ -z "$task_id" ]]; then
        log_error "Usage: orchestrator.sh review <task-id>"
        exit 1
    fi

    local output_file="$RESULTS_DIR/task-${task_id}-output.md"
    local status_file="$RESULTS_DIR/task-${task_id}-status.md"

    if [[ ! -f "$output_file" ]]; then
        log_error "Task-${task_id} output not found. Has worker completed it?"
        exit 1
    fi

    log_info "Reviewing Task-${task_id}...\n"

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    cat "$output_file"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    if [[ -f "$status_file" ]]; then
        echo "Status:"
        cat "$status_file"
        echo ""
    fi

    read -p "Approve this task? (y/n): " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_success "Task-${task_id} approved!"
        log_info "Remember to:"
        log_info "1. Update WORK-PLAN.md (move to Completed)"
        log_info "2. Commit and push"
        log_info "3. Consider spawning worker for next task"
    else
        log_warning "Task-${task_id} not approved."
        log_info "Provide feedback to worker by:"
        log_info "1. Updating tasks/task-${task_id}.md with requested changes"
        log_info "2. Creating results/task-${task_id}-feedback.md"
        log_info "3. Commit and push - worker can see changes"
    fi
}

# Generate worker bootstrap instructions
generate_worker_instructions() {
    local task_id="$1"

    if [[ -z "$task_id" ]]; then
        log_error "Usage: orchestrator.sh worker-instructions <task-id>"
        exit 1
    fi

    local task_file="$TASKS_DIR/task-${task_id}.md"

    if [[ ! -f "$task_file" ]]; then
        log_error "Task-${task_id} not found!"
        exit 1
    fi

    local repo_url=$(git remote get-url origin 2>/dev/null || echo "[YOUR-REPO-URL]")

    log_info "Worker bootstrap instructions for Task-${task_id}:\n"

    cat << EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WORKER BOOTSTRAP INSTRUCTIONS - Task-${task_id}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You are a worker session in the orchestration system.
Your job: Execute Task-${task_id} exactly as specified.

📋 Step 1: Clone Repository
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
git clone ${repo_url}
cd $(basename "$PROJECT_ROOT")

📖 Step 2: Read Core Memory
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
cat CLAUDE.md

🎯 Step 3: Read Your Task
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
cat tasks/task-${task_id}.md
cat docs/WORKER-PROTOCOL.md

🚀 Step 4: Execute Task
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Follow the protocol in WORKER-PROTOCOL.md:

1. Create status file:
   echo "Status: Started" > results/task-${task_id}-status.md
   git add results/ && git commit -m "task-${task_id}: Started" && git push

2. Execute task (commit frequently every 30 min)

3. Create output file when complete:
   Create comprehensive results/task-${task_id}-output.md

4. Final commit:
   git add results/ WORK-PLAN.md
   git commit -m "task-${task_id}: COMPLETE - Ready for review"
   git push origin main

5. Exit session (you are disposable)

📚 Important Files
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- Your task: tasks/task-${task_id}.md
- Your output: results/task-${task_id}-output.md (you create)
- Your status: results/task-${task_id}-status.md (you update)
- Protocol: docs/WORKER-PROTOCOL.md (read this!)

⚠️ Remember
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- Commit frequently (every 30 min)
- Ask brain if unclear (create blocker file)
- Stay within task scope
- Quality over speed
- You are stateless and disposable

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Copy these instructions to your worker session to begin.

EOF
}

# Health check
health_check() {
    log_info "Running system health check...\n"

    echo "🔍 System Health"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Check required files
    if [[ -f "$CLAUDE_MD" ]]; then
        log_success "CLAUDE.md exists"
    else
        log_error "CLAUDE.md missing!"
    fi

    if [[ -f "$WORK_PLAN" ]]; then
        log_success "WORK-PLAN.md exists"
    else
        log_error "WORK-PLAN.md missing!"
    fi

    if [[ -d "$TASKS_DIR" ]]; then
        log_success "tasks/ directory exists"
    else
        log_warning "tasks/ directory missing (will create)"
    fi

    if [[ -d "$RESULTS_DIR" ]]; then
        log_success "results/ directory exists"
    else
        log_warning "results/ directory missing (will create)"
    fi

    # Check git status
    cd "$PROJECT_ROOT"
    if git rev-parse --git-dir > /dev/null 2>&1; then
        log_success "Git repository initialized"

        local branch=$(git rev-parse --abbrev-ref HEAD)
        echo "  Current branch: $branch"

        local uncommitted=$(git status -s | wc -l)
        if [[ $uncommitted -eq 0 ]]; then
            log_success "No uncommitted changes"
        else
            log_warning "$uncommitted uncommitted changes"
            echo "  Run: git status"
        fi

        # Check remote
        if git remote get-url origin > /dev/null 2>&1; then
            local remote_url=$(git remote get-url origin)
            log_success "Remote configured: $remote_url"
        else
            log_warning "No remote repository configured"
        fi
    else
        log_error "Not a git repository!"
    fi

    echo ""

    # Check auto-backup daemon
    if [[ -f "/tmp/auto-save-daemon.pid" ]]; then
        local pid=$(cat /tmp/auto-save-daemon.pid)
        if ps -p "$pid" > /dev/null 2>&1; then
            log_success "Auto-backup daemon running (PID: $pid)"
        else
            log_warning "Auto-backup daemon not running (stale PID file)"
        fi
    else
        log_warning "Auto-backup daemon not running"
        log_info "Start with: bash .claude/session-start-hook.sh"
    fi

    echo ""
}

# Show usage
usage() {
    cat << EOF
Usage: orchestrator.sh <command> [options]

Commands:
  init                           Initialize orchestration structure
  create-task <id> <title>       Create new task
  status                         Check overall task status
  review <task-id>               Review completed task
  worker-instructions <task-id>  Generate worker bootstrap instructions
  health                         Run system health check
  help                           Show this help message

Examples:
  orchestrator.sh init
  orchestrator.sh create-task 001 "Build homepage hero section"
  orchestrator.sh status
  orchestrator.sh review 001
  orchestrator.sh worker-instructions 001
  orchestrator.sh health

Documentation:
  - Architecture: docs/ORCHESTRATION-ARCHITECTURE.md
  - Worker Protocol: docs/WORKER-PROTOCOL.md
  - Work Plan: WORK-PLAN.md

EOF
}

# Main command dispatcher
main() {
    show_banner

    case "${1:-help}" in
        init)
            init_structure
            ;;
        create-task)
            create_task "$2" "$3"
            ;;
        status)
            check_status
            ;;
        review)
            review_task "$2"
            ;;
        worker-instructions)
            generate_worker_instructions "$2"
            ;;
        health)
            health_check
            ;;
        help|--help|-h)
            usage
            ;;
        *)
            log_error "Unknown command: $1"
            echo ""
            usage
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
