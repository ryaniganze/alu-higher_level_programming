#!/usr/bin/python3
"""This module provides a function that prints a square using #."""


def print_square(size):
    """Print a square with the given integer side length.

    >>> print_square(3)
    ###
    ###
    ###
    >>> print_square(0)
    """
    if not isinstance(size, int):
        raise TypeError("size must be an integer")

    if size < 0:
        raise ValueError("size must be >= 0")

    for row in range(size):
        print("#" * size)
