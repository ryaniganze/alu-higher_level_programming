#!/bin/bash
# Display the size in bytes of the response body.
curl -s -o /dev/null -w "%{size_download}\n" "$1"
