#!/usr/bin/python3
"""Defines a custom list class."""


class MyList(list):
    """Represent a list with an additional sorted printing method."""

    def print_sorted(self):
        """Print the list in ascending order without changing the original."""
        print(sorted(self))
