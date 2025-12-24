# Chrome Integration Setup

Claude Code v2.0.76+ supports direct Chrome browser integration for debugging, automation, and testing.

## Prerequisites

- Google Chrome (must be running)
- Claude in Chrome extension v1.0.36+
- Claude Code CLI v2.0.73+ (you have v2.0.76)
- Paid Claude plan (Pro, Team, or Enterprise)

## Setup Steps

### 1. Install Chrome Extension

1. Open Chrome
2. Go to [Chrome Web Store - Claude by Anthropic](https://chromewebstore.google.com/detail/claude/hbpcpgehpgbgkkhfbmfmpggphfpglnmg)
3. Click "Add to Chrome"
4. Verify extension is enabled

### 2. Enable in Claude Code

```bash
# Start with Chrome enabled (one-time)
claude --chrome

# Or enable by default
/chrome
# Then select "Enable by default"
```

### 3. Verify Connection

```bash
/chrome
```

## Use Cases

### Live Debugging
```
Check the console for errors on localhost:3000
```

### Form Automation
```
Go to amazon.com and search for "USB-C cables"
```

### Data Extraction
```
Extract all product names and prices from this page as JSON
```

### Design Testing
```
Take a screenshot and compare against the Figma mockup
```

### Authenticated Workflows
```
Open my Google Doc and summarize the content
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Extension not detected | Check Chrome is running, verify v1.0.36+, run `/chrome` → "Reconnect extension" |
| Browser not responding | Check for modal dialogs, create new tab, restart extension |
| Setup errors | Restart Chrome for native messaging host installation |

## Important Notes

- Requires visible browser window (no headless mode)
- Modal dialogs interrupt flow - dismiss manually and tell Claude to continue
- Increases context usage when enabled by default
- Works with sites you're already logged into
