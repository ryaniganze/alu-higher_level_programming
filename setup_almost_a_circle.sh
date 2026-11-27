#!/bin/bash
# Create, test, and push the Python Almost a Circle project.
set -e

REPO="$HOME/alu-higher_level_programming"
PROJECT="python-almost_a_circle"

if [ ! -d "$REPO/.git" ]; then
    echo "ERROR: Cannot find $REPO. Edit REPO in this script to match your repository path."
    exit 1
fi

cd "$REPO"
mkdir -p "$PROJECT/models" "$PROJECT/tests"
cd "$PROJECT"

cat > README.md <<'EOF'
# Python - Almost a Circle

This project reviews Python classes, inheritance, validation, unit testing,
serialization, JSON, file handling, and keyword and non-keyword arguments.

## Run the tests

From this directory:

    python3 -m unittest discover tests

## Project structure

- models/base.py: Base class and JSON/file serialization.
- models/rectangle.py: Rectangle class.
- models/square.py: Square class.
- tests/: unit tests for the project classes.
EOF

cat > models/__init__.py <<'EOF'
#!/usr/bin/python3
"""The models package contains the Base, Rectangle, and Square classes."""
EOF

cat > models/base.py <<'EOF'
#!/usr/bin/python3
"""This module defines the Base class used by the geometry models."""

import json
import os


class Base:
    """Manage the id shared by geometry objects and JSON serialization."""

    __nb_objects = 0

    def __init__(self, id=None):
        """Initialize an object with a supplied or automatic id."""
        if id is not None:
            self.id = id
        else:
            Base.__nb_objects += 1
            self.id = Base.__nb_objects

    @staticmethod
    def to_json_string(list_dictionaries):
        """Return the JSON string representation of a list of dictionaries."""
        if list_dictionaries is None or len(list_dictionaries) == 0:
            return "[]"
        return json.dumps(list_dictionaries)

    @classmethod
    def save_to_file(cls, list_objs):
        """Write a JSON representation of objects to a class-named file."""
        filename = cls.__name__ + ".json"
        if list_objs is None:
            list_objs = []
        dictionaries = [obj.to_dictionary() for obj in list_objs]
        with open(filename, "w", encoding="utf-8") as file:
            file.write(cls.to_json_string(dictionaries))

    @staticmethod
    def from_json_string(json_string):
        """Convert a JSON string into a list of Python dictionaries."""
        if json_string is None or json_string == "":
            return []
        return json.loads(json_string)

    @classmethod
    def create(cls, **dictionary):
        """Create an instance and populate its attributes through update."""
        if cls.__name__ == "Rectangle":
            dummy = cls(1, 1)
        elif cls.__name__ == "Square":
            dummy = cls(1)
        else:
            return None
        dummy.update(**dictionary)
        return dummy

    @classmethod
    def load_from_file(cls):
        """Load instances from the JSON file named after the current class."""
        filename = cls.__name__ + ".json"
        if not os.path.exists(filename):
            return []
        with open(filename, "r", encoding="utf-8") as file:
            data = cls.from_json_string(file.read())
        return [cls.create(**item) for item in data]
EOF

cat > models/rectangle.py <<'EOF'
#!/usr/bin/python3
"""This module defines a Rectangle class that inherits from Base."""

from models.base import Base


