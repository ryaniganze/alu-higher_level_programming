#!/bin/bash
# Send a GET request with the required custom user ID header.
curl -s -H 'X-HolbertonSchool-User-Id: 98' "$1"
