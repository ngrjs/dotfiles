#!/usr/bin/env bash
# Output NetBird status for i3status-rust custom block

status_json=$(netbird status --json 2>/dev/null)

if [ -z "$status_json" ]; then
    echo '{"icon":"net_down","text":"NB off","state":"Critical"}'
    exit 0
fi

mgmt=$(echo "$status_json" | jq -r '.management.connected')
profile=$(echo "$status_json" | jq -r '.profileName')
ip=$(echo "$status_json" | jq -r '.netbirdIp')

if [ "$mgmt" = "true" ]; then
    echo "{\"icon\":\"net_vpn\",\"text\":\"NB $profile\",\"state\":\"Good\"}"
else
    echo "{\"icon\":\"net_down\",\"text\":\"NB off\",\"state\":\"Warning\"}"
fi