class Rectangle(Base):
    """Represent a rectangle with validated dimensions and position."""

    def __init__(self, width, height, x=0, y=0, id=None):
        """Initialize a rectangle with dimensions, position, and an optional id."""
        super().__init__(id)
        self.width = width
        self.height = height
        self.x = x
        self.y = y

    @property
    def width(self):
        """Return the rectangle width."""
        return self.__width

    @width.setter
    def width(self, value):
        """Validate and assign the rectangle width."""
        if type(value) is not int:
            raise TypeError("width must be an integer")
        if value <= 0:
            raise ValueError("width must be > 0")
        self.__width = value

    @property
    def height(self):
        """Return the rectangle height."""
        return self.__height

    @height.setter
    def height(self, value):
        """Validate and assign the rectangle height."""
        if type(value) is not int:
            raise TypeError("height must be an integer")
        if value <= 0:
            raise ValueError("height must be > 0")
        self.__height = value

    @property
    def x(self):
        """Return the horizontal position."""
        return self.__x

    @x.setter
    def x(self, value):
        """Validate and assign the horizontal position."""
        if type(value) is not int:
            raise TypeError("x must be an integer")
        if value < 0:
            raise ValueError("x must be >= 0")
        self.__x = value

    @property
    def y(self):
        """Return the vertical position."""
        return self.__y

    @y.setter
    def y(self, value):
        """Validate and assign the vertical position."""
        if type(value) is not int:
            raise TypeError("y must be an integer")
        if value < 0:
            raise ValueError("y must be >= 0")
        self.__y = value

    def area(self):
        """Return the area of the rectangle."""
        return self.width * self.height

    def __str__(self):
        """Return the rectangle description with its id, position, and size."""
        return "[Rectangle] ({}) {}/{} - {}/{}".format(
            self.id, self.x, self.y, self.width, self.height)

    def display(self):
        """Print the rectangle using hashes, including its x and y offsets."""
        for _ in range(self.y):
            print()
        for _ in range(self.height):
            print(" " * self.x + "#" * self.width)

    def update(self, *args, **kwargs):
        """Assign attributes from positional arguments or keyword arguments."""
        if args:
            attributes = ["id", "width", "height", "x", "y"]
            for index, value in enumerate(args):
                if index < len(attributes):
                    setattr(self, attributes[index], value)
        else:
            for key, value in kwargs.items():
                if key in ("id", "width", "height", "x", "y"):
                    setattr(self, key, value)

    def to_dictionary(self):
        """Return a dictionary containing the rectangle's public attributes."""
        return {
            "id": self.id,
            "width": self.width,
            "height": self.height,
            "x": self.x,
            "y": self.y
        }
EOF

cat > models/square.py <<'EOF'
#!/usr/bin/python3
"""This module defines a Square class that inherits from Rectangle."""

from models.rectangle import Rectangle


class Square(Rectangle):
    """Represent a square using the validated attributes of Rectangle."""

    def __init__(self, size, x=0, y=0, id=None):
        """Initialize a square with a size, position, and optional id."""
        super().__init__(size, size, x, y, id)

    def __str__(self):
        """Return the square description with id, position, and size."""
        return "[Square] ({}) {}/{} - {}".format(
            self.id, self.x, self.y, self.width)

    @property
    def size(self):
        """Return the square size."""
        return self.width

    @size.setter
    def size(self, value):
        """Validate and assign the square width and height."""
        self.width = value
        self.height = value

    def update(self, *args, **kwargs):
        """Assign square attributes from positional or keyword arguments."""
        if args:
            attributes = ["id", "size", "x", "y"]
            for index, value in enumerate(args):
                if index < len(attributes):
                    setattr(self, attributes[index], value)
        else:
            for key, value in kwargs.items():
                if key in ("id", "size", "x", "y"):
                    setattr(self, key, value)

    def to_dictionary(self):
        """Return a dictionary containing the square's public attributes."""
        return {
            "id": self.id,
            "size": self.size,
            "x": self.x,
            "y": self.y
        }
EOF

cat > tests/__init__.py <<'EOF'
#!/usr/bin/python3
"""The tests package contains unit tests for the Almost a Circle project."""
EOF

cat > tests/test_base.py <<'EOF'
#!/usr/bin/python3
"""Unit tests for the Base class and its serialization methods."""

import os
import unittest
from models.base import Base
from models.rectangle import Rectangle
from models.square import Square


