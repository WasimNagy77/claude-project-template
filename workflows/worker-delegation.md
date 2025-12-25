# Worker Delegation Workflow

Workflow for creating and assigning a task to a worker agent.

**Trigger:** "create task for dev", "assign to design", "delegate to X"

## Parameters
- **owner**: Repository owner
- **repo**: Repository name
- **department**: Department/agent type
- **task_title**: Brief title for the task

## Department Reference

| Dept | Focus Area |
|------|------------|
| strategy | Requirements, planning, architecture |
| design | UI/UX, visual design, prototypes |
| content | Copy, blog posts, SEO content |
| dev | Frontend, backend, implementation |
| security | Auth, encryption, headers, audits |
| qa | Testing, bug fixes, quality |
| audit | Code review, standards compliance |
| seo | Search optimization, meta tags |
| analytics | Tracking, metrics, dashboards |
| devops | CI/CD, deployment, infrastructure |
| assets | Images, icons, media files |
| client | Client communication, updates |
| docs | Documentation, guides, README |

## Steps

### Step 1: Create Task Issue
Use `github_create_issue` with:

```
owner: "{owner}"
repo: "{repo}"
title: "[{department}] {task_title}"
labels: ["dept:{department}", "priority:high", "status:ready"]
body: """
## Objective
[Describe what needs to be done]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Context
Read these files before starting:
- CLAUDE.md (project overview)
- STATUS.md (current state)
- [relevant docs]

## Estimated Time
X hours

## Output Required
- Code changes in PR
- Update results/task-XXX-output.md
- Update STATUS.md when complete
"""
```

**Without MCP:**
```bash
gh issue create \
  -t "[{department}] {task_title}" \
  -l "dept:{department},priority:high,status:ready" \
  -b "## Objective
[Describe what needs to be done]

## Acceptance Criteria
- [ ] Criterion 1
..."
```

### Step 2: Update STATUS.md
Use `github_get_file_contents` to get current STATUS.md
Then `github_create_or_update_file` to add:

```markdown
## Worker Needed
Task: #{issue-number} - {task_title}
Department: {department}
Priority: High
Status: Ready for worker

To work on this:
1. Open Claude Code
2. Clone this repo
3. Read CLAUDE.md
4. Work on issue #{number}
5. Create PR when done
```

**Without MCP:** Edit STATUS.md locally and push

### Step 3: Add to Project Board (if using)
Use `add_item_to_project` to add the issue
Use `move_item` to set status to "Ready"

**Without MCP:**
```bash
gh project item-add {project_num} --owner {owner} --url {issue_url}
```

### Step 4: Notify User
```
✅ Task delegated!

Issue: #{number} - [{department}] {task_title}
Status: Ready for worker

To spawn worker, open Claude Code and say:
"Clone {owner}/{repo}, read CLAUDE.md, and work on issue #{number}"
```

## Output Format

```
📋 TASK DELEGATED

Issue: #{number}
Title: [{department}] {task_title}
Labels: dept:{department}, priority:high, status:ready

📝 TASK DETAILS
{objective}

✅ ACCEPTANCE CRITERIA
- [ ] {criterion 1}
- [ ] {criterion 2}

🤖 SPAWN WORKER
"Clone {owner}/{repo}, read CLAUDE.md, work on issue #{number}"
```

## Without GitHub Access

If you can't create issues:

1. Document the task in STATUS.md:
```markdown
## Pending Tasks
- [{department}] {task_title}
  - Objective: {description}
  - Criteria: {list}
```

2. Or create a task file:
```markdown
# Task: {task_title}
Department: {department}
Status: Pending (issue not yet created)

## Objective
{description}

## Criteria
- [ ] {criterion}
```

3. Create the issue when back at desktop
