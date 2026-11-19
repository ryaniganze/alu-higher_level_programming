#!/usr/bin/python3
"""Defines a Square class with position validation and printing."""


class Square:
    """Represent a square with a position."""

    def __init__(self, size=0, position=(0, 0)):
        """Initialize a square with validated size and position."""
        self.size = size
        self.position = position

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

    @property
    def position(self):
        """Return the position of the square."""
        return self.__position

    @position.setter
    def position(self, value):
        """Validate and set the position of the square."""
        if type(value) is not tuple:
            raise TypeError(
                "position must be a tuple of 2 positive integers"
            )
        if len(value) != 2:
            raise TypeError(
                "position must be a tuple of 2 positive integers"
            )
        if any(type(number) is not int or number < 0
               for number in value):
            raise TypeError(
                "position must be a tuple of 2 positive integers"
            )
        self.__position = value

    def area(self):
        """Return the current area of the square."""
        return self.__size * self.__size

    def my_print(self):
        """Print the square at its assigned position."""
        if self.__size == 0:
            print()
            return

        for i in range(self.__position[0]):
            print()

        for i in range(self.__size):
            print(" " * self.__position[1] + "#" * self.__size)
