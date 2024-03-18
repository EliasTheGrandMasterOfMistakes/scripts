#!/bin/bash



repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs

# Sync repositories and capture the output
output=$(repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags 2>&1)

# Check if there are any failing repositories
if echo "$output" | grep -q "Failing repos:"; then
    echo "Deleting failing repositories..."
    # Extract failing repositories from the error message and echo the deletion path
    while IFS= read -r line; do
        # Extract repository name and path from the error message
        repo_info=$(echo "$line" | awk -F': ' '{print $NF}')
        repo_path=$(dirname "$repo_info")
        repo_name=$(basename "$repo_info")
        # Echo the deletion path
        echo "Deleted repository: $repo_info"
        # Delete the repository
        rm -rf "$repo_path/$repo_name"
    done <<< "$(echo "$output" | awk '/Failing repos:/ {flag=1; next} /Repo command failed due to the following `SyncError` errors:/ {flag=0} flag')"

    # Re-sync all repositories after deletion
    echo "Re-syncing all repositories..."
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
else
    echo "All repositories synchronized successfully."
echo "Deleted repository: $repo_info"
fi
