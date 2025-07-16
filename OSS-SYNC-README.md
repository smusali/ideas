# OSS Fork Synchronization

This directory contains tools to automatically synchronize your OSS fork repositories with their upstream sources.

## Files

- `oss-sync-config.yml` - Configuration file containing all your fork repositories
- `sync-oss-forks.sh` - Bash script that performs the synchronization
- `OSS-SYNC-README.md` - This documentation file

## Prerequisites

1. **Install yq** (YAML processor):
   ```bash
   brew install yq
   ```

2. **Git authentication** - Make sure you can push to your GitHub forks (either via SSH keys or GitHub CLI)

## Configuration

The `oss-sync-config.yml` file contains all your repositories with the following structure:

```yaml
repositories:
  - name: repo-name
    fork: smusali/repo-name
    upstream: original-owner/repo-name
    local_path: /absolute/path/to/local/repo
```

## Usage

### Basic Synchronization

Run the script to sync all repositories:

```bash
./sync-oss-forks.sh
```

### What the Script Does

For each repository, the script will:

1. **Clone if needed** - If the local directory doesn't exist, it clones your fork
2. **Stash local changes** - Safely stashes any uncommitted changes
3. **Add/update upstream remote** - Ensures the upstream remote is configured correctly
4. **Fetch updates** - Fetches latest changes from both origin (your fork) and upstream
5. **Detect default branch** - Automatically detects whether upstream uses `main` or `master`
6. **Reset to upstream** - Resets your local default branch to match upstream
7. **Force push to fork** - Updates your fork with the latest upstream changes
8. **Clean up** - Removes merged branches and runs garbage collection

### Safety Features

- **Stashes local changes** before syncing (they're preserved)
- **Force-with-lease** push to avoid overwriting others' work
- **Error handling** with colored output for easy debugging
- **Summary report** showing success/failure counts

### Example Output

```
======================================================
OSS Fork Synchronization Script
======================================================
[INFO] Found 14 repositories to sync

==========================================
[INFO] Syncing repository: django
Fork: smusali/django
Upstream: django/django
Local path: /Users/smusali/github/smusali/django
==========================================
[INFO] Working in directory: /Users/smusali/github/smusali/django
[INFO] Upstream remote already exists
[INFO] Updated upstream URL to https://github.com/django/django.git
[INFO] Fetching from upstream...
[SUCCESS] Successfully fetched from upstream
[INFO] Fetching from origin...
[SUCCESS] Successfully fetched from origin
[INFO] Default branch detected: main
[INFO] Switching to main branch...
[SUCCESS] Successfully switched to main branch
[INFO] Resetting to upstream/main...
[SUCCESS] Successfully reset to upstream/main
[INFO] Pushing updated main to your fork...
[SUCCESS] Successfully pushed main to origin
[INFO] Cleaning up merged branches...
[SUCCESS] Cleaned up merged branches
[INFO] Pruning remote tracking branches...
[INFO] Running garbage collection...
[SUCCESS] Repository django synchronized successfully!
```

## Customization

### Adding New Repositories

To add a new repository, edit `oss-sync-config.yml` and add a new entry:

```yaml
  - name: new-repo
    fork: smusali/new-repo
    upstream: original-owner/new-repo
    local_path: /Users/smusali/github/smusali/new-repo
```

### Modifying Local Paths

Update the `local_path` field in the configuration if you want to change where repositories are stored locally.

### Upstream Repository Changes

If an upstream repository changes ownership or name, just update the `upstream` field in the configuration.

## Troubleshooting

### Common Issues

1. **"yq not found"** - Install yq with `brew install yq`
2. **Permission denied** - Make sure the script is executable: `chmod +x sync-oss-forks.sh`
3. **Git authentication failed** - Ensure you can push to your GitHub forks
4. **Directory doesn't exist** - The script will automatically clone missing repositories

### Manual Recovery

If something goes wrong, you can always:

1. Check your stashed changes: `git stash list`
2. Restore stashed changes: `git stash pop`
3. Reset to a specific commit: `git reset --hard <commit-hash>`

## Best Practices

1. **Run regularly** - Sync your forks before starting new contributions
2. **Check for conflicts** - Review any stashed changes after syncing
3. **Backup important work** - Commit or backup any important local changes before syncing
4. **Test the script** - Run on a single repository first if you're unsure

## Schedule Automation

You can set up a cron job to run this automatically:

```bash
# Run every Monday at 9 AM
0 9 * * 1 cd /Users/smusali/github/smusali/ideas && ./sync-oss-forks.sh
``` 
