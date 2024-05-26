#!/bin/bash

# Function to find the last commit in February and revert the repository
revert_repo_to_february() {
  local repo_path=$1
  cd "$repo_path" || { echo "Error: Could not change directory to $repo_path"; return 1; }

  # Find the last commit made in February on the current branch or the default branch
  default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  commit_hash=$(git rev-list -1 --before="2023-03-01 00:00" --after="2023-02-01 00:00" "$default_branch" 2>/dev/null || git rev-list -1 --before="2023-03-01 00:00" --after="2023-02-01 00:00" HEAD)

  # Check if a valid commit hash was found
  if [ -z "$commit_hash" ]; then
    echo "No commits found in February in $repo_path"
  else
    # Reset the repository to that commit
    git reset --hard "$commit_hash" || { echo "Error: Failed to reset repository $repo_path"; return 1; }
    echo "Reverted $repo_path to the last commit in February: $commit_hash"
  fi

  # Go back to the previous directory
  cd - > /dev/null || { echo "Error: Failed to change directory back to previous directory"; return 1; }
}

# Export the function to use it recursively
export -f revert_repo_to_february

# Function to recursively find Git repositories and revert them
find_and_revert_repositories() {
  local start_dir=$1
  for dir in "$start_dir"/*/; do
    if [ -d "$dir/.git" ]; then
      echo "Reverting repository in $dir"
      revert_repo_to_february "$dir"
    fi
    find_and_revert_repositories "$dir"  # Recursively search subdirectories
  done
}

# Start searching from the current directory
find_and_revert_repositories "$(pwd)"
