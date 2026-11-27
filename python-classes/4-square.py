#!/usr/bin/python3
"""Defines a Square class with a size getter and setter."""


class Square:
    """Represent a square."""

    def __init__(self, size=0):
        """Initialize a square with a validated size."""
        self.size = size

    @property
    def size(self):
        """Return the size of the square."""
        return self.__size

    @size.setter
    def size(self, value):
        """Validate and set the size of the square."""
        if type(value) is not int:
            raise TypeError("size must be an integer")
        if value < 0:
            raise ValueError("size must be >= 0")
        self.__size = value

    def area(self):
        """Return the current area of the square."""
        return self.__size * self.__size