class TestBase(unittest.TestCase):
    """Test Base id assignment and JSON/file serialization."""

    def test_auto_id(self):
        """Check that automatic ids increase."""
        first = Base()
        second = Base()
        self.assertEqual(second.id, first.id + 1)

    def test_manual_id(self):
        """Check that a supplied id is preserved."""
        self.assertEqual(Base(42).id, 42)

    def test_to_json_string(self):
        """Check dictionary-list conversion to JSON."""
        self.assertEqual(Base.to_json_string(None), "[]")
        self.assertEqual(Base.to_json_string([]), "[]")
        self.assertEqual(
            Base.to_json_string([{"id": 1}]), '[{"id": 1}]')

    def test_from_json_string(self):
        """Check JSON conversion back to a list."""
        self.assertEqual(Base.from_json_string(None), [])
        self.assertEqual(Base.from_json_string(""), [])
        self.assertEqual(Base.from_json_string('[{"id": 1}]'), [{"id": 1}])

    def test_save_and_load_rectangle(self):
        """Check saving and loading Rectangle instances."""
        objects = [Rectangle(4, 5, 1, 2, 90), Rectangle(2, 3, id=91)]
        Rectangle.save_to_file(objects)
        loaded = Rectangle.load_from_file()
        self.assertEqual(len(loaded), 2)
        self.assertEqual(str(loaded[0]), str(objects[0]))
        self.assertEqual(str(loaded[1]), str(objects[1]))
        os.remove("Rectangle.json")

    def test_save_none(self):
        """Check that saving None writes an empty JSON list."""
        Rectangle.save_to_file(None)
        with open("Rectangle.json", encoding="utf-8") as file:
            self.assertEqual(file.read(), "[]")
        os.remove("Rectangle.json")

    def test_load_missing_file(self):
        """Check that a missing class-named JSON file returns an empty list."""
        if os.path.exists("Square.json"):
            os.remove("Square.json")
        self.assertEqual(Square.load_from_file(), [])

    def test_create_rectangle(self):
        """Check creating a Rectangle from keyword attributes."""
        rectangle = Rectangle.create(
            id=10, width=4, height=5, x=2, y=3)
        self.assertEqual(str(rectangle), "[Rectangle] (10) 2/3 - 4/5")

    def test_create_square(self):
        """Check creating a Square from keyword attributes."""
        square = Square.create(id=11, size=6, x=1, y=2)
        self.assertEqual(str(square), "[Square] (11) 1/2 - 6")


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_rectangle.py <<'EOF'
#!/usr/bin/python3
"""Unit tests for the Rectangle class."""

import unittest
from models.rectangle import Rectangle


class TestRectangle(unittest.TestCase):
    """Test Rectangle initialization, validation, behavior, and conversion."""

    def test_initialization_and_getters(self):
        """Check constructor values and public getters."""
        rectangle = Rectangle(10, 2, 3, 4, 12)
        self.assertEqual(
            (rectangle.width, rectangle.height, rectangle.x,
             rectangle.y, rectangle.id), (10, 2, 3, 4, 12))

    def test_width_validation(self):
        """Check width type and range validation."""
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            Rectangle("10", 2)
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            Rectangle(0, 2)
        rectangle = Rectangle(2, 2)
        with self.assertRaises(TypeError):
            rectangle.width = 2.5

    def test_height_validation(self):
        """Check height type and range validation."""
        with self.assertRaisesRegex(TypeError, "height must be an integer"):
            Rectangle(2, "10")
        with self.assertRaisesRegex(ValueError, "height must be > 0"):
            Rectangle(2, -1)

    def test_position_validation(self):
        """Check x and y type and range validation."""
        with self.assertRaisesRegex(TypeError, "x must be an integer"):
            Rectangle(2, 2, "1")
        with self.assertRaisesRegex(ValueError, "x must be >= 0"):
            Rectangle(2, 2, -1)
        with self.assertRaisesRegex(TypeError, "y must be an integer"):
            Rectangle(2, 2, 0, "1")
        with self.assertRaisesRegex(ValueError, "y must be >= 0"):
            Rectangle(2, 2, 0, -1)

    def test_area(self):
        """Check that area returns width multiplied by height."""
        self.assertEqual(Rectangle(3, 2).area(), 6)

    def test_display(self):
        """Check rectangle drawing with position offsets."""
        rectangle = Rectangle(2, 2, 1, 1)
        expected = "\n ##\n ##\n"
        import io
        from contextlib import redirect_stdout
        output = io.StringIO()
        with redirect_stdout(output):
            rectangle.display()
        self.assertEqual(output.getvalue(), expected)

    def test_string(self):
        """Check the Rectangle string representation."""
        self.assertEqual(
            str(Rectangle(4, 6, 2, 1, 12)),
            "[Rectangle] (12) 2/1 - 4/6")

    def test_update_args(self):
        """Check positional update order."""
        rectangle = Rectangle(10, 10, 10, 10)
        rectangle.update(89, 2, 3, 4, 5)
        self.assertEqual(
            str(rectangle), "[Rectangle] (89) 4/5 - 2/3")

    def test_update_kwargs(self):
        """Check keyword updates."""
        rectangle = Rectangle(10, 10)
        rectangle.update(height=1, width=2, x=3, y=4, id=89)
        self.assertEqual(
            str(rectangle), "[Rectangle] (89) 3/4 - 2/1")

    def test_to_dictionary(self):
        """Check the Rectangle dictionary representation."""
        rectangle = Rectangle(10, 2, 1, 9, 5)
        self.assertEqual(rectangle.to_dictionary(), {
            "id": 5, "width": 10, "height": 2, "x": 1, "y": 9})


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_square.py <<'EOF'
#!/usr/bin/python3
"""Unit tests for the Square class."""

