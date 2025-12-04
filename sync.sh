#!/bin/bash
# sync.sh - Commits and pushes changes automatically

cd "$HOME/Developer/seema-setup" || exit

# Check if there are changes
if [[ -n $(git status -s) ]]; then
    echo "Changes detected, committing..."
    git add -A
    git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo "✅ Synced to GitHub"
else
    echo "No changes to sync"
fi
