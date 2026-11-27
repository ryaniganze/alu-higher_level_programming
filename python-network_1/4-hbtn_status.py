#!/usr/bin/python3
"""Fetch and display the ALU intranet status using requests."""

import requests


def main():
    """Fetch the status resource and display its response information."""
    response = requests.get("https://alu-intranet.hbtn.io/status")
    body = response.text
    print("Body response:")
    print("\t- type: {}".format(type(body)))
    print("\t- content: {}".format(body))


if __name__ == "__main__":
    main()
