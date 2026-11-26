#!/usr/bin/python3
"""Defines a complete Rectangle class based on BaseGeometry."""

BaseGeometry = __import__('7-base_geometry').BaseGeometry


class Rectangle(BaseGeometry):
    """Represent a rectangle with area and string representation."""

    def __init__(self, width, height):
        """Initialize a rectangle after validating its dimensions."""
        self.integer_validator("width", width)
        self.integer_validator("height", height)
        self.__width = width
        self.__height = height

    def area(self):
        """Return the rectangle area."""
        return self.__width * self.__height

    def __str__(self):
        """Return the rectangle description."""
        return "[Rectangle] {}/{}".format(self.__width, self.__height)
