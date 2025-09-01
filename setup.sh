#!/bin/bash
set -euo pipefail

SCRIPT_NAME="s2a.sh"
DEST_BIN="/usr/local/bin/s2a"

echo "Installing s2a..."

# Check if script file exists in current directory
if [[ ! -f "$SCRIPT_NAME" ]]; then
    echo "Error: $SCRIPT_NAME not found in current directory."
    exit 1
fi

# Make script executable
chmod +x "$SCRIPT_NAME"

# Move to /usr/local/bin (requires sudo)
if [[ -w "/usr/local/bin" ]]; then
    mv -f "$SCRIPT_NAME" "$DEST_BIN"
else
    echo "Moving to /usr/local/bin requires sudo privileges."
    sudo mv -f "$SCRIPT_NAME" "$DEST_BIN"
fi

echo "s2a installed successfully!"
echo "Usage: s2a /path/to/image_or_directory"

