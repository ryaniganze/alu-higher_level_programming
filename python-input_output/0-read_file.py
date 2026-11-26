#!/usr/bin/python3
"""Defines a function that reads and prints a UTF-8 text file."""


def read_file(filename=""):
    """Read a text file and print its contents to standard output."""
    with open(filename, encoding="utf-8") as file:
        print(file.read(), end="")
