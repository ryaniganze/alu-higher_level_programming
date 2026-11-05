#!/usr/bin/python3
"""Perform division safely."""


def safe_print_division(a, b):
    """Divide a by b and display the result in a finally block."""
    result = None
    try:
        result = a / b
    except ZeroDivisionError:
        pass
    finally:
        print("Inside result: {}".format(result))
    return result
