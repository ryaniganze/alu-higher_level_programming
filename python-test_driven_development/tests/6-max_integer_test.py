#!/usr/bin/python3
"""This module contains unit tests for the max_integer function."""

import unittest

max_integer = __import__('6-max_integer').max_integer


class TestMaxInteger(unittest.TestCase):
    """Test cases for finding the largest integer in a list."""

    def test_sorted_list(self):
        """Test a list whose values are in ascending order."""
        self.assertEqual(max_integer([1, 2, 3, 4]), 4)

    def test_unsorted_list(self):
        """Test a list whose largest value is in the middle."""
        self.assertEqual(max_integer([1, 3, 4, 2]), 4)

    def test_descending_list(self):
        """Test a list whose values are in descending order."""
        self.assertEqual(max_integer([4, 3, 2, 1]), 4)

    def test_empty_list(self):
        """Test that an empty list returns None."""
        self.assertIsNone(max_integer([]))

    def test_one_element(self):
        """Test a list containing only one value."""
        self.assertEqual(max_integer([7]), 7)

    def test_negative_numbers(self):
        """Test a list containing only negative values."""
        self.assertEqual(max_integer([-5, -2, -9]), -2)

    def test_mixed_positive_and_negative(self):
        """Test a list containing positive and negative values."""
        self.assertEqual(max_integer([-5, 0, 8, -2]), 8)

    def test_repeated_maximum(self):
        """Test a list where the largest value appears more than once."""
        self.assertEqual(max_integer([3, 9, 2, 9, 1]), 9)

    def test_repeated_values(self):
        """Test a list containing the same value multiple times."""
        self.assertEqual(max_integer([5, 5, 5]), 5)

    def test_float_values(self):
        """Test a list containing floating-point values."""
        self.assertEqual(max_integer([1.5, 3.7, 2.2]), 3.7)

    def test_single_negative_value(self):
        """Test a list containing one negative value."""
        self.assertEqual(max_integer([-10]), -10)


if __name__ == "__main__":
    unittest.main()
