# PR Review Workflow

Step-by-step workflow for reviewing a pull request thoroughly.

**Trigger:** "review PR #X", "check the pull request", "any PRs to review"

## Parameters
- **owner**: Repository owner
- **repo**: Repository name
- **pull_number**: Pull request number to review

## Steps

### Step 1: Get PR Overview
Use `github_get_pull_request` to get:
- Title and description
- Changed files count
- Additions/deletions
- Merge status

**Without MCP:** `gh pr view {pull_number}`

### Step 2: Review the Changes
1. Use `github_get_pull_request` to see files changed
2. For each important file, use `github_get_file_contents` to see current state
3. Use `github_compare_commits` with base and head branches to see full diff

**Without MCP:**
```bash
gh pr diff {pull_number}
gh pr view {pull_number} --json files
```

### Step 3: Check CI Status
1. Use `github_list_workflow_runs` filtered by the PR's head branch
2. Verify all checks pass

**Without MCP:** `gh pr checks {pull_number}`

### Step 4: Review Comments
Use `github_list_pr_comments` to see existing discussion

**Without MCP:** `gh pr view {pull_number} --comments`

### Step 5: Add Your Review
Choose one:
- **Approve**: `github_create_pr_review` with event="APPROVE"
- **Request Changes**: `github_create_pr_review` with event="REQUEST_CHANGES" and body explaining issues
- **Comment**: `github_create_pr_review` with event="COMMENT" for feedback

**Without MCP:**
```bash
gh pr review {pull_number} --approve
gh pr review {pull_number} --request-changes -b "Reason"
gh pr review {pull_number} --comment -b "Feedback"
```

### Step 6: (Optional) Add Line Comments
Use `github_create_pr_comment` for specific line feedback:
- Need: commit_id, path, line number

### Step 7: (If Approved) Merge
Use `github_merge_pull_request` with preferred merge_method (squash recommended)

**Without MCP:** `gh pr merge {pull_number} --squash`

## Review Checklist

Before approving, verify:
- [ ] Code follows project conventions
- [ ] Tests pass (CI green)
- [ ] No security vulnerabilities introduced
- [ ] Documentation updated if needed
- [ ] Commit messages are clear

## Output Format

```
📝 PR REVIEW: #{pull_number}

📋 OVERVIEW
Title: {title}
Author: {author}
Files changed: {count}
Additions: +{lines} | Deletions: -{lines}

✅ CI STATUS
{All checks passing / X checks failing}

📌 CHANGES SUMMARY
- {file1}: {description}
- {file2}: {description}

🔍 REVIEW DECISION
{APPROVE / REQUEST_CHANGES / COMMENT}

💬 FEEDBACK
{Your review comments}
```

## Without GitHub Access

If on mobile/web with no GitHub API:
1. Note the PR number to review later
2. If you can access the repo files, read the changed files
3. Document your review thoughts:

```markdown
## PR Review Notes - #{number}
To submit when back at desktop:
- Approve: Yes/No
- Comments: {feedback}
- Line comments: {file}:{line} - {comment}
```
