# Conflict Resolution - Multi-Worker Protocol

This document defines how to prevent and resolve conflicts when multiple workers operate simultaneously.

---

## Core Principle

**One worker per issue. One issue per worker.**

---

## Conflict Types

| Type | Description | Prevention |
|------|-------------|------------|
| **Same Issue** | Two workers claim same task | Use `status:in-progress` label |
| **Same File** | Two workers edit same file | Assign different issues |
| **Same Branch** | Two workers push to same branch | Use issue-based branch names |
| **Merge Conflict** | Changes overlap | Rebase before PR |

---

## Prevention Protocol

### Before Starting Work (Worker)

```bash
# 1. Pull latest
git pull origin main

# 2. Check if issue is claimed
# Look for: status:in-progress label
# If present, pick a different issue

# 3. Claim the issue
# Add comment: "Starting work on this"
# Add label: status:in-progress (if you have access)
# Or: Add to SESSION-LOG.md that you're working on it

# 4. Create unique branch
git checkout -b [dept]/[issue-number]-[desc]
# Example: dev/42-add-booking-api
```

### Issue Locking (Brain)

When assigning issues:

```
1. Create issue with: status:ready
2. When worker starts: change to status:in-progress
3. When PR created: change to status:in-review
4. When merged: close issue
```

### File Ownership

When creating issues, specify which files the worker should touch:

```markdown
## Scope
Only modify these files:
- src/api/booking.ts
- src/types/booking.ts
- tests/booking.test.ts

Do NOT modify:
- src/api/auth.ts (being worked on by another task)
```

---

## Detection

### Signs of Conflict

1. **Push rejected:**
   ```
   ! [rejected] dev/42-feature -> dev/42-feature (non-fast-forward)
   ```

2. **Two PRs for same issue:**
   Check: `github_list_pull_requests` → multiple PRs reference same issue

3. **SESSION-LOG.md shows two workers:**
   Two "Current Session" entries for same issue

### Detection Commands

```bash
# Check for other branches on same issue
git branch -r | grep "42-"

# Check recent commits by others
git log --oneline --all --since="1 day ago"

# Check if branch exists on remote
git ls-remote origin | grep "[branch-name]"
```

---

## Resolution Procedures

### Case 1: Two Workers Started Same Issue

**Detection:** Both see `status:in-progress` + work in SESSION-LOG.md

**Resolution:**
1. First worker (earlier timestamp) keeps issue
2. Second worker:
   - Stops work
   - Saves any useful work as draft PR or comment
   - Picks different issue
   - Updates SESSION-LOG.md with note

**Brain Action:**
- Comment on issue clarifying who owns it
- Reassign second worker

### Case 2: Same File Modified

**Detection:** Merge conflict in PR

**Resolution:**
1. **If changes don't overlap:**
   - Rebase: `git rebase origin/main`
   - Resolve conflicts
   - Push: `git push --force-with-lease`

2. **If changes conflict:**
   - Coordinate with other worker (via issue comments)
   - Decide whose changes take priority
   - One worker incorporates other's changes
   - Other worker closes their PR

### Case 3: Push Rejected (Branch Conflict)

**Detection:** `git push` rejected

**Resolution:**
```bash
# 1. Fetch latest
git fetch origin

# 2. Check what changed
git log HEAD..origin/[branch] --oneline

# 3. Rebase your changes
git rebase origin/[branch]

# 4. Resolve any conflicts
# ... edit files ...
git add .
git rebase --continue

# 5. Push with lease (safer than force)
git push --force-with-lease
```

### Case 4: Two PRs for Same Issue

**Detection:** Brain sees duplicate PRs

**Resolution (Brain):**
1. Compare both PRs
2. Decide which to keep (quality, completeness)
3. Close duplicate PR with comment
4. Optionally cherry-pick useful commits from closed PR
5. Update issue with decision

---

## Parallel Work Guidelines

### Safe to Parallelize

| Worker 1 | Worker 2 | Safe? |
|----------|----------|-------|
| Issue #1 (files A, B) | Issue #2 (files C, D) | ✅ Yes |
| Frontend work | Backend work | ✅ Yes |
| Different features | Different features | ✅ Yes |
| Tests for feature X | Implementation of X | ⚠️ Coordinate |

### Never Parallelize

- Same issue
- Same feature
- Files with dependencies
- Config files (package.json, tsconfig.json, etc.)

---

## Communication Protocol

### When Starting Work

```markdown
# In issue comment:
"Starting work on this. Branch: dev/42-add-booking

Touching these files:
- src/api/booking.ts
- tests/booking.test.ts"
```

### When Blocked by Another Worker

```markdown
# In issue comment:
"Blocked: Need changes from #43 (auth middleware) before I can complete this.
Marking as status:blocked until #43 merges."
```

### When Conflict Detected

```markdown
# In issue comment:
"@WasimNagy77 Conflict detected: PR #15 also modifies src/api/index.ts.
Need decision on which changes to keep."
```

---

## Brain Responsibilities

### Prevent Conflicts

1. **Don't assign overlapping issues** - Check file scope before assigning
2. **Use status labels** - Enforce status:ready → status:in-progress → status:in-review
3. **Document scope** - Each issue lists files to modify
4. **Check before assigning** - Is another worker in that area?

### Resolve Conflicts

1. **Act quickly** - Don't let workers waste time
2. **Be decisive** - Pick winner, explain why
3. **Preserve work** - Save useful code from rejected PR
4. **Update status** - Clear labels and assignments

---

## Quick Reference

### Worker Checklist Before Starting

- [ ] Issue has `status:ready` label (not `in-progress`)
- [ ] No other branch for this issue exists
- [ ] SESSION-LOG.md shows no one else on this issue
- [ ] I've added my start comment to the issue
- [ ] I've created a unique branch

### Worker Checklist Before PR

- [ ] Pulled latest main
- [ ] Rebased my branch on main
- [ ] No merge conflicts
- [ ] Tests pass
- [ ] PR links to correct issue

### Brain Checklist When Assigning

- [ ] Issue has clear file scope
- [ ] No overlap with other open issues
- [ ] Label set to `status:ready`
- [ ] One assignee (or none for worker to claim)
