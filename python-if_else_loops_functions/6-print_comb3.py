#!/usr/bin/python3
for first in range(10):
    for second in range(first + 1, 10):
        if first == 8 and second == 9:
            print("{:d}{:d}".format(first, second))
        else:
            print("{:d}{:d}, ".format(first, second), end="")
