#!/bin/bash
# Display the HTTP methods accepted by the server.
curl -s -X OPTIONS -i "$1" | grep -i '^Allow:' | cut -d ' ' -f2- | tr -d '\r'
