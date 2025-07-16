#!/bin/bash

# OSS Fork Synchronization Script
# This script reads the oss-sync-config.yml file and syncs all fork repositories with their upstream sources

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration file path (absolute path to avoid issues when changing directories)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/oss-sync-config.yml"

# Check if yq is installed (required for YAML parsing)
if ! command -v yq &> /dev/null; then
    echo -e "${RED}Error: yq is required but not installed.${NC}"
    echo "Install it with: brew install yq"
    exit 1
fi

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}Error: Configuration file $CONFIG_FILE not found.${NC}"
    exit 1
fi

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to sync a single repository
sync_repository() {
    local repo_name="$1"
    local fork_repo="$2"
    local upstream_repo="$3"
    local local_path="$4"
    
    echo
    echo "=========================================="
    print_status "Syncing repository: $repo_name"
    echo "Fork: $fork_repo"
    echo "Upstream: $upstream_repo"
    echo "Local path: $local_path"
    echo "=========================================="
    
    # Check if local directory exists
    if [ ! -d "$local_path" ]; then
        print_warning "Local directory $local_path does not exist. Cloning from fork..."
        
        # Create parent directory if it doesn't exist
        mkdir -p "$(dirname "$local_path")"
        
        # Clone the fork repository
        if git clone "https://github.com/$fork_repo.git" "$local_path"; then
            print_success "Successfully cloned $fork_repo"
        else
            print_error "Failed to clone $fork_repo"
            return 1
        fi
    fi
    
    # Navigate to the repository directory
    cd "$local_path" || {
        print_error "Failed to navigate to $local_path"
        return 1
    }
    
    print_status "Working in directory: $(pwd)"
    
    # Stash any local changes
    if git status --porcelain | grep -q .; then
        print_warning "Local changes detected. Stashing them..."
        git stash push -m "Auto-stash before sync on $(date)"
    fi
    
    # Check if upstream remote exists
    if git remote | grep -q "^upstream$"; then
        print_status "Upstream remote already exists"
        
        # Update upstream URL in case it changed
        git remote set-url upstream "https://github.com/$upstream_repo.git"
        print_status "Updated upstream URL to https://github.com/$upstream_repo.git"
    else
        print_status "Adding upstream remote..."
        git remote add upstream "https://github.com/$upstream_repo.git"
        print_success "Added upstream remote: https://github.com/$upstream_repo.git"
    fi
    
    # Fetch from upstream
    print_status "Fetching from upstream..."
    if git fetch upstream; then
        print_success "Successfully fetched from upstream"
    else
        print_error "Failed to fetch from upstream"
        return 1
    fi
    
    # Fetch from origin (your fork)
    print_status "Fetching from origin..."
    if git fetch origin; then
        print_success "Successfully fetched from origin"
    else
        print_error "Failed to fetch from origin"
        return 1
    fi
    
    # Get the default branch name from upstream
    default_branch=$(git symbolic-ref refs/remotes/upstream/HEAD 2>/dev/null | sed 's@^refs/remotes/upstream/@@' || echo "main")
    
    # If upstream/HEAD doesn't exist, try to determine the default branch
    if [ -z "$default_branch" ] || [ "$default_branch" = "main" ]; then
        if git show-ref --verify --quiet refs/remotes/upstream/main; then
            default_branch="main"
        elif git show-ref --verify --quiet refs/remotes/upstream/master; then
            default_branch="master"
        else
            print_error "Could not determine default branch for upstream"
            return 1
        fi
    fi
    
    print_status "Default branch detected: $default_branch"
    
    # Switch to the default branch
    print_status "Switching to $default_branch branch..."
    if git checkout "$default_branch" 2>/dev/null || git checkout -b "$default_branch" "upstream/$default_branch"; then
        print_success "Successfully switched to $default_branch branch"
    else
        print_error "Failed to switch to $default_branch branch"
        return 1
    fi
    
    # Reset to upstream default branch
    print_status "Resetting to upstream/$default_branch..."
    if git reset --hard "upstream/$default_branch"; then
        print_success "Successfully reset to upstream/$default_branch"
    else
        print_error "Failed to reset to upstream/$default_branch"
        return 1
    fi
    
    # Push the updated default branch to your fork
    print_status "Pushing updated $default_branch to your fork..."
    if git push origin "$default_branch" --force-with-lease; then
        print_success "Successfully pushed $default_branch to origin"
    else
        print_error "Failed to push $default_branch to origin"
        return 1
    fi
    
    # Clean up any local branches that are fully merged
    print_status "Cleaning up merged branches..."
    merged_branches=$(git branch --merged | grep -v "\*\|$default_branch\|master\|main" | tr -d ' ')
    if [ -n "$merged_branches" ]; then
        echo "$merged_branches" | xargs -n 1 git branch -d
        print_success "Cleaned up merged branches"
    else
        print_status "No merged branches to clean up"
    fi
    
    # Prune remote tracking branches
    print_status "Pruning remote tracking branches..."
    git remote prune origin
    git remote prune upstream
    
    # Run git garbage collection
    print_status "Running garbage collection..."
    git gc --auto
    
    print_success "Repository $repo_name synchronized successfully!"
}

# Main execution
main() {
    echo "======================================================"
    echo "OSS Fork Synchronization Script"
    echo "======================================================"
    
    # Get the number of repositories
    repo_count=$(yq eval '.repositories | length' "$CONFIG_FILE")
    print_status "Found $repo_count repositories to sync"
    
    # Initialize counters
    success_count=0
    error_count=0
    
    # Process each repository
    for i in $(seq 0 $((repo_count - 1))); do
        repo_name=$(yq eval ".repositories[$i].name" "$CONFIG_FILE")
        fork_repo=$(yq eval ".repositories[$i].fork" "$CONFIG_FILE")
        upstream_repo=$(yq eval ".repositories[$i].upstream" "$CONFIG_FILE")
        local_path=$(yq eval ".repositories[$i].local_path" "$CONFIG_FILE")
        
        if sync_repository "$repo_name" "$fork_repo" "$upstream_repo" "$local_path"; then
            ((success_count++))
        else
            ((error_count++))
            print_error "Failed to sync $repo_name"
        fi
    done
    
    # Final summary
    echo
    echo "======================================================"
    echo "SYNCHRONIZATION SUMMARY"
    echo "======================================================"
    print_success "Successfully synchronized: $success_count repositories"
    if [ $error_count -gt 0 ]; then
        print_error "Failed to synchronize: $error_count repositories"
    fi
    echo "Total repositories processed: $repo_count"
    echo "======================================================"
    
    # Exit with error code if any repositories failed
    if [ $error_count -gt 0 ]; then
        exit 1
    fi
}

# Run the main function
main "$@" 
