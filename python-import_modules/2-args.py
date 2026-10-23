#!/usr/bin/python3
import sys

if __name__ == "__main__":
    argv = sys.argv
    count = len(argv) - 1
    if count == 0:
        print("{} arguments.".format(count))
    elif count == 1:
        print("{} argument:".format(count))
    else:
        print("{} arguments:".format(count))
    for index in range(1, len(argv)):
        print("{}: {}".format(index, argv[index]))
