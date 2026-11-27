#!/usr/bin/python3
"""Defines a Student class with JSON reload functionality."""


class Student:
    """Represent a student with JSON conversion and reload methods."""

    def __init__(self, first_name, last_name, age):
        """Initialize a student with personal information."""
        self.first_name = first_name
        self.last_name = last_name
        self.age = age

    def to_json(self, attrs=None):
        """Return all attributes or only the requested attributes."""
        if isinstance(attrs, list) and all(
                isinstance(attr, str) for attr in attrs):
            return {
                key: value for key, value in self.__dict__.items()
                if key in attrs
            }
        return self.__dict__

    def reload_from_json(self, json):
        """Replace student attributes using values from a dictionary."""
        for key, value in json.items():
            setattr(self, key, value)
