# Sanity checks ...
#   -e  : Exit immediately if any command fails (non-zero exit code).
#   -u  : Treat unset variables as an error and exit immediately.
#   -o pipefail : In a pipeline (cmd1 | cmd2 | cmd3), return the exit code
#                 of the first failing command instead of just the last one.
set -euo pipefail

# Print commands as they are executed so we can see what's happening without a million echo statements.
set -x

# -------------------------------
# Config
# -------------------------------
REPO_NAME="demo-repo-$$" # unique name using PID
WORKDIR="$(mktemp -d)"
REMOTE="origin"

# -------------------------------
# Cleanup function
# -------------------------------
cleanup() {
  echo -e "\n\nOur final git config for this test before cleanup:"
  echo -e "=== .git/config ===\n\n"
  cat $WORKDIR/.git/config
  echo "Cleaning up..."
  if command -v gh >/dev/null 2>&1; then
    echo "Attempting to delete remote repo $REPO_NAME..."
    if ! gh repo delete "$REPO_NAME" --yes >/dev/null 2>&1; then
      echo "⚠️  Failed to delete repo $REPO_NAME."
      echo "   You may need to grant the 'delete_repo' scope with:"
      echo "   gh auth refresh -h github.com -s delete_repo"
    else
      echo "✅ Remote repo $REPO_NAME deleted."
    fi
  fi
  rm -rf "$WORKDIR"
}
trap cleanup EXIT

# -------------------------------
# Pre-checks
# -------------------------------
if ! command -v gh >/dev/null 2>&1; then
  echo "❌ GitHub CLI (gh) is not installed. Aborting."
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "❌ GitHub CLI is not authenticated. Run 'gh auth login' first."
  exit 1
fi

echo "✅ gh is installed and authenticated."

# Check for delete_repo scope
if ! gh auth status --show-token 2>/dev/null | grep -q "delete_repo"; then
  echo "⚠️  Your GitHub CLI token does not have the 'delete_repo' scope."
  echo "   Without it, the test repo cannot be auto-deleted."
  echo "   You can grant it with:"
  echo "     gh auth refresh -h github.com -s delete_repo"
  echo
  read -r -p "Proceed anyway (repo will remain on GitHub)? [y/N] " ans
  if [[ ! "$ans" =~ ^[Yy]$ ]]; then
    echo "Aborting."
    exit 1
  fi
fi


# -------------------------------
# Main experiment
# -------------------------------
cd "$WORKDIR"
echo "Working in $WORKDIR"

# Init local repo
git init -q
echo "# Demo Repo" > README.md
git add README.md
git commit -qm "Initial commit with README"
git branch -M main

# Create remote repo and push
gh repo create "$REPO_NAME" \
  --public \
  --source=. \
  --remote="$REMOTE" \
  --push

# Create feature branch and modify
git checkout -b feature-branch
echo "Feature branch change" >> README.md
git commit -am "Update README on feature branch"

# Switch back to main and modify
git checkout main
echo "Main branch change" >> README.md
git commit -am "Update README on main branch"

# Switch back to feature branch and push
git checkout feature-branch

echo -e "\n======  <THE_MAIN_TEST> ======\n"
git push
echo -e "\n======  </THE_MAIN_TEST> ======\n"

# -------------------------------
# Verify what’s on remote vs local
# -------------------------------
echo "=== MAIN BRANCH COMPARISON ==="
echo "Local main (last 3 commits):"
git log main --oneline -n 3 || echo "local main not found"

echo
echo "Remote origin/main (last 3 commits):"
git log origin/main --oneline -n 3 || echo "origin/main not found"

echo
echo "=== FEATURE-BRANCH COMPARISON ==="
echo "Local feature-branch (last 3 commits):"
git log feature-branch --oneline -n 3 || echo "local feature-branch not found"

echo
echo "Remote origin/feature-branch (last 3 commits):"
git log origin/feature-branch --oneline -n 3 || echo "origin/feature-branch not found"


echo "✅ Experiment complete. Repo will be cleaned up on exit."
