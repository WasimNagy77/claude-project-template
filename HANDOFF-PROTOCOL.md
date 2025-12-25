# Handoff Protocol - Environment Transitions

This document defines how work transitions between different Claude environments.

---

## Environment Capability Levels

| Level | Environment | Has | Missing |
|-------|-------------|-----|---------|
| **Full** | Claude Desktop + MCP | All GitHub API, file access, git | - |
| **Partial** | Claude Code / Mobile | Git, files, bash | GitHub API (gh CLI) |
| **Minimal** | Claude Web | Chat only | Everything else |

---

## Handoff Scenarios

### Partial → Full Handoff
When work done in Claude Code/Mobile needs GitHub API actions.

**Example:** Mobile user wants to create an issue but can't.

### Full → Partial Handoff
When Brain delegates work to a Worker.

**Example:** Desktop creates issue, Worker executes in Claude Code.

### Minimal → Full Handoff
When decisions made in web chat need execution.

**Example:** Web conversation produces a plan, Desktop executes it.

---

## Capture Locations

When an environment **cannot** complete an action, capture it here:

### Primary Capture File: `PENDING-ACTIONS.md`

Create this file in any project repo when actions are pending:

```markdown
# Pending Actions

Actions that couldn't be completed in a limited environment.

## Waiting for Full Environment

| Captured | Environment | Action Needed | Priority |
|----------|-------------|---------------|----------|
| 2025-12-25 | Mobile | Create issue: "Add booking API" | High |
| 2025-12-25 | Mobile | Review PR #15 | Medium |
| 2025-12-25 | Web | Update project board | Low |

## Details

### Create issue: "Add booking API"
- **Title:** [dev] Implement booking API
- **Body:** Need POST /api/booking endpoint that...
- **Labels:** dept:dev, priority:high

### Review PR #15
- **Notes:** Looked at diff on mobile, seems fine
- **Decision:** Approve and merge
```

### Secondary Capture: SESSION-LOG.md

For quick notes during work:

```markdown
## Pending (Need Full Environment)
- [ ] Create issue for booking feature
- [ ] Update PROJECTS.md with new status
```

---

## Handoff Workflow

### Step 1: Capture (In Limited Environment)

When you can't complete an action:

1. Add to `PENDING-ACTIONS.md` in the relevant repo
2. Include all details needed to execute later
3. Commit and push the file

```bash
# Example in Claude Code
echo "## Pending
- [ ] Create issue: [dev] Add auth middleware" >> PENDING-ACTIONS.md
git add PENDING-ACTIONS.md
git commit -m "chore: capture pending actions"
git push
```

### Step 2: Pickup (In Full Environment)

When you have full capabilities:

1. Check `PENDING-ACTIONS.md` in each active project
2. Execute each pending action
3. Mark as done or remove from file
4. Commit the cleanup

```markdown
# After executing:
## Completed
- [x] Create issue: [dev] Add auth middleware → Issue #42
```

### Step 3: Cleanup

After all pending actions are done:
- Archive or delete `PENDING-ACTIONS.md`
- Or keep only the "Completed" section for history

---

## Quick Reference by Environment

### Claude Mobile/Code (Partial)

**Can Do:**
- Read/edit files
- Git operations
- Run bash commands
- Capture pending actions

**Cannot Do (Capture These):**
- Create GitHub issues
- Review/merge PRs
- Update project boards
- Create milestones
- Manage labels

**Action:** Write to `PENDING-ACTIONS.md`

### Claude Desktop (Full)

**Startup Routine:**
1. Check `PENDING-ACTIONS.md` in all active repos
2. Execute pending items
3. Clean up the file

### Claude Web (Minimal)

**Can Do:**
- Discuss and plan
- Make decisions
- Provide instructions

**Cannot Do:**
- Any file operations
- Any GitHub operations

**Action:** User must manually transfer decisions to Desktop

---

## Handoff Checklist

### Before Leaving Limited Environment

- [ ] All pending actions captured in `PENDING-ACTIONS.md`
- [ ] File committed and pushed
- [ ] SESSION-LOG.md updated with what was done
- [ ] Clear notes for what Full environment should do

### On Entering Full Environment

- [ ] Pull latest from all active repos
- [ ] Check `PENDING-ACTIONS.md` in each
- [ ] Execute all pending items
- [ ] Update status after completion
- [ ] Clean up pending files

---

## Emergency Capture

If you can't even create `PENDING-ACTIONS.md`:

1. **SESSION-LOG.md** - Add to "Pending" section
2. **Issue comment** - If you can access GitHub at all
3. **Git commit message** - As last resort:
   ```bash
   git commit --allow-empty -m "PENDING: Create issue for auth feature, Review PR #15"
   ```

The next full-capability session should search for these.
