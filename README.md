# Raycast Script Commands

Personal [Raycast script commands](https://manual.raycast.com/script-commands).

## Setup

Raycast → Settings → Extensions → `+` → **Add Script Directory** → select this folder.

## Commands

| Command | Description |
|---|---|
| **Start My Day** | Opens the daily application set (Outlook, Teams, kitty, Obsidian, Claude, ChatGPT, WhatsApp, Slack, Morgen, NexioWatch, Edge). |
| **Generate Password** | Random password of a given length (default 24), copied to the clipboard. |
| **Network Info** | Public IP (copied to clipboard), ISP, location, local IP, gateway, Wi-Fi and DNS. |
| **Copy Last Download** | Copies the newest file in `~/Downloads` to the clipboard, ready to paste. |
| **Column to Comma** | Turns a column of clipboard values into a comma-separated list, optionally quoted. |

All are plain bash with no external dependencies beyond `curl` and `jq` (Network Info).
