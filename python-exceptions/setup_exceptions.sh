#!/usr/bin/env bash
set -e

PROJECT="python-exceptions"

mkdir -p "$PROJECT"
cd "$PROJECT"

# Create README first
cat <<'EOF' > README.md
# Python - Exceptions

This project introduces exception handling in Python.

## Learning objectives
- Understand exceptions and errors
- Use try and except blocks
- Use finally clauses
- Raise built-in exceptions
- Handle errors when working with lists and numbers

## Requirements
- Python 3.8.5
- Ubuntu 20.04 LTS
- Python files start with #!/usr/bin/python3
- All Python files end with a newline
- All Python files are executable
- Code follows pycodestyle 2.7.*
EOF

# Task 0: Safe print list
cat <<'EOF' > 0-safe_print_list.py
#!/usr/bin/python3
"""Print a limited number of elements from a list."""


def safe_print_list(my_list=[], x=0):
    """Print up to x elements and return the number printed."""
    printed = 0
    for index in range(x):
        try:
            print("{}".format(my_list[index]), end="")
            printed += 1
        except IndexError:
            break
    print()
    return printed
EOF

# Task 1: Safe print integer
cat <<'EOF' > 1-safe_print_integer.py
#!/usr/bin/python3
"""Safely display an integer."""


def safe_print_integer(value):
    """Print an integer and report whether printing succeeded."""
    try:
        print("{:d}".format(value))
    except (TypeError, ValueError):
        return False
    return True
EOF

# Task 2: Safe print list integers
cat <<'EOF' > 2-safe_print_list_integers.py
#!/usr/bin/python3
"""Print integer elements from a list."""


def safe_print_list_integers(my_list=[], x=0):
    """Print integers among the first x elements and count them."""
    printed = 0
    for index in range(x):
        try:
            print("{:d}".format(my_list[index]), end="")
            printed += 1
        except (TypeError, ValueError):
            continue
    print()
    return printed
EOF

# Task 3: Safe division
cat <<'EOF' > 3-safe_print_division.py
#!/usr/bin/python3
"""Perform division safely."""


def safe_print_division(a, b):
    """Divide a by b and display the result in a finally block."""
    result = None
    try:
        result = a / b
    except ZeroDivisionError:
        pass
    finally:
        print("Inside result: {}".format(result))
    return result
EOF

# Task 4: List division
cat <<'EOF' > 4-list_division.py
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
EOF

# Task 5: Raise a type exception
cat <<'EOF' > 5-raise_exception.py
#!/usr/bin/python3
"""Raise a TypeError."""


def raise_exception():
    """Raise a type exception."""
    raise TypeError()
EOF

# Task 6: Raise a name exception with a message
cat <<'EOF' > 6-raise_exception_msg.py
#!/usr/bin/python3
"""Raise a NameError with a message."""


def raise_exception_msg(message=""):
    """Raise a name exception containing message."""
    raise NameError(message)
EOF

# Make Python files executable
chmod +x ./*.py

# Check Python syntax
for file in ./*.py; do
    python3 -c 'import ast, sys; ast.parse(open(sys.argv[1]).read())' "$file"
done

# Check PEP8 if pycodestyle is available
if command -v pycodestyle >/dev/null 2>&1; then
    pycodestyle ./*.py
else
    echo "pycodestyle is not installed; skipping style check."
fi

# Return to repository root
cd ..

# Stage only this project
git add "$PROJECT/README.md" "$PROJECT"/*.py

# Commit and push
if ! git diff --cached --quiet; then
    git commit -m "Add Python exception handling exercises"
    git push
else
    echo "No new changes to commit."
fi

echo "Python Exceptions project setup completed."
