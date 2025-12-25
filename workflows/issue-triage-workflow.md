# Issue Triage Workflow

Workflow for triaging and organizing repository issues.

**Trigger:** "organize the issues", "triage issues", "clean up issues"

## Parameters
- **owner**: Repository owner
- **repo**: Repository name

## Steps

### Step 1: Get Open Issues
Use `github_list_issues` with state="open" to see all open issues

**Without MCP:** `gh issue list -s open`

### Step 2: Categorize by Labels
Review each issue and add appropriate labels using `github_add_labels`:

**Type Labels:**
- bug
- enhancement
- documentation

**Priority Labels:**
- priority:critical
- priority:high
- priority:medium
- priority:low

**Status Labels:**
- status:ready
- status:in-progress
- status:blocked
- status:needs-info

**Department Labels (for worker assignment):**
- dept:strategy
- dept:design
- dept:content
- dept:dev
- dept:security
- dept:qa
- dept:audit
- dept:seo
- dept:analytics
- dept:devops
- dept:assets
- dept:client
- dept:docs

**Without MCP:** `gh issue edit {number} --add-label "{label}"`

### Step 3: Assign Issues
Use `github_update_issue` to add assignees to issues

**Without MCP:** `gh issue edit {number} --add-assignee "{user}"`

### Step 4: Close Stale Issues
For outdated/resolved issues:
- Use `github_update_issue` with state="closed"
- Add a comment explaining why using `github_add_comment`

**Without MCP:**
```bash
gh issue close {number} -c "Reason for closing"
```

### Step 5: Link Related Issues
Add comments linking related issues using `github_add_comment`

**Without MCP:** `gh issue comment {number} -b "Related to #{other_number}"`

### Step 6: Project Board (Optional)
1. Use `list_projects` to find the project
2. Use `add_item_to_project` to add issues
3. Use `move_item` to set status (Todo, In Progress, Done)

**Without MCP:**
```bash
gh project item-add {project_number} --owner {owner} --url {issue_url}
```

## Triage Decision Tree

```
For each issue:
├── Is it a duplicate?
│   └── Yes → Close with link to original
│
├── Is it still relevant?
│   └── No → Close with explanation
│
├── Has enough info?
│   ├── No → Add "status:needs-info" label
│   └── Yes → Continue
│
├── What type?
│   ├── Bug → Add "bug" label
│   ├── Feature → Add "enhancement" label
│   └── Docs → Add "documentation" label
│
├── What priority?
│   ├── Urgent → "priority:critical"
│   ├── Important → "priority:high"
│   ├── Normal → "priority:medium"
│   └── Nice to have → "priority:low"
│
└── Which department?
    └── Add appropriate "dept:X" label
```

## Output Format

```
📋 ISSUE TRIAGE: {owner}/{repo}

📊 SUMMARY
- Total open: {count}
- Triaged this session: {count}
- Closed as stale: {count}

🏷️ BY PRIORITY
- Critical: {count}
- High: {count}
- Medium: {count}
- Low: {count}

👥 BY DEPARTMENT
- dev: {count}
- design: {count}
- ...

✅ ACTIONS TAKEN
1. #{num}: Added labels {labels}
2. #{num}: Closed (duplicate of #{other})
3. #{num}: Needs more info

💡 RECOMMENDATIONS
- {Suggested actions}
```

## Without GitHub Access

Document triage decisions for later:
```markdown
## Issue Triage Notes - {Date}
To apply when back at desktop:
- #{1}: Add labels [dept:dev, priority:high]
- #{2}: Close - duplicate of #{3}
- #{4}: Ask for more info
```
