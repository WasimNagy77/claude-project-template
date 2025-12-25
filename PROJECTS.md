# Active Projects Registry

This file tracks all projects managed under the God Mode framework.

## How to Use

When running multi-project workflows (agency-dashboard, daily-standup), reference this file instead of hardcoding repo names.

## Active Projects

| Project | Repo | Owner | Phase | Priority | Status |
|---------|------|-------|-------|----------|--------|
| Nail Candy | nail-candy-website | WasimNagy77 | Development | High | Active |
| Agency | agency | WasimNagy77 | Brainstorming | Medium | Active |
| God Mode Framework | claude-project-template | WasimNagy77 | Maintenance | High | Active |

## Project Details

### Nail Candy (Client Project)
- **Repo:** https://github.com/WasimNagy77/nail-candy-website
- **Type:** Client website
- **Stack:** Next.js, Tailwind
- **Key Files:** CLAUDE.md, STATUS.md

### Agency (Internal)
- **Repo:** https://github.com/WasimNagy77/agency
- **Type:** Internal planning
- **Purpose:** Brainstorming Wasim's agency idea
- **Key Files:** STATUS.md, SESSION-LOG.md

### God Mode Framework (Internal)
- **Repo:** https://github.com/WasimNagy77/claude-project-template
- **Type:** Framework/Template
- **Purpose:** The orchestration framework itself
- **Key Files:** BRAIN.md, WORKER.md, workflows/

## Adding a New Project

When onboarding a new client or starting a new project:

1. Use the [project-intake workflow](./workflows/project-intake.md)
2. Add entry to the table above
3. Fill in project details section

## Project Statuses

| Status | Meaning |
|--------|---------|
| Active | Currently being worked on |
| On Hold | Paused, waiting on something |
| Completed | Delivered and closed |
| Archived | No longer maintained |

## Quick Commands

Get status of all active projects:
```
repos="nail-candy-website,agency,claude-project-template"
owner="WasimNagy77"
```

Use with agency-dashboard or daily-standup workflows.
