# Testing Procedures

How to verify that the God Mode framework is working correctly.

---

## Framework Testing

### Test 1: Brain Startup

**Objective:** Verify Brain can read projects and report status.

**Steps:**
1. Open Claude Desktop with MCP
2. Say: "Good morning, standup"
3. Verify Brain:
   - Reads PROJECTS.md
   - Checks each active repo
   - Reports issues, PRs, CI status

**Pass Criteria:**
- [ ] All active projects checked
- [ ] Status reported for each
- [ ] No errors in MCP tools

### Test 2: Worker Startup

**Objective:** Verify Worker can read instructions and find tasks.

**Steps:**
1. Open Claude Code in a project directory
2. Say: "Read CLAUDE.md and tell me what you know"
3. Verify Worker:
   - Reads CLAUDE.md
   - Understands project context
   - Can find STATUS.md or check issues

**Pass Criteria:**
- [ ] CLAUDE.md read successfully
- [ ] Project context understood
- [ ] Ready to accept task

### Test 3: Delegation Flow

**Objective:** Verify Brain can create task and Worker can execute.

**Steps:**
1. Brain: "Create a test issue for dev department"
2. Verify issue created in GitHub
3. Open Claude Code
4. Worker: "Work on issue #X"
5. Worker makes a simple change, creates PR
6. Brain reviews and merges PR

**Pass Criteria:**
- [ ] Issue created with correct labels
- [ ] Worker found and understood task
- [ ] PR created with correct format
- [ ] Brain able to merge

### Test 4: Handoff Flow

**Objective:** Verify partial→full handoff works.

**Steps:**
1. In Claude Code (partial env):
   - Attempt action requiring GitHub API
   - Capture in PENDING-ACTIONS.md
   - Commit and push
2. In Claude Desktop (full env):
   - Check PENDING-ACTIONS.md
   - Execute pending action
   - Clean up file

**Pass Criteria:**
- [ ] Pending action captured correctly
- [ ] Full env found pending action
- [ ] Action executed successfully
- [ ] Cleanup completed

### Test 5: Recovery Flow

**Objective:** Verify session can recover from death.

**Steps:**
1. Start working on a task
2. Commit progress
3. Close session abruptly
4. Start new session
5. Say: "Continue from where we left off"

**Pass Criteria:**
- [ ] SESSION-LOG.md has progress
- [ ] New session can read context
- [ ] Work continues smoothly

---

## Workflow Testing

### Test: Daily Standup

**Steps:**
1. Say: "Daily standup" or "Catch me up"
2. Verify output includes all projects

**Pass Criteria:**
- [ ] All projects from PROJECTS.md checked
- [ ] Open issues counted
- [ ] Open PRs counted
- [ ] CI status checked

### Test: Issue Triage

**Steps:**
1. Create 3-5 test issues without labels
2. Say: "Triage the issues"
3. Verify issues get organized

**Pass Criteria:**
- [ ] Issues labeled
- [ ] Priority assigned
- [ ] Summary provided

### Test: PR Review

**Steps:**
1. Create a test PR
2. Say: "Review PR #X"
3. Verify review workflow runs

**Pass Criteria:**
- [ ] PR details fetched
- [ ] Changes analyzed
- [ ] Review submitted

### Test: Escalation

**Steps:**
1. Create issue with `escalation:needed` label
2. Run standup
3. Verify escalation flagged

**Pass Criteria:**
- [ ] Escalation detected in standup
- [ ] User notified
- [ ] Resolution path clear

---

## MCP Tool Testing

Test each critical MCP tool:

| Tool | Test Command | Expected Result |
|------|--------------|-----------------|
| `github_list_issues` | List issues for any repo | Array of issues |
| `github_create_issue` | Create test issue | New issue created |
| `github_get_file_contents` | Read CLAUDE.md | File contents |
| `github_create_or_update_file` | Update test file | File updated |
| `github_list_pull_requests` | List PRs | Array of PRs |
| `github_create_pr_review` | Review a PR | Review submitted |

---

## Environment Testing

### Claude Desktop + MCP

**Checklist:**
- [ ] MCP connection established
- [ ] GitHub tools available
- [ ] Filesystem tools available
- [ ] Prompts trigger correctly

### Claude Code

**Checklist:**
- [ ] Git operations work
- [ ] File read/write works
- [ ] Bash commands work
- [ ] Can push to remote

### Claude Mobile

**Checklist:**
- [ ] Can read files
- [ ] Can edit files
- [ ] Git commands work
- [ ] Can push to remote

---

## Integration Testing

### Full Cycle Test

1. **Brain creates project** (project-intake)
2. **Brain creates task** (worker-delegation)
3. **Worker executes task** (issue → PR)
4. **Brain reviews** (pr-review)
5. **Brain releases** (release-workflow)

**Pass Criteria:**
- [ ] Each step completes without error
- [ ] Artifacts created in GitHub
- [ ] Status updated throughout
- [ ] Release published

### Multi-Worker Test

1. Brain creates 2 issues for different departments
2. Spawn 2 workers (separate terminals)
3. Each worker completes their task
4. Both create PRs
5. Brain reviews and merges both

**Pass Criteria:**
- [ ] No conflicts between workers
- [ ] Both PRs created correctly
- [ ] Both merged successfully

---

## Regression Testing

After making changes to the framework, verify:

- [ ] All startup flows work
- [ ] All workflows trigger correctly
- [ ] Handoff still works
- [ ] Recovery still works
- [ ] No broken file references

---

## Testing Checklist

### Before First Use

- [ ] CLAUDE.md in place
- [ ] BRAIN.md in place
- [ ] WORKER.md in place
- [ ] MCP configured
- [ ] Test repo accessible

### After Framework Updates

- [ ] Run all startup tests
- [ ] Run one full cycle test
- [ ] Verify no broken links
- [ ] Check all workflows exist

### Weekly

- [ ] Test standup workflow
- [ ] Verify all projects accessible
- [ ] Check for stale data
- [ ] Test one handoff cycle

---

## Troubleshooting

### Common Issues

| Issue | Cause | Fix |
|-------|-------|-----|
| MCP tools fail | Connection issue | Restart Claude Desktop |
| Can't find issues | Wrong repo/owner | Check PROJECTS.md |
| Push rejected | Branch conflict | Pull and rebase |
| File not found | Wrong path | Verify file exists |

### Debug Commands

```bash
# Test Git connection
git remote -v
git fetch origin

# Test file access
ls -la CLAUDE.md

# Test GitHub CLI (if available)
gh repo view

# Test basic operations
cat STATUS.md
git status
```
