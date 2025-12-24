# Agency Subagents

Specialized AI agents for the agency workflow. Each agent has a specific role and expertise.

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
