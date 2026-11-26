#!/usr/bin/python3
"""Defines a function that generates Pascal's Triangle."""


def pascal_triangle(n):
    """Return a list of lists representing Pascal's Triangle of n."""
    if n <= 0:
        return []

    triangle = []

    for row in range(n):
        current_row = [1] * (row + 1)

        for column in range(1, row):
            current_row[column] = (
                triangle[row - 1][column - 1]
                + triangle[row - 1][column]
            )

        triangle.append(current_row)

    return triangle
