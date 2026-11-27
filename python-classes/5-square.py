#!/usr/bin/python3
"""Defines a Square class with a printing method."""


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

    def my_print(self):
        """Print the square using the character #."""
        if self.__size == 0:
            print()
            return

        for row in range(self.__size):
            print("#" * self.__size)
