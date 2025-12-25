# God Mode Setup Guide

How to set up the God Mode framework on a new machine.

## Quick Start (5 minutes)

### 1. Clone the Framework
```bash
git clone https://github.com/WasimNagy77/claude-project-template.git
cd claude-project-template
```

### 2. Read the Docs
Start with [README.md](./README.md) or [SESSION-LOG.md](./SESSION-LOG.md).

### 3. (Optional) Install MCP
For full automation with Claude Desktop, see [MCP Installation](#mcp-installation) below.

## Environment Capability Levels

| Environment | What Works | Setup Needed |
|-------------|------------|--------------|
| Claude Desktop + MCP | Everything (full God Mode) | Full setup below |
| Claude Code (terminal) | Git, files, bash | Just clone this repo |
| Claude Mobile | Git, files | Clone repo to device |
| Claude Web | Chat only | None (read-only) |

## Full Setup (Claude Desktop + MCP)

### Prerequisites
- Node.js 18+
- Git
- GitHub Personal Access Token

### Step 1: Get GitHub Token

1. Go to https://github.com/settings/tokens
2. Generate new token (classic) with scopes:
   - `repo` (full control of private repos)
   - `project` (read/write projects)
   - `workflow` (read/write actions)
3. Copy the token

### Step 2: Clone the MCP

```bash
cd ~/mcp-servers  # or wherever you keep MCPs
git clone https://github.com/WasimNagy77/github-full-mcp.git
cd github-full-mcp
npm install
npm run build
```

### Step 3: Configure Claude Desktop

Edit Claude Desktop config:
- **Linux:** `~/.config/Claude/claude_desktop_config.json`
- **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`

Add this section:
```json
{
  "mcpServers": {
    "github-full": {
      "command": "node",
      "args": ["/full/path/to/github-full-mcp/dist/index.js"],
      "env": {
        "GITHUB_TOKEN": "ghp_your_token_here"
      }
    }
  }
}
```

### Step 4: Restart Claude Desktop

Close and reopen Claude Desktop. You should now see the MCP tools available.

### Step 5: Test It

In Claude Desktop, try:
- "status of claude-project-template"
- "catch me up on what's happening"

## Minimal Setup (Claude Code Only)

If you just want to use Claude Code as a worker:

```bash
# Clone this framework
git clone https://github.com/WasimNagy77/claude-project-template.git

# Open in Claude Code
cd claude-project-template
claude .

# Claude will read CLAUDE.md and understand the workflow
```

## Mobile Setup

Claude on mobile can still:
- Read and edit repo files
- Run git commands (commit, push)
- Follow workflow guides manually

Just clone repos you want to work on and open them in Claude.

What mobile **cannot** do:
- GitHub API operations (issues, PRs, projects)
- These need `gh` CLI or MCP

**Workaround:** Capture tasks in STATUS.md or SESSION-LOG.md for later.

## Verifying Setup

### Check MCP is working (Claude Desktop)
Ask: "What GitHub tools do you have access to?"

Should list 40+ tools including:
- github_get_repository
- github_create_issue
- github_list_pull_requests

### Check prompts are working
Ask: "Can you run the decision-guide prompt?"

Should show the full decision guide content.

### Check git access (Claude Code)
```bash
git status
git log -1
```

## Troubleshooting

### MCP not showing up
1. Check config file path is correct
2. Verify JSON syntax is valid
3. Ensure GITHUB_TOKEN is set
4. Restart Claude Desktop

### "GITHUB_TOKEN required" error
Token not set. Check env in Claude Desktop config.

### Permission denied on repos
Token may lack required scopes. Regenerate with full `repo` scope.

### Can't find cloned repos
MCP clones to `~/.github-mcp/repos/`. Check there.

## Updating

### Update Framework
```bash
cd claude-project-template
git pull
```

### Update MCP
```bash
cd github-full-mcp
git pull
npm install
npm run build
# Restart Claude Desktop
```

## Uninstalling

### Remove MCP
1. Delete from Claude Desktop config
2. Remove MCP directory
3. Restart Claude Desktop

### Keep Using Without MCP
The framework still works! Use:
- Workflows in `workflows/` folder (manual steps)
- `gh` CLI for GitHub operations
- Git directly for commits
