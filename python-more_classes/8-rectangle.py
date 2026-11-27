#!/usr/bin/python3
"""Defines a Rectangle class with a comparison method."""


class Rectangle:
    """Represent a rectangle and track its instances."""

    number_of_instances = 0
    print_symbol = "#"

    def __init__(self, width=0, height=0):
        """Initialize a rectangle and increase the instance count."""
        self.width = width
        self.height = height
        Rectangle.number_of_instances += 1

    @property
    def width(self):
        """Return the rectangle width."""
        return self.__width

    @width.setter
    def width(self, value):
        """Validate and set the rectangle width."""
        if type(value) is not int:
            raise TypeError("width must be an integer")
        if value < 0:
            raise ValueError("width must be >= 0")
        self.__width = value

    @property
    def height(self):
        """Return the rectangle height."""
        return self.__height

    @height.setter
    def height(self, value):
        """Validate and set the rectangle height."""
        if type(value) is not int:
            raise TypeError("height must be an integer")
        if value < 0:
            raise ValueError("height must be >= 0")
        self.__height = value

    def area(self):
        """Return the rectangle area."""
        return self.__width * self.__height

    def perimeter(self):
        """Return the rectangle perimeter."""
        if self.__width == 0 or self.__height == 0:
            return 0
        return 2 * (self.__width + self.__height)

    def __str__(self):
        """Return the rectangle using the # character."""
        if self.__width == 0 or self.__height == 0:
            return ""
        return "\n".join(
            ["#" * self.__width for row in range(self.__height)]
        )

    def __repr__(self):
        """Return a string that can recreate the rectangle."""
        return "Rectangle({}, {})".format(self.__width, self.__height)

    def __del__(self):
        """Print a message and decrease the instance count."""
        Rectangle.number_of_instances -= 1
        print("Bye rectangle...")

    @staticmethod
    def bigger_or_equal(rect_1, rect_2):
        """Return the rectangle with the greater or equal area."""
        if not isinstance(rect_1, Rectangle):
            raise TypeError(
                "rect_1 must be an instance of Rectangle"
            )
        if not isinstance(rect_2, Rectangle):
            raise TypeError(
                "rect_2 must be an instance of Rectangle"
            )
        if rect_1.area() >= rect_2.area():
            return rect_1
        return rect_2
