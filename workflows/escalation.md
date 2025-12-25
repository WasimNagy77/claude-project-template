# Escalation Workflow

When to use: A task is blocked, failing, or stalled for too long.

---

## Escalation Triggers

### Automatic Escalation (Check Daily)

| Condition | Escalation Level |
|-----------|------------------|
| Issue blocked 3+ days | High |
| CI failing 2+ times on same issue | High |
| No progress 5+ days | Medium |
| PR waiting for review 3+ days | Medium |
| Worker asks for help | Immediate |

### Manual Escalation

Worker or Brain can escalate anytime by:
1. Adding `escalation:needed` label to issue
2. Commenting with escalation details

---

## Escalation Levels

### Level 1: Worker Self-Resolve
**Who handles:** Worker
**Action:** Try alternative approach, read more docs, search for solutions

### Level 2: Brain Assist
**Who handles:** Brain
**Action:** Provide guidance, adjust scope, split task

### Level 3: User Decision
**Who handles:** User (Wasim)
**Action:** Make strategic decision, provide access, authorize changes

---

## Escalation Protocol

### Step 1: Document the Block

Worker adds comment to issue:

```markdown
## Escalation Request

**Blocked Since:** [date]
**Reason:** [specific blocker]

**What I Tried:**
1. [approach 1] - Result: [what happened]
2. [approach 2] - Result: [what happened]

**What I Need:**
- [specific help needed]

**Impact:**
- Blocking: [other issues/features affected]
- Deadline risk: [yes/no]
```

### Step 2: Label the Issue

Add labels:
- `escalation:needed`
- `status:blocked`

### Step 3: Brain Review

Brain checks escalations daily during standup:

```
github_list_issues(
  owner, repo,
  labels: "escalation:needed"
)
```

### Step 4: Resolution

**Brain can resolve by:**
1. Providing missing information
2. Adjusting acceptance criteria
3. Splitting into smaller tasks
4. Reassigning to different worker
5. Deprioritizing (moving to backlog)

**User must resolve when:**
1. Strategic decision needed
2. Access/credentials required
3. Scope change requested
4. Budget/timeline impact

### Step 5: Document Resolution

```markdown
## Escalation Resolved

**Resolution:** [what was decided]
**Action Taken:** [what changed]
**Next Steps:** [what worker should do now]

Removing escalation:needed label.
```

---

## CI Failure Escalation

### First Failure
- Worker fixes and repushes
- No escalation needed

### Second Failure (Same Issue)
- Worker documents what's failing
- Adds comment with failure details
- Continues trying

### Third Failure
- Automatic escalation
- Add `escalation:ci-failing` label
- Brain or User must review

### CI Escalation Template

```markdown
## CI Escalation

**Failures:** 3 times
**Error:**
\`\`\`
[paste error log]
\`\`\`

**Attempts to Fix:**
1. [what I tried]
2. [what I tried]

**Theory:** [what might be wrong]

**Need:** [specific help]
```

---

## Stalled Work Escalation

### Definition
No commits on issue branch for 5+ days while `status:in-progress`.

### Causes
- Worker session died and wasn't restarted
- Worker stuck but didn't escalate
- Issue deprioritized without updating status

### Resolution
1. Brain checks: Is this still needed?
2. If yes: Ping user to restart worker
3. If no: Close or move to backlog

---

## Escalation Checklist

### For Workers

When blocked:
- [ ] Tried at least 2 different approaches
- [ ] Documented what was tried
- [ ] Created escalation comment
- [ ] Added escalation label
- [ ] Updated SESSION-LOG.md

### For Brain

During daily standup:
- [ ] Check for `escalation:needed` issues
- [ ] Check for `status:blocked` issues
- [ ] Check for CI failures
- [ ] Check for stale in-progress issues
- [ ] Resolve or escalate to user

### For User

When notified of escalation:
- [ ] Review the escalation details
- [ ] Make decision
- [ ] Comment with resolution
- [ ] Ensure labels updated

---

## Quick Reference

### Escalation Labels

| Label | Meaning |
|-------|---------|
| `escalation:needed` | Needs attention |
| `escalation:ci-failing` | CI failures |
| `escalation:decision-needed` | User decision required |
| `status:blocked` | Cannot proceed |

### Escalation Priority

| Priority | Response Time |
|----------|---------------|
| High (3+ days blocked) | Within 24 hours |
| Medium (stalled work) | Within 48 hours |
| Low (nice to have) | Next weekly review |
