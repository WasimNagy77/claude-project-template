# Instructions for Claude

## Before You Start

**Read these files in order:**

1. **[SESSION-LOG.md](./SESSION-LOG.md)** - What was done, what's next (START HERE)
2. **[GOD-MODE-ARCHITECTURE.md](./GOD-MODE-ARCHITECTURE.md)** - Full system design
3. **[BRAIN.md](./BRAIN.md)** - If you're Claude Desktop (orchestrator)
4. **[WORKER.md](./WORKER.md)** - If you're Claude Code (executor)

## What This Repo Is

This is the **God Mode framework** for AI-powered workflows:
- Brain (Claude Desktop) orchestrates
- Workers (Claude Code) execute
- GitHub is the permanent memory

## Working on This Project

### Every Session
1. Read `SESSION-LOG.md` first - know where we left off
2. Check "What's Next" section
3. Update SESSION-LOG.md as you work (continuous saving)

### After Making Changes
1. Update `docs/project-context.md` with:
   - New entries in Session History
   - Updated Current Status
   - Revised Next Steps
2. Update `CHANGELOG.md` under `[Unreleased]`
3. Follow the security checklist in CONTRIBUTING.md

### Committing Code
- Update CHANGELOG.md before every commit
- Use descriptive commit messages
- Reference relevant documentation updates
- Never commit secrets or API keys

## Quick Reference

| Task | Required Files to Update |
|------|-------------------------|
| Add feature | CHANGELOG.md, docs/project-context.md |
| Fix bug | CHANGELOG.md |
| Add dependency | CHANGELOG.md, package-lock.json |
| Security change | CHANGELOG.md, SECURITY.md |
| Any progress | docs/project-context.md (Session History) |

## AI-Specific Rules

- Always read project-context.md at session start
- Always update project-context.md at session end
- Never skip CHANGELOG.md updates
- Follow security requirements without shortcuts
- Ask for clarification rather than assuming
