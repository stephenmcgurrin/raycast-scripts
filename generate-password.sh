#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate Password
# @raycast.mode compact
# @raycast.icon 🔐
# Optional parameters:
# @raycast.argument1 { "type": "text", "placeholder": "length (default 24)", "optional": true }
# @raycast.description Generates a random password and copies it to the clipboard.

len="${1:-24}"
case "$len" in
  ''|*[!0-9]*) echo "Length must be a number"; exit 1 ;;
esac
if [ "$len" -lt 8 ] || [ "$len" -gt 128 ]; then
  echo "Length must be between 8 and 128"; exit 1
fi

pw=$(LC_ALL=C tr -dc 'A-Za-z0-9!@#%^&*()-_=+[]{}' < /dev/urandom | head -c "$len")
printf '%s' "$pw" | pbcopy
echo "Copied ${len}-character password to clipboard"
