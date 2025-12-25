# Recovery Protocol - Session Death & Context Loss

This document defines how to recover when sessions die unexpectedly or context is lost.

---

## Prevention (Most Important)

The best recovery is not needing to recover.

### Continuous Saving Rules

| After This | Do This |
|------------|---------|
| Every file edit | `git add . && git commit` |
| Every 2-3 commits | `git push` |
| Every 5-10 minutes | Push regardless of commit count |
| Major decision | Update SESSION-LOG.md |
| Before risky operation | Push everything |

### The Session Death Test

Ask yourself: **"If this session died right now, would the next session know what to do?"**

If no → Stop and save state immediately.

---

## Recovery Levels

### Level 1: Context Reset (Same Session)

**Symptom:** "I don't remember what we were doing"

**Recovery:**
1. Read `SESSION-LOG.md` - Current Session section
2. Check `STATUS.md` - What's in progress
3. Check `git log --oneline -10` - Recent commits
4. Resume from last known state

### Level 2: Session Died Mid-Work

**Symptom:** New session, work was in progress

**Recovery:**
1. `git pull origin main` - Get latest
2. Read `SESSION-LOG.md` - What was being done
3. Check `git status` - Any uncommitted changes (unlikely)
4. Check `git log -1` - Last commit message
5. Continue from last commit

### Level 3: Session Died, Nothing Saved

**Symptom:** New session, no recent commits, unclear state

**Recovery:**
1. Check GitHub Issues - What was assigned?
2. Check PR status - Any in progress?
3. Read `SESSION-LOG.md` - May have notes
4. Ask user: "I found [X]. Should I continue from there?"

---

## Recovery Checklist

### For Workers (Claude Code)

```bash
# 1. Get latest code
git pull origin main

# 2. Check what was happening
cat SESSION-LOG.md

# 3. Check recent commits
git log --oneline -10

# 4. Check branch status
git branch -a
git status

# 5. Check for work in progress
ls results/  # Any incomplete output files?

# 6. Find your assigned task
cat STATUS.md  # Or check GitHub Issues
```

### For Brain (Claude Desktop)

1. **Check PROJECTS.md** - What projects are active?
2. **For each project:**
   - Read `SESSION-LOG.md` via GitHub API
   - Check open issues
   - Check open PRs
3. **Identify resume point** - What was next?
4. **Inform user** - "Last session was [doing X]. Continue?"

---

## Recovery by Scenario

### Scenario: "I was writing code and session died"

1. Pull latest: `git pull`
2. Check if code was committed: `git log -1`
3. If committed → Continue from there
4. If not committed → Code is lost, start again
5. Update SESSION-LOG.md with recovery note

### Scenario: "I was reviewing a PR and session died"

1. Check PR on GitHub - Is it still open?
2. Check for review comments - Did I leave any?
3. If review complete → Merge decision pending
4. If incomplete → Resume review

### Scenario: "I was creating multiple issues and session died"

1. Check GitHub Issues - Which ones were created?
2. Cross-reference with plan - Which are missing?
3. Create remaining issues
4. Update SESSION-LOG.md

### Scenario: "Brain was delegating and session died"

1. Check what issues exist
2. Check what issues were planned (SESSION-LOG.md)
3. Create missing issues
4. Resume delegation workflow

---

## SESSION-LOG.md Recovery Format

When recovering, add this to SESSION-LOG.md:

```markdown
## Recovery Note - [Date]

**Previous Session Died:** [Time if known]
**Recovery Method:** [What you checked]
**State Found:**
- Last commit: [hash and message]
- In-progress work: [description]
- Missing: [what wasn't saved]

**Resuming From:** [specific point]
```

---

## Emergency Information

### What's Always Safe

These survive session death:
- Git commits (pushed)
- GitHub issues
- GitHub PRs
- GitHub comments
- Files in repo (pushed)

### What's Never Safe

These are lost on session death:
- Uncommitted file changes
- Unpushed commits
- Conversation context
- Mental state / plans not written down

### The One Rule

**If it's not in GitHub, it doesn't exist.**

---

## Quick Recovery Commands

```bash
# Full recovery sequence for Worker
git pull origin main
cat SESSION-LOG.md
git log --oneline -5
git status
cat STATUS.md

# Then: Update SESSION-LOG.md with recovery note
```

```
# Recovery sequence for Brain (Claude Desktop)
1. github_get_file_contents(owner, repo, "SESSION-LOG.md")
2. github_list_issues(owner, repo, state="open")
3. github_list_pull_requests(owner, repo, state="open")
4. Inform user of state
5. Ask to continue or reset
```

---

## Post-Recovery Actions

After recovering:

1. **Add recovery note** to SESSION-LOG.md
2. **Verify state** - All expected commits present?
3. **Resume work** from known point
4. **Save immediately** - Don't repeat the same mistake
