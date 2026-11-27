#!/usr/bin/python3
"""Display a GitHub user's ID using Basic Authentication."""

import sys
import requests


def main():
    """Authenticate with GitHub and display the user's account ID."""
    response = requests.get(
        "https://api.github.com/user",
        auth=(sys.argv[1], sys.argv[2]))
    result = response.json()
    print(result.get("id"))


if __name__ == "__main__":
    main()
