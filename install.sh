#!/bin/bash
# exe.dev VM API Tools Installer
# Installs worker loops, context management, and session search tools
#
# Usage: curl -fsSL https://vm-api-docs.coey.dev/install.sh | bash

set -euo pipefail

BIN_DIR="$HOME/bin"
BASE_URL="https://vm-api-docs.coey.dev/scripts"

echo "Installing exe.dev VM API tools..."
echo ""

# Create bin directory
mkdir -p "$BIN_DIR"

# Download scripts
SCRIPTS=(worker ctx conv shelley-search shelley-recall)

for script in "${SCRIPTS[@]}"; do
  echo "  Installing $script..."
  curl -fsSL "$BASE_URL/$script" -o "$BIN_DIR/$script"
  chmod +x "$BIN_DIR/$script"
done

# Create workers directory
mkdir -p "$HOME/.workers"

# Check PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo ""
  echo "Add ~/bin to your PATH by adding this to ~/.bashrc or ~/.profile:"
  echo ""
  echo '  export PATH="$HOME/bin:$PATH"'
  echo ""
  echo "Then run: source ~/.bashrc"
fi

echo ""
echo "✅ Installed: ${SCRIPTS[*]}"
echo ""
echo "Quick start:"
echo "  worker start mywork --task 'build feature X' --dir /path/to/project"
echo "  worker list"
echo "  worker log mywork"
echo ""
echo "Docs: https://vm-api-docs.coey.dev"
