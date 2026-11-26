#!/usr/bin/python3
"""Defines a Student class with filtered JSON representation."""


class Student:
    """Represent a student with a first name, last name, and age."""

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
