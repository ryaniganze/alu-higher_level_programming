#!/usr/bin/python3
"""Send an email address to a URL using an HTTP POST request."""

import sys
import urllib.parse
import urllib.request


def main():
    """Send the email parameter and display the decoded response."""
    data = urllib.parse.urlencode(
        {"email": sys.argv[2]}).encode("utf-8")
    request = urllib.request.Request(sys.argv[1], data=data)

    with urllib.request.urlopen(request) as response:
        print(response.read().decode("utf-8"))


if __name__ == "__main__":
    main()
