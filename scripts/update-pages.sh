#!/bin/bash

set -e

# Workaround for git subtree bug: "fatal: assertion failed: test .gitignore = ."
# This manually performs what git subtree push would do

PREFIX="doc"
REMOTE="origin"
BRANCH="gh-pages"
TEMP_BRANCH="gh-pages-temp"

# Check if we're on a clean working directory
if ! git diff-index --quiet HEAD --; then
    echo "Error: Working directory has uncommitted changes. Please commit or stash them first."
    exit 1
fi

# Get the current branch name
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Fetch latest remote branches
git fetch "$REMOTE" "$BRANCH" 2>/dev/null || true

# Clean up any existing temp branch
if git show-ref --verify --quiet refs/heads/"$TEMP_BRANCH"; then
    git branch -D "$TEMP_BRANCH" 2>/dev/null || true
fi

echo "Extracting $PREFIX/ directory..."

# Create orphan branch (clean slate, no history)
# This is simpler and more reliable than filter-branch for gh-pages
git checkout --orphan "$TEMP_BRANCH"

# Remove any files that might exist in the orphan branch (if any)
git rm -rf . 2>/dev/null || true

# Checkout only the doc directory from the current branch
git checkout "$CURRENT_BRANCH" -- "$PREFIX"

# Move contents of doc/ to root
if [ -d "$PREFIX" ]; then
    # Move all files from PREFIX to root (including hidden files)
    shopt -s dotglob nullglob
    for item in "$PREFIX"/*; do
        if [ -e "$item" ] && [ "$(basename "$item")" != ".git" ]; then
            mv "$item" .
        fi
    done
    rmdir "$PREFIX" 2>/dev/null || true
fi

# Stage all changes
git add -A

# Commit
git commit -m "Update gh-pages from $PREFIX/ [auto-generated]"

# Push to remote
echo "Pushing to $REMOTE $BRANCH..."
git push "$REMOTE" "$TEMP_BRANCH:$BRANCH" --force

# Return to original branch
git checkout "$CURRENT_BRANCH"

# Clean up temp branch
git branch -D "$TEMP_BRANCH" 2>/dev/null || true

echo "Successfully pushed $PREFIX/ to $REMOTE $BRANCH"
