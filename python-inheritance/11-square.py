#!/usr/bin/python3
"""Defines a Square class with a string representation."""

Rectangle = __import__('9-rectangle').Rectangle


class Square(Rectangle):
    """Represent a square with a validated private size."""

    def __init__(self, size):
        """Initialize a square after validating its size."""
        self.integer_validator("size", size)
        self.__size = size
        super().__init__(size, size)

    def area(self):
        """Return the square area."""
        return self.__size * self.__size

    def __str__(self):
        """Return the square description."""
        return "[Square] {}/{}".format(self.__size, self.__size)
