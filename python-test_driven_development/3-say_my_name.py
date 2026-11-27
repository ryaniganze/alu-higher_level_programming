#!/usr/bin/python3
"""This module provides a function that prints a person's full name."""


def say_my_name(first_name, last_name=""):
    """Print a person's first name and last name.

    >>> say_my_name("John", "Smith")
    My name is John Smith
    >>> say_my_name("Bob")
    My name is Bob
    """
    if not isinstance(first_name, str):
        raise TypeError("first_name must be a string")

    if not isinstance(last_name, str):
        raise TypeError("last_name must be a string")

    print("My name is {} {}".format(first_name, last_name))
