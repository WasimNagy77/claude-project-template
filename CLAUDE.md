# Instructions for Claude

## Before You Start

**Read these files in order:**

1. **[docs/project-context.md](./docs/project-context.md)** - Project history, decisions, and current status
2. **[CONTRIBUTING.md](./CONTRIBUTING.md)** - Workflow rules for all changes
3. **[SECURITY.md](./SECURITY.md)** - Security requirements and checklist

## Working on This Project

### Every Session
1. Check `docs/project-context.md` for current status and next steps
2. Review any open GitHub issues related to your task
3. Follow the workflow in CONTRIBUTING.md

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
