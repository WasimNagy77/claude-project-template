# Daily Standup

Quick morning status check across all active projects.

**Trigger:** "standup", "what's happening today", "catch me up", "morning check"

## Parameters
- **repos**: Comma-separated list of repo names (e.g., "nail-candy-website,agency")
- **owner**: Repository owner (e.g., WasimNagy77)

## For Each Project

### 1. What was done yesterday?
Use `github_list_commits` with since=[yesterday's date ISO format]
Use `github_list_issues` with state="closed" and since=[yesterday]

**Without MCP:**
```bash
git log --since="yesterday" --oneline
gh issue list -s closed --json number,title,closedAt
```

### 2. What's in progress?
Use `github_list_issues` with labels="status:in-progress"

**Without MCP:** `gh issue list -l "status:in-progress"`

### 3. What's blocked?
Use `github_list_issues` with labels="status:blocked"

**Without MCP:** `gh issue list -l "status:blocked"`

### 4. PRs needing review?
Use `github_list_pull_requests` with state="open"

**Without MCP:** `gh pr list -s open`

### 5. CI Status?
Use `github_list_workflow_runs` with per_page=3
Check for conclusion="failure"

**Without MCP:** `gh run list -L 3`

## Output Format

```
☀️ DAILY STANDUP - {Date}

📊 YESTERDAY'S PROGRESS
[Project 1]
  - Commits: X
  - Issues closed: Y
  - {Brief summary}

[Project 2]
  - ...

🔄 IN PROGRESS TODAY
[Project 1]
  - Issue #X: {title} (assigned to: {dept})
  - Issue #Y: {title}

[Project 2]
  - ...

❌ BLOCKED
- [Project] Issue #X: {reason}
- [Project] Issue #Y: {reason}

📝 PRs TO REVIEW
- [Project] PR #X: {title} (open X hours)
- [Project] PR #Y: {title}

🔴 CI FAILURES
- [Project]: {workflow name} failed

💡 TODAY'S PRIORITIES
1. {Priority 1}
2. {Priority 2}
3. {Priority 3}
```

## Suggested Actions
Based on the standup:
1. Merge PRs that are approved
2. Unblock blocked issues
3. Review open PRs
4. Fix CI failures
5. Delegate new work if workers are idle

## Without GitHub Access (Mobile/Web)

Read from repo files instead:
1. Check STATUS.md for current state
2. Check SESSION-LOG.md for recent activity
3. Note any updates to bring back later:

```markdown
## Standup Notes - {Date}
Things to check when back at desktop:
- [ ] Check PR status on {project}
- [ ] Review issue #{X}
```
