#!/usr/bin/python3
"""Fetch and display the body of the ALU intranet status endpoint."""

import urllib.request


def main():
    """Fetch the status resource and display its response information."""
    with urllib.request.urlopen(
            "https://alu-intranet.hbtn.io/status") as response:
        body = response.read()
        print("Body response:")
        print("\t- type: {}".format(type(body)))
        print("\t- content: {}".format(body))
        print("\t- utf8 content: {}".format(body.decode("utf-8")))


if __name__ == "__main__":
    main()
