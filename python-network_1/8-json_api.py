#!/usr/bin/python3
"""Search the API and display information from a JSON response."""

import sys
import requests


def main():
    """Send a search letter and display the returned JSON information."""
    letter = sys.argv[1] if len(sys.argv) > 1 else ""
    response = requests.post(
        "http://0.0.0.0:5000/search_user", data={"q": letter})

    try:
        result = response.json()
    except ValueError:
        print("Not a valid JSON")
        return

    if not result:
        print("No result")
    elif isinstance(result, dict):
        print("[{}] {}".format(
            result.get("id"), result.get("name")))
    else:
        print("No result")


if __name__ == "__main__":
    main()
