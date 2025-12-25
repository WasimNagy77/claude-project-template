# Repository Overview Workflow

Get a comprehensive overview of a repository's current state.

**Trigger:** "status of X", "how's X", "check X project"

## Parameters
- **owner**: Repository owner (e.g., WasimNagy77)
- **repo**: Repository name (e.g., nail-candy-website)

## Steps

### Step 1: Get Repository Info
Use `github_get_repository` to get:
- Description, stars, forks
- Default branch
- Language and topics
- Open issues count

**Without MCP:** `gh repo view {owner}/{repo}`

### Step 2: Recent Activity
Use `github_list_commits` (limit 10) to see recent commits

**Without MCP:** `git log --oneline -10` or `gh api repos/{owner}/{repo}/commits?per_page=10`

### Step 3: Open Issues Summary
Use `github_list_issues` with state="open" and per_page=10

**Without MCP:** `gh issue list -s open -L 10`

### Step 4: Open Pull Requests
Use `github_list_pull_requests` with state="open"

**Without MCP:** `gh pr list -s open`

### Step 5: Latest Release
Use `github_get_latest_release` to see current version

**Without MCP:** `gh release view --json tagName,publishedAt`

### Step 6: Milestones
Use `github_list_milestones` to see:
- Current phase/milestone progress
- Open vs closed issues per milestone
- Upcoming due dates

**Without MCP:** `gh api repos/{owner}/{repo}/milestones`

### Step 7: CI/CD Status
Use `github_list_workflow_runs` with per_page=5 to see recent runs

**Without MCP:** `gh run list -L 5`

### Step 8: Repository Structure
Use `github_get_tree` with tree_sha="HEAD" to see file structure

**Without MCP:** `ls -la` or `tree` command

## Output Format

```
📊 REPO OVERVIEW: {owner}/{repo}

📝 DESCRIPTION
{description}

📈 STATS
- Stars: X | Forks: Y | Issues: Z
- Language: {language}
- Last commit: {date}

📋 OPEN ISSUES (X total)
1. #{num}: {title} [{labels}]
2. ...

🔄 OPEN PRs (X total)
1. #{num}: {title} by {author}
2. ...

🏷️ LATEST RELEASE
{tag} - {date}

📅 MILESTONES
- {milestone}: X/Y issues complete

✅ CI STATUS
{status} - Last run: {date}
```

## Without Any GitHub Access

If you only have file access (mobile, web):
1. Read STATUS.md for current state
2. Read SESSION-LOG.md for recent activity
3. Update these files with any observations
