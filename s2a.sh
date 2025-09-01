#!/bin/bash
set -euo pipefail

# Usage info
usage() {
  echo "Usage: $(basename "$0") /path/to/image_or_directory"
  exit 1
}

# Validate input
[[ $# -eq 0 ]] && usage
INPUT_PATH="$1"

if [[ ! -e "$INPUT_PATH" ]]; then
  echo "File or directory does not exist: $INPUT_PATH"
  exit 1
fi

# Check adb connection
if ! adb get-state 1>/dev/null 2>&1; then
  echo "No Android device or emulator detected."
  exit 1
fi

# Function to push a single file
push_file() {
  local file_path="$1"
  local base_name
  base_name=$(basename "$file_path")
  local dest="/sdcard/Pictures/$base_name"

  echo "Sending: $file_path → $dest"
  if adb push "$file_path" "$dest" >/dev/null; then
    adb shell am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d "file://$dest" >/dev/null
    echo "$base_name sent successfully"
  else
    echo "Failed to send $file_path"
  fi
}

# Handle file or directory
if [[ -d "$INPUT_PATH" ]]; then
  shopt -s nullglob
  files=("$INPUT_PATH"/*)

  if [[ ${#files[@]} -eq 0 ]]; then
    echo "No files found in directory: $INPUT_PATH"
    exit 1
  fi

  for file in "${files[@]}"; do
    [[ -f "$file" ]] && push_file "$file"
  done
elif [[ -f "$INPUT_PATH" ]]; then
  push_file "$INPUT_PATH"
else
  echo "$INPUT_PATH is not a regular file or directory."
  exit 1
fi

echo "Done."
