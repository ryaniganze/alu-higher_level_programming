#!/usr/bin/python3
"""Display the X-Request-Id value using the requests package."""

import sys
import requests


def main():
    """Fetch a URL and print its X-Request-Id response header."""
    response = requests.get(sys.argv[1])
    print(response.headers.get("X-Request-Id"))


if __name__ == "__main__":
    main()
