#!/bin/bash
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Network Info
# @raycast.mode fullOutput
# @raycast.icon 🛜
# @raycast.description Public IP (copied to clipboard), local IP, Wi-Fi SSID, gateway and DNS.

json=$(curl -s --max-time 5 https://ipinfo.io/json)

if [ -n "$json" ]; then
  ip=$(echo "$json" | jq -r '.ip // "unknown"')
  printf '%s' "$ip" | pbcopy
  echo "Public IP : $ip   (copied to clipboard)"
  echo "ISP       : $(echo "$json" | jq -r '.org // "unknown"')"
  echo "Location  : $(echo "$json" | jq -r '[.city, .region, .country] | map(select(. != null)) | join(", ")')"
else
  echo "Public IP : unavailable (no response)"
fi

echo
iface=$(route -n get default 2>/dev/null | awk '/interface:/{print $2}')
echo "Interface : ${iface:-none}"
echo "Local IP  : $(ipconfig getifaddr "${iface:-en0}" 2>/dev/null || echo unknown)"
echo "Gateway   : $(route -n get default 2>/dev/null | awk '/gateway:/{print $2}')"

wifi_dev=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $2; exit}')
ssid=$(ipconfig getsummary "${wifi_dev:-en0}" 2>/dev/null | awk -F' SSID : ' '/ SSID/{print $2; exit}')
case "$ssid" in
  ""|"<redacted>") ssid="hidden (grant Location Services to see SSID)" ;;
esac
echo "Wi-Fi     : $ssid${wifi_dev:+ ($wifi_dev)}"
echo "DNS       : $(scutil --dns | awk '/nameserver\[0\]/{print $3; exit}')"
