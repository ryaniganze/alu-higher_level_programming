#!/bin/bash
# Display the response body only when the final HTTP status is 200.
tmp=$(mktemp); status=$(curl -sL -o "$tmp" -w "%{http_code}" "$1"); if [ "$status" = "200" ]; then cat "$tmp"; fi; rm -f "$tmp"
