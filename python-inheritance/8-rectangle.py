#!/usr/bin/python3
"""Defines a Rectangle class based on BaseGeometry."""

BaseGeometry = __import__('7-base_geometry').BaseGeometry


class Rectangle(BaseGeometry):
    """Represent a rectangle with validated private dimensions."""

    def __init__(self, width, height):
        """Initialize a rectangle after validating its dimensions."""
        self.integer_validator("width", width)
        self.integer_validator("height", height)
        self.__width = width
        self.__height = height
