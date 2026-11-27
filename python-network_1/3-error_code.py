#!/usr/bin/python3
"""Fetch a URL and handle HTTP errors using urllib."""

import sys
import urllib.error
import urllib.request


def main():
    """Display the response body or the HTTP error status code."""
    try:
        with urllib.request.urlopen(sys.argv[1]) as response:
            print(response.read().decode("utf-8"))
    except urllib.error.HTTPError as error:
        print("Error code: {}".format(error.code))


if __name__ == "__main__":
    main()
