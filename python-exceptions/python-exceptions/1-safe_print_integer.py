#!/usr/bin/python3
"""Safely display an integer."""


def safe_print_integer(value):
    """Print an integer and report whether printing succeeded."""
    try:
        print("{:d}".format(value))
    except (TypeError, ValueError):
        return False
    return True
