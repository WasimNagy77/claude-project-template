# Sync Protocol - Source of Truth Rules

This document defines who owns what and how data stays synchronized.

---

## Core Principle

**GitHub is the source of truth. Everything else reflects GitHub.**

---

## Ownership Matrix

| Data | Owner | Location | Updates By |
|------|-------|----------|------------|
| Issues/Tasks | GitHub | GitHub Issues | Brain (creates), Worker (comments) |
| Project Status | GitHub | GitHub Issues + STATUS.md | Brain |
| PR Status | GitHub | Pull Requests | Worker (creates), Brain (reviews) |
| Session History | Repo | SESSION-LOG.md | Whoever is working |
| Project Registry | Repo | PROJECTS.md | Brain only |
| Milestones | GitHub | GitHub Milestones | Brain only |
| Labels | GitHub | GitHub Labels | Brain only |
| Workflows | Repo | workflows/*.md | Brain only |
| Code | Repo | Git branches | Worker only |

---

## STATUS.md Sync Rules

### What STATUS.md Contains
- Human-readable project summary
- Current priorities
- Quick reference for Brain/Worker on startup

### What STATUS.md Does NOT Contain
- Detailed task tracking (use GitHub Issues)
- Commit history (use git log)
- PR details (use GitHub PRs)

### When to Update STATUS.md

| Event | Action |
|-------|--------|
| Phase change | Update phase section |
| Major milestone | Update milestone section |
| Priority shift | Update priorities |
| Weekly | Refresh to match GitHub |

### Sync Direction

```
GitHub Issues → STATUS.md (Brain summarizes)
Never: STATUS.md → GitHub Issues
```

If STATUS.md and GitHub disagree, **GitHub wins**.

---

## SESSION-LOG.md Rules

### Purpose
Track session-by-session work for context recovery.

### Who Updates
- Whoever is actively working updates SESSION-LOG.md
- Brain and Workers both use it

### When to Update

| Timing | What to Update |
|--------|----------------|
| Start of session | "Current Session" section |
| After each action | "What Was Done" |
| Every 15 minutes | Push to repo |
| End of session | "What's Next" |

### Conflict Prevention
- SESSION-LOG.md is append-only during sessions
- Historical sessions are immutable
- Only current session is edited

---

## PROJECTS.md Rules

### Single Owner
Only Brain (Claude Desktop) updates PROJECTS.md.

### When to Update

| Event | Action |
|-------|--------|
| New project onboarded | Add to table |
| Project status change | Update status |
| Project completed | Move to completed section |
| Weekly review | Verify accuracy |

### Workers Never Modify
Workers read PROJECTS.md but never edit it.

---

## Workflow Files Rules

### Source of Truth
`workflows/*.md` files are the source of truth.

### MCP Prompts
MCP prompts in github-full-mcp should mirror workflows/*.md.

### Sync Direction
```
workflows/*.md → MCP prompts (manual sync)
```

### When They Differ
If MCP prompt differs from workflow file, the **workflow file is correct**.

---

## Conflict Resolution

### Same File Modified by Two Agents

1. **Prevention:** Assign different files/issues to different workers
2. **Detection:** Check git log before starting work
3. **Resolution:** Most recent commit wins; loser re-applies changes

### STATUS.md vs GitHub Disagree

1. **Detection:** Read both on startup
2. **Resolution:** GitHub data is correct
3. **Action:** Brain updates STATUS.md to match GitHub

### Two Workers Claim Same Issue

1. **Prevention:** Use `status:in-progress` label
2. **Detection:** Check labels before starting
3. **Resolution:** First to add label owns it; second picks different issue

---

## Quick Reference

### For Brain (Claude Desktop)
1. Always update GitHub first
2. Then summarize to STATUS.md
3. Never let STATUS.md become stale

### For Workers (Claude Code)
1. Read STATUS.md for context
2. Trust GitHub Issues for task details
3. Don't modify STATUS.md (only SESSION-LOG.md)

### Golden Rules
1. If in doubt, check GitHub
2. Commit early and often
3. Push every few changes
4. Update SESSION-LOG.md as you work
