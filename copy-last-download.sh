#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Last Download
# @raycast.mode compact
# @raycast.icon 📥
# @raycast.description Copies the most recent file in ~/Downloads to the clipboard, ready to paste.

dir="$HOME/Downloads"

# Newest non-hidden, non-in-progress file (mtime-sorted, null-delimited for odd names)
latest=$(find "$dir" -maxdepth 1 -type f \
  ! -name '.*' \
  ! -name '*.crdownload' ! -name '*.download' ! -name '*.part' ! -name '*.partial' ! -name '*.tmp' \
  -print0 2>/dev/null | xargs -0 stat -f '%m %N' 2>/dev/null | sort -rn | head -1 | cut -d' ' -f2-)

if [ -z "$latest" ]; then
  echo "No downloads found in ~/Downloads"
  exit 1
fi

escaped=${latest//\\/\\\\}
escaped=${escaped//\"/\\\"}
osascript -e "set the clipboard to POSIX file \"$escaped\"" || {
  echo "Could not copy to clipboard"; exit 1
}

size=$(du -h "$latest" | cut -f1 | tr -d ' ')
echo "Copied: $(basename "$latest") ($size)"
