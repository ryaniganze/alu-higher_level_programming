#!/usr/bin/python3
"""Display the X-Request-Id value from an HTTP response."""

import sys
import urllib.request


def main():
    """Fetch a URL and print its X-Request-Id response header."""
    with urllib.request.urlopen(sys.argv[1]) as response:
        print(response.headers.get("X-Request-Id"))


if __name__ == "__main__":
    main()
