# Notification System

How information flows between Brain, Workers, and User in the God Mode framework.

---

## Limitation

**There is no real-time notification system.** Claude sessions cannot receive push notifications.

All notifications are **pull-based**: Someone must check to see updates.

---

## Notification Channels

| Channel | When Checked | Who Checks | What's There |
|---------|--------------|------------|--------------|
| Daily Standup | Every morning | Brain | All updates from all projects |
| Issue Comments | On task start | Worker | Updates from Brain/User |
| PR Reviews | On PR creation | Brain | Worker submissions |
| SESSION-LOG.md | On session start | Everyone | What happened, what's next |
| PENDING-ACTIONS.md | On full env start | Brain | Actions from limited envs |

---

## Notification Types

### High Priority (Check Immediately)

| Event | Who Notifies | How | Who Acts |
|-------|--------------|-----|----------|
| Escalation needed | Worker | Label + Comment | Brain/User |
| CI failing | GitHub | Workflow status | Worker |
| Review requested | Worker | PR creation | Brain |
| Blocked task | Worker | Label + Comment | Brain |

### Medium Priority (Check in Standup)

| Event | Who Notifies | How | Who Acts |
|-------|--------------|-----|----------|
| Task completed | Worker | PR + Issue close | Brain |
| New task ready | Brain | Issue created | Worker |
| Sprint planned | Brain | Milestone + Issues | Workers |
| Milestone complete | Brain | Milestone closed | User |

### Low Priority (Check Weekly)

| Event | Who Notifies | How | Who Acts |
|-------|--------------|-----|----------|
| Docs updated | Worker | Commit | Brain |
| Refactoring done | Worker | PR | Brain |
| Backlog groomed | Brain | Issue updates | User |

---

## How to Notify

### Worker → Brain

1. **Create PR** (for completed work)
2. **Comment on issue** (for questions/updates)
3. **Add label** (for status changes)
4. **Update SESSION-LOG.md** (for next session)

### Brain → Worker

1. **Create issue** (for new tasks)
2. **Comment on issue** (for guidance)
3. **Update STATUS.md** (for priorities)
4. **PR review** (for feedback)

### Brain → User

1. **Daily standup report** (for routine updates)
2. **Escalation with `escalation:decision-needed`** (for decisions)
3. **Direct message in conversation** (for immediate needs)

### User → Brain/Worker

1. **Conversation** (for instructions)
2. **Issue comment** (for specific feedback)
3. **PR comment** (for code feedback)

---

## Notification Checking Schedule

### Brain (Claude Desktop)

**On Session Start:**
```
1. Check PENDING-ACTIONS.md in each project
2. Check issues with escalation:needed
3. Check PRs waiting for review
4. Check CI status
```

**Daily Standup (Every Morning):**
```
1. Run daily-standup workflow
2. Report to user
3. Ask for priorities
```

### Worker (Claude Code)

**On Session Start:**
```
1. git pull
2. Read SESSION-LOG.md
3. Check assigned issue for new comments
4. Look for Brain's feedback
```

**Before Ending Session:**
```
1. Update SESSION-LOG.md
2. Push all changes
3. Comment on issue with status
```

### User

**Recommended Check Schedule:**
- Morning: Receive standup report from Brain
- When pinged: Check escalations
- Weekly: Review milestone progress

---

## Escalation as Notification

When something needs urgent attention:

### Worker Creates Escalation

```markdown
@WasimNagy77 Escalation needed:

**Issue:** #42 - Add booking API
**Blocked because:** Need database credentials
**Impact:** High - blocking other tasks

Please check and advise.
```

### Brain Escalates to User

During standup or conversation:

```
🚨 Escalation Alert

Issue #42 needs your attention:
- Worker blocked for 3 days
- Needs database credentials
- Blocking 2 other tasks

Action needed: Provide credentials or adjust scope.
```

---

## Notification Templates

### Status Update (Worker → Brain)

```markdown
## Progress Update - [Date]

**Issue:** #42 - Add booking API
**Status:** 75% complete

**Done:**
- [x] Endpoint structure
- [x] Request validation

**Remaining:**
- [ ] Database integration
- [ ] Tests

**ETA:** 1 more session

**Blockers:** None
```

### Task Assignment (Brain → Worker)

```markdown
## New Task Assigned

**Issue:** #43 - Add authentication
**Priority:** High
**Deadline:** End of week

**What to do:**
1. Read CLAUDE.md
2. Checkout: dev/43-add-auth
3. Follow acceptance criteria

**Context:**
- Related to #42
- Uses existing User model

**Questions?** Comment on issue.
```

### Daily Summary (Brain → User)

```markdown
## Daily Summary - [Date]

### Completed Today
- PR #15 merged (booking API)
- Issue #42 closed

### In Progress
- Issue #43 (auth) - 50%
- Issue #44 (tests) - starting

### Needs Attention
- ⚠️ Issue #45 blocked (needs decision)

### Planned Tomorrow
- Continue #43
- Start #46

**Any priorities to adjust?**
```

---

## Quick Reference

### Notification Labels

| Label | Meaning |
|-------|---------|
| `needs:review` | PR needs Brain review |
| `needs:decision` | User decision needed |
| `escalation:needed` | Urgent attention |
| `status:blocked` | Cannot proceed |
| `status:in-progress` | Being worked on |

### Who Checks What

| Person | Checks | Frequency |
|--------|--------|-----------|
| Brain | PRs, Issues, CI | On standup |
| Worker | Assigned issue | On session start |
| User | Standup report, Escalations | Daily/As needed |

### Notification Flow

```
Worker completes task
    ↓
Worker creates PR + comments
    ↓
Brain checks in standup
    ↓
Brain reviews PR
    ↓
Brain reports to User
    ↓
User acknowledges
```
