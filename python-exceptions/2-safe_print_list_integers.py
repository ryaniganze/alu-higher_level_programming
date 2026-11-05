#!/usr/bin/python3
"""Print integer elements from a list."""


def safe_print_list_integers(my_list=[], x=0):
    """Print integers among the first x elements and count them."""
    printed = 0
    for index in range(x):
        try:
            print("{:d}".format(my_list[index]), end="")
            printed += 1
        except (TypeError, ValueError):
            continue
    print()
    return printed
