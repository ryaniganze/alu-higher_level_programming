#!/usr/bin/python3
"""Send an email address using an HTTP POST request with requests."""

import sys
import requests


def main():
    """Send the email parameter and display the response body."""
    response = requests.post(
        sys.argv[1], data={"email": sys.argv[2]})
    print(response.text)


if __name__ == "__main__":
    main()
