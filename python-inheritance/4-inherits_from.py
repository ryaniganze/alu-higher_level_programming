#!/usr/bin/python3
"""Defines a function that checks whether an object inherits from a class."""


def inherits_from(obj, a_class):
    """Return True if obj belongs to a subclass of a_class."""
    return isinstance(obj, a_class) and type(obj) is not a_class
