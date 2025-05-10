#!/bin/bash

# # Set the working directory to your repo
# cd /path/to/your/repo || exit

# Add all changes
git add .

# Commit with a timestamp
git commit -m "Auto-commit on $(date '+%Y-%m-%d %H:%M:%S')"

# Push to the remote repo (assuming origin and main branch)
git push origin main
