#!/bin/bash
# exe.dev VM API Tools Installer
# Installs worker loops, context management, session search, and secrets guard
#
# Usage: curl -fsSL https://vm-api-docs.pages.dev/install.sh | bash

set -euo pipefail

BIN_DIR="$HOME/bin"
BASE_URL="https://vm-api-docs.pages.dev/scripts"

echo "Installing exe.dev VM API tools..."
echo ""

# Create bin directory
mkdir -p "$BIN_DIR"

# Download scripts
SCRIPTS=(worker ctx conv shelley-search shelley-recall secrets-guard)

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
echo "🔒 Set up secrets guard (recommended):"
echo "  secrets-guard install"
echo "  secrets-guard add 'your@email\\.com'"
echo ""
echo "Docs: https://vm-api-docs.pages.dev"
