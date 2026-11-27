
#!/usr/bin/python3
"""Fetch and display the intranet status using requests."""

import requests


def main():
    """Fetch the status resource and display its response information."""
    response = requests.get("https://intranet.hbtn.io/status")
    body = response.text
    print("Body response:")
    print("\t- type: {}".format(type(body)))
    print("\t- content: {}".format(body))


if __name__ == "__main__":
    main()