import unittest
from models.square import Square


class TestSquare(unittest.TestCase):
    """Test Square inheritance, size, updates, and dictionary conversion."""

    def test_initialization(self):
        """Check that size is used for both rectangle dimensions."""
        square = Square(5, 2, 3, 10)
        self.assertEqual(
            (square.size, square.width, square.height,
             square.x, square.y, square.id), (5, 5, 5, 2, 3, 10))

    def test_size_validation(self):
        """Check size validation through the width setter."""
        square = Square(5)
        with self.assertRaisesRegex(TypeError, "width must be an integer"):
            square.size = "9"
        with self.assertRaisesRegex(ValueError, "width must be > 0"):
            square.size = 0

    def test_string(self):
        """Check the Square string representation."""
        self.assertEqual(
            str(Square(5, 2, 1, 12)), "[Square] (12) 2/1 - 5")

    def test_area_and_display(self):
        """Check inherited area and display behavior."""
        square = Square(2)
        self.assertEqual(square.area(), 4)
        import io
        from contextlib import redirect_stdout
        output = io.StringIO()
        with redirect_stdout(output):
            square.display()
        self.assertEqual(output.getvalue(), "##\n##\n")

    def test_update_args(self):
        """Check positional update order for Square."""
        square = Square(5)
        square.update(10, 2, 3, 4)
        self.assertEqual(str(square), "[Square] (10) 3/4 - 2")

    def test_update_kwargs(self):
        """Check keyword updates for Square."""
        square = Square(5)
        square.update(size=7, y=1, id=89, x=12)
        self.assertEqual(str(square), "[Square] (89) 12/1 - 7")

    def test_to_dictionary(self):
        """Check the Square dictionary representation."""
        square = Square(10, 2, 1, 7)
        self.assertEqual(
            square.to_dictionary(),
            {"id": 7, "size": 10, "x": 2, "y": 1})


if __name__ == "__main__":
    unittest.main()
EOF

echo "Setting executable permissions..."
find . -type f -name "*.py" -exec chmod +x {} +

echo "Checking Python syntax..."
python3 -m compileall -q models tests

echo "Running unit tests..."
python3 -m unittest discover tests

echo "Checking PEP 8..."
if command -v pycodestyle >/dev/null 2>&1; then
    pycodestyle models tests
else
    echo "pycodestyle is not installed. Install it with: python3 -m pip install pycodestyle"
fi

echo "Checking first lines and final newlines..."
for file in models/*.py tests/*.py; do
    if [ "$(head -n 1 "$file")" != "#!/usr/bin/python3" ]; then
        echo "ERROR: Incorrect shebang in $file"
        exit 1
    fi
    if [ "$(tail -c 1 "$file" | wc -l)" -ne 1 ]; then
        echo "ERROR: Missing final newline in $file"
        exit 1
    fi
done

echo "Checking executable permissions..."
for file in models/*.py tests/*.py; do
    if [ ! -x "$file" ]; then
        echo "ERROR: $file is not executable"
        exit 1
    fi
done

echo "Project file lengths:"
wc -l README.md models/*.py tests/*.py

cd "$REPO"
git add "$PROJECT"
if ! git diff --cached --quiet; then
    git commit -m "Add Python almost a circle project"
    git push
else
    echo "No new changes to commit."
fi

echo "Project setup and local checks completed."

