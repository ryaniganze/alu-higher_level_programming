#!/usr/bin/python3
"""Defines a function that converts an object's attributes to a dictionary."""


def class_to_json(obj):
    """Return the dictionary description of an object's attributes."""
    return obj.__dict__
