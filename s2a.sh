#!/bin/bash
#
# Description:
#   A helper script for Android development that pushes an image file
#   from your Linux machine into the running Android emulator or device,
#   and then triggers a media scan so the image appears in the Gallery app.
#
# Requirements:
#   1. adb (Android Debug Bridge) must be installed and available in PATH
#   2. Android emulator or physical device must be running and detected by adb
#
# Usage:
#   s2a /path/to/image

if [ -z "$1" ]; then
  echo "Usage: $(basename "$0") /path/to/image"
  exit 1
fi

IMAGE_PATH="$1"

# Check if file exists
if [ ! -f "$IMAGE_PATH" ]; then
  echo "File does not exist: $IMAGE_PATH"
  exit 1
fi

BASENAME=$(basename "$IMAGE_PATH")
DEST="/sdcard/Pictures/$BASENAME"

# Check adb connection
if ! adb get-state 1>/dev/null 2>&1; then
  echo "No Android device or emulator detected."
  exit 1
fi

echo "Pushing $IMAGE_PATH → $DEST"
adb push "$IMAGE_PATH" "$DEST" || exit 1

echo "Broadcasting media scan..."
adb shell am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d "file://$DEST"

echo "Done! File [$BASENAME] was send successfully."

