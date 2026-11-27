#!/usr/bin/python3
"""Fetch a URL and display its response or HTTP error status."""

import sys
import requests


def main():
    """Display the body or an error message for HTTP status codes."""
    response = requests.get(sys.argv[1])

    if response.status_code >= 400:
        print("Error code: {}".format(response.status_code))
    else:
        print(response.text)


if __name__ == "__main__":
    main()
