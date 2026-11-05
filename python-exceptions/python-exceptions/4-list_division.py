#!/usr/bin/python3
"""Divide corresponding elements from two lists."""


def list_division(my_list_1, my_list_2, list_length):
    """Return element-wise divisions with error handling."""
    results = []
    for index in range(list_length):
        value = 0
        try:
            value = my_list_1[index] / my_list_2[index]
        except ZeroDivisionError:
            print("division by 0")
        except TypeError:
            print("wrong type")
        except IndexError:
            print("out of range")
        finally:
            results.append(value)
    return results
