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

---

## Maintenance Rules

### Who Updates This File

**Only Brain (Claude Desktop)** modifies PROJECTS.md.

Workers read this file but never edit it.

### When to Update

| Event | Action |
|-------|--------|
| New project created | Add to table + details section |
| Project status changes | Update Status column |
| Phase changes | Update Phase column |
| Priority changes | Update Priority column |
| Project completed | Move to Completed section |
| Weekly review | Verify all data is current |

### Weekly Maintenance Checklist

- [ ] All active projects listed
- [ ] Statuses match actual state
- [ ] Phases are accurate
- [ ] No stale entries
- [ ] Links work
- [ ] Key files sections current

### How to Update

```
# Brain reads current file
github_get_file_contents(owner, "claude-project-template", "PROJECTS.md")

# Brain updates with new content
github_create_or_update_file(
  owner: "WasimNagy77",
  repo: "claude-project-template",
  path: "PROJECTS.md",
  message: "Update projects registry: [what changed]",
  content: "[full updated file content]"
)
```

### Sync with GitHub

PROJECTS.md should match what's actually in GitHub:
- If a repo exists but isn't listed → Add it
- If a repo is listed but deleted → Remove it
- If status differs from issues → Update PROJECTS.md

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
