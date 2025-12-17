# Project Template

A template repository with built-in AI assistant support, documentation structure, and security best practices.

## Features

- **AI-Ready Documentation** - Pre-configured for Claude Code and other AI assistants
- **Project Memory** - Persistent context across sessions via `docs/project-context.md`
- **Security First** - Security checklist and guidelines included
- **Contribution Guidelines** - Clear workflow for humans and AI
- **Changelog Tracking** - Keep a Changelog format
- **GitHub Integration** - PR template and Dependabot configured

## Quick Start

1. Click "Use this template" on GitHub
2. Clone your new repository
3. Update placeholder values:
   - `docs/project-context.md` - Fill in project details
   - `SECURITY.md` - Add security contact email
   - `README.md` - Replace with your project info
4. Start building!

## Documentation Structure

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Instructions for AI assistants |
| `docs/project-context.md` | Project memory and history |
| `CONTRIBUTING.md` | Workflow for all contributors |
| `CHANGELOG.md` | Track all changes |
| `SECURITY.md` | Security policy and checklist |

## For AI Assistants

When working on projects using this template:

1. **Start** by reading `docs/project-context.md`
2. **Follow** the workflow in `CONTRIBUTING.md`
3. **Update** project-context.md after each session
4. **Update** CHANGELOG.md before each commit

See `CLAUDE.md` for complete AI instructions.

## GitHub Configuration

### Included
- `.github/pull_request_template.md` - PR checklist
- `.github/dependabot.yml` - Weekly npm security updates

### Recommended Repository Settings
- Enable branch protection on `main`
- Require PR reviews before merging
- Enable Dependabot alerts

## Tech Stack Assumptions

This template assumes a Node.js/Next.js project. Modify `.gitignore` and configurations as needed for other stacks.

## License

[Choose your license]

---

**Created from [claude-project-template](https://github.com/WasimNagy77/claude-project-template)**
