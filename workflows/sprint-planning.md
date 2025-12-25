# Sprint & Milestone Planning Workflow

When to use: Planning work for the next period (week, sprint, milestone).

---

## Planning Cadence

| Timeframe | Planning Activity |
|-----------|-------------------|
| Daily | Standup (what's happening today) |
| Weekly | Sprint review + planning |
| Milestone | Major feature/release planning |

---

## Weekly Sprint Planning

### Step 1: Review Last Week

```
For each active project:
1. github_list_issues(owner, repo, state="closed", since="7 days ago")
2. Compile: What was completed?
3. Check: What rolled over?
```

**Summary Template:**
```markdown
## Week of [date] Review

### Completed
- [x] Issue #1: Description
- [x] Issue #2: Description

### Rolled Over
- [ ] Issue #3: Description (blocked by X)

### Metrics
- Issues closed: X
- PRs merged: X
- Lines changed: X
```

### Step 2: Assess Capacity

Determine how much can be done:

| Factor | Impact |
|--------|--------|
| Available worker sessions | How many tasks parallel? |
| Task complexity | Simple (1 session) vs Complex (3+ sessions) |
| Dependencies | What must happen first? |
| User availability | For decisions/reviews |

### Step 3: Prioritize Backlog

Review open issues and rank:

```
github_list_issues(owner, repo, state="open", labels="status:ready")
```

**Priority Criteria:**
1. **Blocking other work** → Highest
2. **Client deadline** → High
3. **User requested** → High
4. **Technical debt** → Medium
5. **Nice to have** → Low

### Step 4: Assign to Sprint

Create or update milestone:

```
github_create_milestone(
  owner, repo,
  title: "Sprint [date range]",
  due_on: "[end date]"
)

github_update_issue(
  owner, repo, issue_number,
  milestone: [milestone_number]
)
```

### Step 5: Document Sprint

```markdown
## Sprint [date range]

### Goals
1. Complete [feature/task]
2. Fix [bugs]
3. Review [items]

### Issues in Sprint
| Issue | Priority | Assigned | Status |
|-------|----------|----------|--------|
| #1 | High | dept:dev | Ready |
| #2 | High | dept:design | Ready |
| #3 | Medium | dept:qa | Ready |

### Dependencies
- #2 blocked by #1
- #3 needs #1 and #2 done first

### Risks
- [Potential risk and mitigation]
```

---

## Milestone Planning

For larger features or releases.

### Step 1: Define Milestone Scope

```markdown
## Milestone: [Name]

### Objective
What this milestone delivers

### Success Criteria
- [ ] Feature X works
- [ ] Tests pass
- [ ] Documentation complete

### Out of Scope
- Feature Y (next milestone)
- Optimization Z (later)
```

### Step 2: Break Down into Issues

Each milestone should have:
- Strategy/planning issue
- Design issue(s)
- Development issue(s)
- QA issue(s)
- Documentation issue

### Step 3: Create GitHub Milestone

```
github_create_milestone(
  owner, repo,
  title: "[Phase] [Name]",
  description: "[objective and success criteria]",
  due_on: "[target date]"
)
```

### Step 4: Assign Issues to Milestone

```
github_update_issue(
  owner, repo, issue_number,
  milestone: [milestone_number]
)
```

### Step 5: Track Progress

Check milestone progress in standup:

```
github_get_milestone(owner, repo, milestone_number)
```

Shows: open issues, closed issues, progress percentage

---

## Planning Templates

### Sprint Planning Document

```markdown
# Sprint Planning - [Date Range]

## Previous Sprint Review
- Velocity: X issues completed
- Blockers: [any systemic issues]
- Wins: [what went well]

## This Sprint

### Capacity
- Worker sessions available: X
- Days: X
- Estimated issues: X

### Priorities
1. [Priority 1]
2. [Priority 2]
3. [Priority 3]

### Sprint Backlog
[Table of issues]

### Definition of Done
- Code reviewed and merged
- Tests passing
- Documentation updated
- Issue closed
```

### Milestone Planning Document

```markdown
# Milestone: [Name]

## Overview
- **Target Date:** [date]
- **Owner:** [who is responsible]
- **Status:** Planning | In Progress | Complete

## Objectives
1. [Objective 1]
2. [Objective 2]

## Issues
| Issue | Dept | Priority | Status |
|-------|------|----------|--------|
| #1 | strategy | High | Done |
| #2 | design | High | In Progress |
| #3 | dev | High | Ready |

## Dependencies
[Diagram or list of dependencies]

## Risks
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [risk] | Medium | High | [mitigation] |

## Timeline
- Week 1: Design
- Week 2-3: Development
- Week 4: QA and Launch
```

---

## Labels for Planning

| Label | Purpose |
|-------|---------|
| `priority:critical` | Must be done first |
| `priority:high` | Important |
| `priority:medium` | Normal |
| `priority:low` | Nice to have |
| `sprint:current` | In current sprint |
| `sprint:next` | Planned for next sprint |
| `sprint:backlog` | Not yet scheduled |

---

## Planning Checklist

### Weekly (Every Monday or First Day of Week)

- [ ] Review last week's completed issues
- [ ] Update rolled-over issues
- [ ] Prioritize backlog
- [ ] Assign issues to sprint milestone
- [ ] Document sprint goals
- [ ] Inform user of plan

### Per Milestone

- [ ] Define scope and success criteria
- [ ] Break down into issues
- [ ] Create GitHub milestone
- [ ] Assign all issues
- [ ] Set target date
- [ ] Track progress in standups

---

## Quick Commands

```
# Create sprint milestone
github_create_milestone(owner, repo, title="Sprint 2025-W01", due_on="2025-01-07")

# Add issue to sprint
github_update_issue(owner, repo, 42, milestone=1)

# Check sprint progress
github_get_milestone(owner, repo, 1)

# List sprint issues
github_list_issues(owner, repo, milestone=1)
```
