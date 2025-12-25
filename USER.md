# User Role - Human Operator

**You are the human operator of the God Mode framework.**

This document defines your role, responsibilities, and how to interact with the system.

---

## Your Identity

- **Name:** Wasim (or whoever is operating the framework)
- **Role:** Owner, Decision Maker, Quality Gate
- **Environment:** Any (conversation with Brain, reviewing GitHub, etc.)

---

## Your Responsibilities

### Strategic

| Responsibility | Description |
|----------------|-------------|
| Vision | Define what projects should accomplish |
| Priorities | Decide what gets worked on first |
| Scope | Approve or reject scope changes |
| Quality | Final approval on releases |

### Operational

| Responsibility | Description |
|----------------|-------------|
| Spawning Workers | Start Claude Code sessions for tasks |
| Reviewing | Check Brain's standup reports |
| Deciding | Resolve escalations and blockers |
| Approving | Green-light releases and merges |

### Maintenance

| Responsibility | Description |
|----------------|-------------|
| Credentials | Provide API keys, access tokens |
| Environment | Set up MCP, configure tools |
| Oversight | Check that system is working |

---

## What You DON'T Do

- ❌ Write code (Workers do this)
- ❌ Create issues manually (Brain does this)
- ❌ Update STATUS.md (Brain does this)
- ❌ Manage project boards (Brain does this)

Your job is to **direct** and **decide**, not to execute.

---

## Human-in-the-Loop Points

These are moments when the system MUST wait for your input:

### Always Require Your Approval

| Action | Why |
|--------|-----|
| Deploying to production | Risk of breaking live site |
| Deleting data | Irreversible |
| Major scope changes | Budget/timeline impact |
| New project creation | Resource commitment |
| Closing milestones | Verify completion |

### Should Get Your Input

| Action | Why |
|--------|-----|
| Architecture decisions | Long-term impact |
| Third-party integrations | Security/cost |
| Priority changes | Resource allocation |
| Escalations | Unblock workers |

### Can Proceed Without You

| Action | Why |
|--------|-----|
| Creating issues | Routine operation |
| Reviewing PRs | Brain can approve |
| Updating docs | Low risk |
| Routine commits | Normal workflow |

---

## Daily Interaction Pattern

### Morning (5 minutes)

1. Brain presents standup report
2. Review completed work
3. Note any blockers
4. Confirm priorities for the day

### During Day (As Needed)

1. Respond to escalations
2. Answer questions in GitHub
3. Spawn workers for new tasks

### End of Day (Optional)

1. Check what was accomplished
2. Adjust priorities for tomorrow

---

## How to Give Instructions

### To Brain (Claude Desktop)

Just talk naturally:
- "What's the status of nail candy?"
- "Create a task for the dev to add a booking system"
- "Let's release version 1.0"

Brain will use appropriate workflows.

### To Workers (via Brain)

Don't talk to Workers directly. Tell Brain:
- "Have a worker implement the booking API"
- Brain creates issue, you spawn Claude Code

### Spawning a Worker

When Brain says "Task ready, spawn worker":

1. Open Claude Code (terminal)
2. Navigate to project: `cd [project-folder]`
3. Say: "Read CLAUDE.md, then work on issue #X"

---

## Decision Templates

### Approving a Release

```
Brain: "Version 1.0 ready to release. Changelog: [list]. Approve?"
You: "Approved. Release it."
```

### Resolving an Escalation

```
Brain: "Worker blocked on #42. Needs database credentials."
You: "Here are the credentials: [provide]. Continue."
```

### Changing Priorities

```
Brain: "Currently working on: A, B, C"
You: "Stop C, focus on A. Start D after A is done."
```

### Rejecting Scope

```
Brain: "Worker wants to refactor the auth system."
You: "No. Stay focused on the original task. We'll refactor later."
```

---

## Your Tools

| Tool | When to Use |
|------|-------------|
| Claude Desktop | Talking to Brain |
| Claude Code | Spawning Workers |
| GitHub Web | Reviewing PRs, Issues |
| Terminal | Manual git operations |

---

## Emergency Actions

### Stop All Work

Tell Brain: "Stop all work. Don't merge anything. Wait for my instructions."

### Rollback

Tell Brain: "Revert the last release" or "Undo PR #X"

### Reset

If everything is broken:
1. Tell Brain to document current state
2. Review GitHub directly
3. Make manual fixes if needed
4. Resume with clear instructions

---

## Quick Reference

### Your Daily Questions

- "What happened yesterday?"
- "What's blocked?"
- "What's the priority today?"
- "Show me what's ready to review"

### Your Decision Phrases

- "Approved"
- "Not approved. [reason]"
- "Hold on that. Let's discuss."
- "Change priority to X"
- "Spawn a worker for that"

### Your Escape Hatches

- "Stop and explain what you're doing"
- "Don't do anything until I approve"
- "Wait for my decision on this"
