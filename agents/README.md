# Agency Subagents

Specialized AI agents for the agency workflow. Each agent has a specific role and expertise.

**Important:** All agents should follow the [WORKER.md](../WORKER.md) protocol for GitHub integration.

---

## GitHub Integration

Each agent corresponds to a GitHub label for task assignment:

| Agent | GitHub Label | Used For |
|-------|--------------|----------|
| strategy | `dept:strategy` | Requirements, planning |
| design | `dept:design` | UI/UX, visual |
| content | `dept:content` | Copy, blog posts |
| dev | `dept:dev` | Implementation |
| security | `dept:security` | Auth, hardening |
| qa | `dept:qa` | Testing, bugs |
| audit | `dept:audit` | Code review |
| seo | `dept:seo` | Search optimization |
| analytics | `dept:analytics` | Tracking, metrics |
| devops | `dept:devops` | CI/CD, deploy |
| assets | `dept:assets` | Images, media |
| client | `dept:client` | Communication |
| docs | `dept:docs` | Documentation |

### Brain → Worker Flow

1. **Brain** creates GitHub issue with `dept:[agent]` label
2. **Worker** (Claude Code) is spawned
3. **Worker** reads CLAUDE.md, finds assigned issue
4. **Worker** executes task following agent specialization
5. **Worker** creates PR when done
6. **Brain** reviews and merges

---

## Agent Categories

### CORE (Always Active)
| Agent | Role | Model |
|-------|------|-------|
| `strategy` | Project scoping, architecture, roadmaps | sonnet |
| `design` | UI/UX, accessibility, responsive design | sonnet |
| `content` | Copywriting, brand voice, documentation | sonnet |
| `dev` | Implementation, debugging, optimization | sonnet |
| `security` | Vulnerability assessment, OWASP, hardening | sonnet |

### Quality
| Agent | Role | Model |
|-------|------|-------|
| `qa` | Test planning, test writing, bug verification | sonnet |
| `audit` | Code audits, tech debt, standards enforcement | sonnet |

### Specialist
| Agent | Role | Model |
|-------|------|-------|
| `seo` | On-page SEO, meta tags, Core Web Vitals | sonnet |
| `analytics` | Tracking, funnels, data analysis | sonnet |
| `devops` | CI/CD, deployment, infrastructure | sonnet |

### Support
| Agent | Role | Model |
|-------|------|-------|
| `assets` | Image optimization, asset organization | haiku |
| `client` | Client communications, reports | sonnet |
| `docs` | Technical docs, API docs, guides | sonnet |

## Usage

### Automatic Delegation
Claude Code automatically delegates to the appropriate agent based on task:
```
Review my code for security issues
→ Uses security agent

Write API documentation for the user endpoints
→ Uses docs agent
```

### Explicit Invocation
```
Use the qa agent to write tests for the auth module
Use the seo agent to audit the homepage
```

### Managing Agents
```bash
/agents              # Interactive agent management
/agents list         # List available agents
```

## Installation

Copy the `agents/` folder to your project:
```bash
cp -r agents/ /path/to/your-project/.claude/agents/
```

Or symlink for shared use:
```bash
ln -s /path/to/claude-project-template/agents /path/to/your-project/.claude/agents
```
