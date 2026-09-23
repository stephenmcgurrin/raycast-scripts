#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Column to Comma
# @raycast.mode compact
# @raycast.icon 🗂
# Optional parameters:
# @raycast.argument1 { "type": "dropdown", "placeholder": "quotes", "optional": true, "data": [{ "title": "None", "value": "none" }, { "title": "Single (SQL)", "value": "single" }, { "title": "Double", "value": "double" }] }
# @raycast.description Turns a column of clipboard values into a comma-separated list.

case "${1:-none}" in
  single) q="'" ;;
  double) q='"' ;;
  *)      q=""  ;;
esac

out=$(pbpaste | tr -d '\r' | awk -v q="$q" '
  { gsub(/^[ \t]+|[ \t]+$/, "") }        # trim each line
  $0 == "" { next }                      # drop blanks
  { printf "%s%s%s%s", (n++ ? ", " : ""), q, $0, q }
  END { if (n) printf "\n"; else exit 1 }
')

if [ -z "$out" ]; then
  echo "Clipboard is empty or has no usable lines"
  exit 1
fi

printf '%s' "$out" | pbcopy
echo "Copied $(printf '%s' "$out" | awk -F', ' '{print NF}') values"
