# Contributing Guidelines

This guide ensures all changes follow project standards and maintain quality.

---

## Before You Start

### Required Reading

1. **[docs/project-context.md](./docs/project-context.md)** - Project history and current status
2. **[SECURITY.md](./SECURITY.md)** - Security policy and checklist
3. **[README.md](./README.md)** - Project overview
4. **[CHANGELOG.md](./CHANGELOG.md)** - Recent changes

---

## Workflow for Every Change

### Step 1: Before Writing Code

- [ ] Read relevant documentation (see above)
- [ ] Check existing issues/PRs for similar work
- [ ] Understand security implications of your change
- [ ] Run `git pull` to get latest changes

### Step 2: Make Your Changes

- [ ] Write clean, well-structured code
- [ ] Follow existing code patterns
- [ ] Add tests for new features
- [ ] Run `npm audit` to check for vulnerabilities

### Step 3: Update Documentation

**You must update these files:**

1. **CHANGELOG.md** - Add entry under `[Unreleased]`:
   ```markdown
   ## [Unreleased]

   ### Added
   - Your new feature description

   ### Changed
   - What you modified

   ### Fixed
   - Bugs you fixed

   ### Security
   - Security improvements
   ```

2. **docs/project-context.md** - Update:
   - Session History (add new entry)
   - Current Status
   - Next Steps

3. **README.md** - If you added major features or changed setup

### Step 4: Security Checklist

Before committing, verify:

- [ ] No secrets or API keys in code
- [ ] No `.env` files committed
- [ ] Environment variables properly named
- [ ] Input validation for user inputs
- [ ] Dependencies scanned: `npm audit`

### Step 5: Commit Your Changes

**Commit message format:**
```
Brief description (50 chars or less)

- What changed
- Why it changed
- Reference to CHANGELOG.md update
```

### Step 6: Create Pull Request

Use the PR template and complete all checklist items.

---

## Instructions for AI Models

**If you are an AI assistant working on this project:**

### Automatic Steps for Every Change

1. Read `docs/project-context.md` first
2. Update `CHANGELOG.md` under `[Unreleased]`
3. Update `docs/project-context.md` with session history
4. Follow security checklist
5. Generate descriptive commit messages

### Example AI Workflow

```
User: "Add a contact form"

AI Actions:
1. Read docs/project-context.md for context
2. Review SECURITY.md for form requirements
3. Implement form with security measures
4. Update CHANGELOG.md:
   ### Added
   - Contact form with validation
5. Update docs/project-context.md:
   - Add session history entry
   - Update current status
6. Commit with descriptive message
```

### Critical Rules

- Never commit without updating CHANGELOG.md
- Never skip security measures
- Never commit secrets or API keys
- Always read documentation first
- Always update project-context.md

---

## Common Scenarios

### Adding a New Feature
1. Read project context
2. Implement feature
3. Update CHANGELOG.md (Added section)
4. Update docs/project-context.md
5. Commit with descriptive message

### Fixing a Bug
1. Identify and fix the bug
2. Update CHANGELOG.md (Fixed section)
3. Add test to prevent regression
4. Commit with bug reference

### Updating Dependencies
1. Run `npm audit`
2. Update packages
3. Test changes
4. Update CHANGELOG.md (Security section)
5. Commit and verify

---

## File Update Requirements

| When You... | Update These Files |
|-------------|-------------------|
| Add feature | CHANGELOG.md, docs/project-context.md, README.md (if major) |
| Fix bug | CHANGELOG.md |
| Add security measure | CHANGELOG.md, SECURITY.md |
| Add dependency | CHANGELOG.md, package-lock.json |
| Make any progress | docs/project-context.md |

---

## What NOT to Do

- Commit without updating CHANGELOG.md
- Skip security checklist items
- Add dependencies without review
- Commit secrets or API keys
- Push directly to main without PR
- Use vague commit messages like "fix" or "update"

---

## Quick Checklist

**Before every commit:**
- [ ] CHANGELOG.md updated
- [ ] docs/project-context.md updated
- [ ] Security checklist completed
- [ ] No secrets committed
- [ ] `npm audit` clean
- [ ] Descriptive commit message

---

**Last Updated:** [DATE]
