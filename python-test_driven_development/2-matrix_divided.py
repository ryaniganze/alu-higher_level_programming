#!/usr/bin/python3
"""This module provides a function that divides all values in a matrix."""


def matrix_divided(matrix, div):
    """Divide a matrix by a number and round each result to two decimals.

    >>> matrix_divided([[1, 2, 3], [4, 5, 6]], 3)
    [[0.33, 0.67, 1.0], [1.33, 1.67, 2.0]]
    >>> matrix_divided([[10, 20], [30, 40]], 10)
    [[1.0, 2.0], [3.0, 4.0]]
    """
    if (not isinstance(matrix, list) or not matrix or
            any(not isinstance(row, list) for row in matrix)):
        raise TypeError(
            "matrix must be a matrix (list of lists) of integers/floats")

    for row in matrix:
        for value in row:
            if not isinstance(value, (int, float)):
                raise TypeError(
                    "matrix must be a matrix (list of lists) "
                    "of integers/floats")

    row_length = len(matrix[0])
    if any(len(row) != row_length for row in matrix):
        raise TypeError("Each row of the matrix must have the same size")

    if not isinstance(div, (int, float)):
        raise TypeError("div must be a number")

    if div == 0:
        raise ZeroDivisionError("division by zero")

    return [[round(value / div, 2) for value in row] for row in matrix]
