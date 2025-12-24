# Claude Code Plugins Guide

## Available Official Plugins

Claude Code includes an official plugin marketplace from Anthropic with 23+ plugins.

### Recommended Plugins for Agency Workflow

| Plugin | Description |
|--------|-------------|
| `code-review` | Automated code review with multiple specialized agents and confidence scoring |
| `pr-review-toolkit` | Comprehensive PR review (comments, tests, error handling, type design, quality) |
| `security-guidance` | Security warnings for command injection, XSS, unsafe patterns |
| `commit-commands` | Streamlined git workflow for commits, pushes, PRs |
| `feature-dev` | Feature development workflow assistance |

### Language-Specific LSP Plugins

| Plugin | Language |
|--------|----------|
| `typescript-lsp` | TypeScript/JavaScript |
| `pyright-lsp` | Python |
| `rust-analyzer-lsp` | Rust |
| `gopls-lsp` | Go |
| `clangd-lsp` | C/C++ |
| `jdtls-lsp` | Java |
| `csharp-lsp` | C# |
| `php-lsp` | PHP |
| `swift-lsp` | Swift |
| `lua-lsp` | Lua |

### Utility Plugins

| Plugin | Description |
|--------|-------------|
| `agent-sdk-dev` | Agent SDK development tools |
| `plugin-dev` | Plugin development toolkit |
| `hookify` | Hook management utilities |
| `explanatory-output-style` | Detailed explanatory outputs |
| `learning-output-style` | Learning-focused outputs |

## Installation

### Interactive Installation
```bash
/plugin install
# Browse and select plugins
```

### Direct Installation
```bash
/plugin install code-review
/plugin install security-guidance
/plugin install commit-commands
```

### View Installed Plugins
```bash
/plugin list
```

### Update Plugins
```bash
/plugin update
```

## Plugin Locations

- Marketplace: `~/.claude/plugins/marketplaces/claude-plugins-official/`
- Installed: `~/.claude/plugins/installed_plugins.json`

## Creating Custom Plugins

See the official docs or use the `plugin-dev` plugin for guided creation.

Basic structure:
```
my-plugin/
├── .claude-plugin/
│   └── plugin.json       # Required manifest
├── commands/             # Slash commands
├── agents/               # Custom subagents
├── skills/               # Agent Skills
├── hooks/                # Event handlers
└── .mcp.json            # MCP server configs
```

## Community Marketplaces

- [claude-code-plugins-plus-skills](https://github.com/jeremylongshore/claude-code-plugins-plus-skills) - 243+ plugins
- [claude-plugins.dev](https://claude-plugins.dev/)
- [claudecodemarketplace.com](https://claudecodemarketplace.com/)
