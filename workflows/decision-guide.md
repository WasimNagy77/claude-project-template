# Decision Guide

Guide for deciding when to use direct API vs cloning, and which tools to use for different GitHub operations.

## When to Use Direct API vs Cloning

### Use Direct API (Preferred for speed)

| Operation | Tool | When |
|-----------|------|------|
| Read 1-5 files | github_get_file_contents | Quick lookups, checking configs |
| Create/update single file | github_create_or_update_file | Simple edits, adding docs |
| Delete a file | github_delete_file | Removing files (need SHA first) |
| List directory | github_get_file_contents (with dir path) | Exploring structure |
| Get full tree | github_get_tree | See all files recursively |

### Use Cloning (When necessary)

| Operation | Why Clone |
|-----------|-----------|
| Multi-file refactoring | Need atomic commits across files |
| Running tests locally | Need full repo context |
| Complex git operations | Rebase, cherry-pick, etc. |
| Working with git history | Blame, complex diffs |

## Tool Selection Guide

### Reading Files
1. First: Try github_get_file_contents (instant, no setup)
2. For directories: github_get_tree with recursive=true
3. Last resort: Clone if you need many files

### Writing Files
1. Single file: github_create_or_update_file
   - IMPORTANT: Get SHA first if updating existing file
   - Use github_get_file_contents to get the SHA
2. Multiple files: Clone → Edit → Commit → Push

### Issues
1. Check existing: github_list_issues before creating duplicates
2. Create: github_create_issue with labels/assignees
3. Update: github_update_issue to close or modify
4. Discuss: github_add_comment for updates

### Pull Requests
1. List: github_list_pull_requests to see open PRs
2. Review: github_get_pull_request for details
3. Approve: github_create_pr_review with event="APPROVE"
4. Comment: github_add_comment for general, github_create_pr_comment for line-specific

### Releases
1. Check: github_list_releases or github_get_latest_release
2. Create: github_create_release with tag_name
3. Auto-notes: Use generate_release_notes=true

### GitHub Actions
1. List workflows: github_list_workflows
2. Check runs: github_list_workflow_runs
3. Trigger: github_trigger_workflow (needs workflow_dispatch trigger)

## Best Practices

1. **Always get SHA before update/delete** - API requires it
2. **Check before creating** - Avoid duplicate issues/PRs
3. **Use labels** - Organize issues and PRs
4. **Prefer direct API** - Faster, no cleanup needed
5. **Clone path** - Uses ~/.github-mcp/repos/ (persists across reboots)

## Without MCP Access

If you don't have MCP tools, use equivalent options:

| MCP Tool | Alternative |
|----------|-------------|
| github_* API calls | `gh` CLI commands |
| github_get_file_contents | `cat` / Read tool |
| github_create_issue | `gh issue create` |
| github_list_pull_requests | `gh pr list` |

If `gh` CLI isn't available either, capture your intent in files:
```markdown
## Pending GitHub Actions
- [ ] Create issue: [title] with labels [labels]
- [ ] Review PR #X
```
