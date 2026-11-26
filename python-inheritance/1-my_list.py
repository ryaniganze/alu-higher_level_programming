
#!/usr/bin/python3
"""Defines a custom list class."""


class MyList(list):
    """Represent a list with an additional sorted printing method."""

    def append(self, item):
        """Add an item to the end of the list."""
        super().append(item)

    def print_sorted(self):
        """Print the list in ascending order without modifying it."""
        print(sorted(self))

