# Release Workflow

Complete workflow for creating a new release.

**Trigger:** "let's release X", "create release", "ship it"

## Parameters
- **owner**: Repository owner
- **repo**: Repository name
- **version**: Version tag (e.g., v1.0.0)

## Steps

### Step 1: Pre-Release Checks
1. Use `github_list_pull_requests` with state="open" - ensure no blocking PRs
2. Use `github_list_workflow_runs` to verify CI is green on main
3. Use `github_list_milestones` to check milestone completion
   - All issues in target milestone should be closed
   - If open issues remain, list them as blockers
4. Use `github_compare_commits` to see changes since last release

**Without MCP:**
```bash
gh pr list -s open
gh run list -L 5
gh api repos/{owner}/{repo}/milestones
git log $(git describe --tags --abbrev=0)..HEAD --oneline
```

### Step 2: Check Previous Releases
Use `github_get_latest_release` to see:
- Previous version tag
- Release notes format
- Any patterns to follow

**Without MCP:** `gh release view --json tagName,body`

### Step 3: Create the Release
Use `github_create_release` with:
- tag_name: "{version}"
- name: "Release {version}" (or your preferred format)
- generate_release_notes: true (auto-generates from PRs)
- OR provide custom body with changelog

**Without MCP:**
```bash
gh release create {version} --generate-notes
# OR with custom notes:
gh release create {version} --notes "Release notes here"
```

### Step 4: Verify Release
Use `github_list_releases` to confirm it appears

**Without MCP:** `gh release list`

### Step 5: Post-Release
1. Close related issues with `github_update_issue`
2. Notify in relevant issues/PRs with `github_add_comment`
3. Update project board items with `move_item`

**Without MCP:**
```bash
gh issue close {number} -c "Released in {version}"
```

## Versioning Guide

Follow Semantic Versioning (SemVer):
- **MAJOR** (v2.0.0): Breaking changes
- **MINOR** (v1.1.0): New features, backwards compatible
- **PATCH** (v1.0.1): Bug fixes, backwards compatible

## Release Checklist

Before creating release:
- [ ] All tests passing
- [ ] No open blocking PRs
- [ ] Milestone issues closed
- [ ] CHANGELOG updated
- [ ] Version bumped in package.json (if applicable)

## Output Format

```
🚀 RELEASE: {version}

📋 PRE-RELEASE CHECK
- Open PRs: {count} (should be 0 blocking)
- CI Status: ✅ / ❌
- Milestone: {X}/{Y} issues closed

📝 CHANGES SINCE LAST RELEASE
- {commit count} commits
- {summary of changes}

✅ RELEASE CREATED
Tag: {version}
URL: {release_url}

📢 POST-RELEASE
- Issues closed: #{list}
- Notifications sent: #{list}
```

## Without GitHub Access

If you can't create the release directly:

```markdown
## Release Notes Draft - {version}

Ready to publish when back at desktop:

### Changes
- Feature: {description}
- Fix: {description}

### Breaking Changes
- {if any}

### Command to run:
gh release create {version} --generate-notes
```
