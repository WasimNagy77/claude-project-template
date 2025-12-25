# Project Intake Workflow

Workflow for onboarding a new client project - creates repo, initializes structure, sets up tasks.

**Trigger:** "new project", "onboard client", "start new project"

## Parameters
- **project_name**: Name for the new project repository (e.g., "coffee-shop-website")
- **description**: Brief description of the project

## Steps

### Step 1: Create Repository
Use `github_create_repository` with:
- name: "{project_name}"
- description: "{description}"
- private: true
- auto_init: true

**Without MCP:**
```bash
gh repo create {project_name} --private --description "{description}"
```

### Step 2: Initialize Core Files
Use `github_create_or_update_file` for each:

#### CLAUDE.md (Core Memory)
```markdown
# {project_name}

{description}

## Stack
- Framework: Next.js 14
- Styling: Tailwind CSS
- Deployment: Vercel

## Conventions
- Components in src/components/
- API routes in src/app/api/
- Follow existing patterns

## Documentation
- Status: STATUS.md
- Session Log: SESSION-LOG.md
```

#### STATUS.md
```markdown
# Project Status

**Project:** {project_name}
**Phase:** Phase 1 - Setup
**Last Updated:** {current date}

## Progress
| Task | Status | Owner |
|------|--------|-------|
| Requirements | NOT STARTED | strategy |
| Design | NOT STARTED | design |
| Setup | NOT STARTED | dev |
```

#### SESSION-LOG.md
```markdown
# Session Log

## Current Session
**Date:** {current date}
**Status:** Project initialized

### What's Done
- Repository created
- Core files initialized
- Initial tasks created

### What's Next
- Requirements gathering
- Design direction
- Development setup
```

### Step 3: Create Phase 1 Milestone
Use `github_create_milestone` with:
- title: "Phase 1: Foundation"
- description: "Initial setup, requirements, and core structure"

**Without MCP:** `gh api repos/{owner}/{repo}/milestones -f title="Phase 1: Foundation"`

### Step 4: Create Initial Tasks
Use `github_create_issue` for each:

1. **Strategy Task**
   - title: "[strategy] Requirements gathering"
   - labels: ["dept:strategy", "priority:high", "status:ready"]
   - milestone: "Phase 1: Foundation"

2. **Design Task**
   - title: "[design] Visual direction and design system"
   - labels: ["dept:design", "priority:high", "status:ready"]
   - milestone: "Phase 1: Foundation"

3. **Dev Task**
   - title: "[dev] Project setup and scaffold"
   - labels: ["dept:dev", "priority:high", "status:ready"]
   - milestone: "Phase 1: Foundation"

**Without MCP:**
```bash
gh issue create -t "[strategy] Requirements gathering" -l "dept:strategy,priority:high"
gh issue create -t "[design] Visual direction" -l "dept:design,priority:high"
gh issue create -t "[dev] Project setup" -l "dept:dev,priority:high"
```

### Step 5: Add to Project Registry
Update PROJECTS.md in claude-project-template:
```markdown
| {project_name} | {project_name} | Phase 1 | High |
```

### Step 6: Report to User
```
✅ Project {project_name} created!

Repository: github.com/{owner}/{project_name}
Phase 1 Milestone created
3 initial tasks ready for workers

Next: Spawn workers for strategy, design, and dev tasks
```

## Output Format

```
🆕 PROJECT INTAKE: {project_name}

✅ CREATED
- Repository: {url}
- Core files: CLAUDE.md, STATUS.md, SESSION-LOG.md
- Milestone: Phase 1: Foundation

📋 INITIAL TASKS
1. #{num} [strategy] Requirements gathering
2. #{num} [design] Visual direction
3. #{num} [dev] Project setup

🚀 NEXT STEPS
1. Spawn strategy worker for requirements
2. Spawn design worker for visual direction
3. Spawn dev worker for scaffold

💡 TO START WORK
"Clone {owner}/{project_name}, read CLAUDE.md, work on issue #{num}"
```

## Without Full GitHub Access

If you can create the repo but not issues:
1. Create the repo
2. Add the core files (CLAUDE.md, STATUS.md, SESSION-LOG.md)
3. Document tasks to create later:

```markdown
## Pending Tasks for {project_name}
To create when back at desktop:
- [ ] [strategy] Requirements gathering
- [ ] [design] Visual direction
- [ ] [dev] Project setup
```
