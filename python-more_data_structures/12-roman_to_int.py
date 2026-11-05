#!/usr/bin/python3
def roman_to_int(roman_string):
    if not isinstance(roman_string, str):
        return 0
    values = {'I': 1, 'V': 5, 'X': 10, 'L': 50,
              'C': 100, 'D': 500, 'M': 1000}
    result = 0
    previous = 0
    for char in reversed(roman_string):
        current = values.get(char, 0)
        if current < previous:
            result -= current
        else:
            result += current
            previous = current
    return result
