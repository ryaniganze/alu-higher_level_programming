#!/usr/bin/python3
"""Defines a function that loads an object from a JSON file."""

import json


def load_from_json_file(filename):
    """Return the Python object represented in a JSON file."""
    with open(filename, encoding="utf-8") as file:
        return json.load(file)
