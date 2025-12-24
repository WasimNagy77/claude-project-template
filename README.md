# Claude Project Template

A comprehensive template repository with AI assistant support, agency workflow, and Claude Code integrations.

## Features

- **AI-Ready Documentation** - Pre-configured for Claude Code and AI assistants
- **13 Agency Subagents** - Specialized agents for strategy, design, dev, security, QA, and more
- **Framework Scripts** - Project orchestration and intake automation
- **Session Continuity** - Handoff system for multi-session projects
- **Chrome Integration** - Browser automation and debugging
- **Plugin System** - Extensible with official and custom plugins
- **Security First** - Security checklist and guidelines included

## Quick Start

1. Click "Use this template" on GitHub
2. Clone your new repository
3. Copy agents to your project:
   ```bash
   cp -r agents/ /path/to/your-project/.claude/agents/
   ```
4. Update placeholder values in `docs/project-context.md`
5. Start building!

## Directory Structure

```
claude-project-template/
├── agents/                 # 13 specialized subagents
│   ├── strategy.md        # Project scoping, architecture
│   ├── design.md          # UI/UX, accessibility
│   ├── content.md         # Copywriting, brand voice
│   ├── dev.md             # Implementation, debugging
│   ├── security.md        # Vulnerability assessment
│   ├── qa.md              # Testing, quality assurance
│   ├── audit.md           # Code audits, tech debt
│   ├── seo.md             # SEO optimization
│   ├── analytics.md       # Tracking, data analysis
│   ├── devops.md          # CI/CD, deployment
│   ├── assets.md          # Asset management
│   ├── client.md          # Client communications
│   └── docs.md            # Documentation
├── framework/              # Automation scripts
│   ├── orchestrator.sh    # Agency department orchestration
│   └── project-intake.sh  # Project intake automation
├── sessions/               # Session handoff files
├── docs/
│   ├── project-context.md # Project memory
│   ├── chrome-integration.md
│   └── plugins-guide.md
├── CLAUDE.md              # AI instructions
├── CONTRIBUTING.md        # Workflow rules
├── SECURITY.md           # Security checklist
└── CHANGELOG.md          # Version history
```

## Agency Subagents

13 specialized agents organized by department:

| Category | Agents |
|----------|--------|
| **CORE** | strategy, design, content, dev, security |
| **Quality** | qa, audit |
| **Specialist** | seo, analytics, devops |
| **Support** | assets, client, docs |

See [agents/README.md](agents/README.md) for details.

## Claude Code Features

### Chrome Integration
Browser automation for debugging, form filling, and testing.
See [docs/chrome-integration.md](docs/chrome-integration.md)

### Plugins
Official plugins for code review, security, and workflow automation.
See [docs/plugins-guide.md](docs/plugins-guide.md)

### Session Continuity
Handoff files in `sessions/` enable seamless multi-session projects.

## Documentation

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Instructions for AI assistants |
| `docs/project-context.md` | Project memory and history |
| `CONTRIBUTING.md` | Workflow for all contributors |
| `CHANGELOG.md` | Track all changes |
| `SECURITY.md` | Security policy and checklist |

## GitHub Integration

- `.github/pull_request_template.md` - PR checklist
- `.github/dependabot.yml` - Weekly security updates

## License

MIT

---

**Maintained by [WasimNagy77](https://github.com/WasimNagy77)**
