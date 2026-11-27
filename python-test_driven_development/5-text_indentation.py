#!/usr/bin/python3
"""This module provides a function that formats text after punctuation."""


def text_indentation(text):
    """Print text with two new lines after ., ? and : characters.

    >>> text_indentation("Hello. How are you?")
    Hello.
    <BLANKLINE>
    How are you?
    <BLANKLINE>
    """
    if not isinstance(text, str):
        raise TypeError("text must be a string")

    parts = []
    current = ""

    for character in text:
        current += character
        if character in ".?:":
            parts.append(current.strip())
            current = ""

    if current.strip():
        parts.append(current.strip())

    print("\n\n".join(parts), end="")
