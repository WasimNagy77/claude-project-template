# Agency Dashboard

Multi-project overview for managing an AI web agency with multiple client projects.

**Trigger:** "what are we working on", "agency status", "all projects"

## Parameters
- **repos**: Comma-separated list of repo names (e.g., "nail-candy-website,agency,client-project")
- **owner**: Repository owner (e.g., WasimNagy77)

## For Each Repository

### Step 1: Get Project Status
For each repo, use:
1. `github_get_repository(owner, repo)`
2. `github_list_issues(owner, repo, state="open")`
3. `github_list_pull_requests(owner, repo, state="open")`
4. `github_list_workflow_runs(owner, repo, per_page=3)`

**Without MCP:**
```bash
gh repo view {owner}/{repo} --json name,description
gh issue list -R {owner}/{repo} -s open
gh pr list -R {owner}/{repo} -s open
gh run list -R {owner}/{repo} -L 3
```

### Step 2: Compile Summary Table
Create a table like:

| Project | Open Tasks | In Progress | Blocked | PRs to Review | CI Status |
|---------|------------|-------------|---------|---------------|-----------|
| repo-1  | X          | Y           | Z       | N             | ✅/❌     |
| repo-2  | ...        | ...         | ...     | ...           | ...       |

### Step 3: Identify Issues by Label
For each repo, filter issues by:
- `priority:critical` - URGENT attention needed
- `status:blocked` - Need to unblock
- `status:in-progress` - Currently being worked on

### Step 4: Check PRs Needing Review
List PRs older than 24 hours waiting for review

### Step 5: Check Failed CI
Look for workflow runs with conclusion="failure"

## Output Format

```
📊 AGENCY DASHBOARD - {Date}

ACTIVE PROJECTS: {count}

[Project 1]
  Status: X% complete
  Open: Y tasks | In Progress: Z | Blocked: N
  PRs to review: N
  CI: ✅ passing / ❌ failing

[Project 2]
  Status: X% complete
  ...

🚨 NEEDS ATTENTION
- {Critical items}
- {Blocked items}
- {Overdue PRs}

💡 SUGGESTED ACTIONS
1. {Action 1}
2. {Action 2}
```

## Project Registry

Instead of hardcoding repos, check PROJECTS.md:

```markdown
# Active Projects

| Project | Repo | Phase | Priority |
|---------|------|-------|----------|
| Nail Candy | nail-candy-website | Development | High |
| Agency | agency | Brainstorming | Medium |
```

## Without GitHub Access

If limited to file access:
1. Read PROJECTS.md for list of projects
2. For each project, read its STATUS.md
3. Compile summary from file-based status
4. Note items to check when full access available
