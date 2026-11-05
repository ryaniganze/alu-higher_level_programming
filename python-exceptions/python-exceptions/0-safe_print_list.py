#!/usr/bin/python3
"""Print a limited number of elements from a list."""


def safe_print_list(my_list=[], x=0):
    """Print up to x elements and return the number printed."""
    printed = 0
    for index in range(x):
        try:
            print("{}".format(my_list[index]), end="")
            printed += 1
        except IndexError:
            break
    print()
    return printed
