#!/bin/bash
# Create the ALU Python Object-relational mapping project files.
set -e

REPO="/alu-higher_level_programming"
PROJECT="$REPO/python-object_relational_mapping"

if [ ! -d "$REPO/.git" ]; then
    echo "ERROR: $REPO is not a Git repository. Edit REPO near the top of this script."
    exit 1
fi

mkdir -p "$PROJECT"
cd "$PROJECT"

cat > README.md <<'DOC'
# Python - Object-relational mapping

This project connects Python to MySQL using MySQLdb and SQLAlchemy.

## Requirements
- Python 3.8.5
- MySQL 8.0
- mysqlclient / MySQLdb 2.0.x
- SQLAlchemy 1.4.x
- pycodestyle 2.7.*

Tasks 0–5 use MySQLdb. Tasks 6–14 use SQLAlchemy.
DOC

cat > 0-select_states.py <<'PY'
#!/usr/bin/python3
"""List all states from a MySQL database in ascending ID order."""

import sys
import MySQLdb


if __name__ == "__main__":
    db = MySQLdb.connect(
        host="localhost", port=3306, user=sys.argv[1],
        passwd=sys.argv[2], db=sys.argv[3]
    )
    cur = db.cursor()
    cur.execute("SELECT * FROM states ORDER BY id ASC")
    for row in cur.fetchall():
        print(row)
    cur.close()
    db.close()
PY

cat > 1-filter_states.py <<'PY'
#!/usr/bin/python3
"""List states whose names begin with an uppercase N."""

import sys
import MySQLdb


if __name__ == "__main__":
    db = MySQLdb.connect(
        host="localhost", port=3306, user=sys.argv[1],
        passwd=sys.argv[2], db=sys.argv[3]
    )
    cur = db.cursor()
    cur.execute("SELECT * FROM states WHERE name LIKE 'N%' ORDER BY id ASC")
    for row in cur.fetchall():
        print(row)
    cur.close()
    db.close()
PY

cat > 2-my_filter_states.py <<'PY'
#!/usr/bin/python3
"""Display states whose name matches the supplied argument."""

import sys
import MySQLdb


if __name__ == "__main__":
    db = MySQLdb.connect(
        host="localhost", port=3306, user=sys.argv[1],
        passwd=sys.argv[2], db=sys.argv[3]
    )
    cur = db.cursor()
    query = "SELECT * FROM states WHERE name = '{}' ORDER BY id ASC"
    cur.execute(query.format(sys.argv[4]))
    for row in cur.fetchall():
        print(row)
    cur.close()
    db.close()
PY

cat > 3-my_safe_filter_states.py <<'PY'
#!/usr/bin/python3
"""Safely display states matching a name without SQL injection."""

import sys
import MySQLdb


if __name__ == "__main__":
    db = MySQLdb.connect(
        host="localhost", port=3306, user=sys.argv[1],
        passwd=sys.argv[2], db=sys.argv[3]
    )
    cur = db.cursor()
    cur.execute(
        "SELECT * FROM states WHERE name = %s ORDER BY id ASC",
        (sys.argv[4],)
    )
    for row in cur.fetchall():
        print(row)
    cur.close()
    db.close()
PY

cat > 4-cities_by_state.py <<'PY'
#!/usr/bin/python3
"""List every city with its state, ordered by city ID."""

import sys
import MySQLdb


if __name__ == "__main__":
    db = MySQLdb.connect(
        host="localhost", port=3306, user=sys.argv[1],
        passwd=sys.argv[2], db=sys.argv[3]
    )
    cur = db.cursor()
    cur.execute(
        "SELECT cities.id, cities.name, states.name "
        "FROM cities JOIN states ON cities.state_id = states.id "
        "ORDER BY cities.id ASC"
    )
    for row in cur.fetchall():
        print(row)
    cur.close()
    db.close()
PY

cat > 5-filter_cities.py <<'PY'
#!/usr/bin/python3
"""List the cities belonging to the state supplied as an argument."""

import sys
import MySQLdb


if __name__ == "__main__":
    db = MySQLdb.connect(
        host="localhost", port=3306, user=sys.argv[1],
        passwd=sys.argv[2], db=sys.argv[3]
    )
    cur = db.cursor()
    cur.execute(
        "SELECT cities.name FROM cities "
        "JOIN states ON cities.state_id = states.id "
        "WHERE states.name = %s ORDER BY cities.id ASC",
        (sys.argv[4],)
    )
    print(", ".join(row[0] for row in cur.fetchall()))
    cur.close()
    db.close()
PY

cat > model_state.py <<'PY'
#!/usr/bin/python3
"""Define the State model and its SQLAlchemy declarative base."""

from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()


class State(Base):
    """Represent a state stored in the states database table."""

    __tablename__ = "states"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String(128), nullable=False)
PY

cat > 7-model_state_fetch_all.py <<'PY'
#!/usr/bin/python3
"""List all State objects in ascending ID order."""

import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from model_state import Base, State


if __name__ == "__main__":
    engine = create_engine(
        "mysql+mysqldb://{}:{}@localhost/{}".format(
            sys.argv[1], sys.argv[2], sys.argv[3]
        ), pool_pre_ping=True
    )
    session = Session(engine)
    for state in session.query(State).order_by(State.id).all():
        print("{}: {}".format(state.id, state.name))
    session.close()
PY

cat > 8-model_state_fetch_first.py <<'PY'
#!/usr/bin/python3
"""Print the first State object in ascending ID order."""

import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from model_state import Base, State


if __name__ == "__main__":
    engine = create_engine(
        "mysql+mysqldb://{}:{}@localhost/{}".format(
            sys.argv[1], sys.argv[2], sys.argv[3]
        ), pool_pre_ping=True
    )
    session = Session(engine)
    state = session.query(State).order_by(State.id).first()
    if state is None:
        print("Nothing")
    else:
        print("{}: {}".format(state.id, state.name))
    session.close()
PY

cat > 9-model_state_filter_a.py <<'PY'
#!/usr/bin/python3
"""List State objects whose names contain the lowercase letter a."""

import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from model_state import Base, State


if __name__ == "__main__":
    engine = create_engine(
        "mysql+mysqldb://{}:{}@localhost/{}".format(
            sys.argv[1], sys.argv[2], sys.argv[3]
        ), pool_pre_ping=True
    )
    session = Session(engine)
    states = session.query(State).filter(
        State.name.like("%a%")
    ).order_by(State.id).all()
    for state in states:
        print("{}: {}".format(state.id, state.name))
    session.close()
PY

cat > 10-model_state_my_get.py <<'PY'
#!/usr/bin/python3
"""Print the ID of a state matching the supplied name."""

import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from model_state import Base, State


if __name__ == "__main__":
    engine = create_engine(
        "mysql+mysqldb://{}:{}@localhost/{}".format(
            sys.argv[1], sys.argv[2], sys.argv[3]
        ), pool_pre_ping=True
    )
    session = Session(engine)
    state = session.query(State).filter(
        State.name == sys.argv[4]
    ).first()
    if state is None:
        print("Not found")
    else:
        print(state.id)
    session.close()
PY

cat > 11-model_state_insert.py <<'PY'
#!/usr/bin/python3
"""Insert Louisiana into the states table and print its new ID."""

import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from model_state import Base, State


if __name__ == "__main__":
    engine = create_engine(
        "mysql+mysqldb://{}:{}@localhost/{}".format(
            sys.argv[1], sys.argv[2], sys.argv[3]
        ), pool_pre_ping=True
    )
    session = Session(engine)
    state = State(name="Louisiana")
    session.add(state)
    session.commit()
    print(state.id)
    session.close()
PY

cat > 12-model_state_update_id_2.py <<'PY'
#!/usr/bin/python3
"""Change the name of the state with ID 2 to New Mexico."""

import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from model_state import Base, State


if __name__ == "__main__":
    engine = create_engine(
        "mysql+mysqldb://{}:{}@localhost/{}".format(
            sys.argv[1], sys.argv[2], sys.argv[3]
        ), pool_pre_ping=True
    )
    session = Session(engine)
    state = session.query(State).filter(State.id == 2).first()
    if state is not None:
        state.name = "New Mexico"
        session.commit()
    session.close()
PY

cat > 13-model_state_delete_a.py <<'PY'
#!/usr/bin/python3
"""Delete every state whose name contains the lowercase letter a."""

import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from model_state import Base, State


if __name__ == "__main__":
    engine = create_engine(
        "mysql+mysqldb://{}:{}@localhost/{}".format(
            sys.argv[1], sys.argv[2], sys.argv[3]
        ), pool_pre_ping=True
    )
    session = Session(engine)
    session.query(State).filter(State.name.like("%a%")).delete(
        synchronize_session=False
    )
    session.commit()
    session.close()
PY

cat > model_city.py <<'PY'
#!/usr/bin/python3
"""Define the City model linked to the states table."""

from sqlalchemy import Column, ForeignKey, Integer, String
from model_state import Base


class City(Base):
    """Represent a city stored in the cities database table."""

    __tablename__ = "cities"

    id = Column(Integer, primary_key=True, nullable=False)
    name = Column(String(128), nullable=False)
    state_id = Column(Integer, ForeignKey("states.id"), nullable=False)
PY

cat > 14-model_city_fetch_by_state.py <<'PY'
#!/usr/bin/python3
"""List cities with their state names in ascending city ID order."""

import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import Session
from model_state import Base, State
from model_city import City


if __name__ == "__main__":
    engine = create_engine(
        "mysql+mysqldb://{}:{}@localhost/{}".format(
            sys.argv[1], sys.argv[2], sys.argv[3]
        ), pool_pre_ping=True
    )
    session = Session(engine)
    rows = session.query(State.name, City.id, City.name).join(
        City, City.state_id == State.id
    ).order_by(City.id).all()
    for state_name, city_id, city_name in rows:
        print("{}: ({}) {}".format(state_name, city_id, city_name))
    session.close()
PY

chmod +x ./*.py

echo "Checking Python syntax, shebangs, and final newlines..."
python3 - <<'PY'
import ast
import glob
import sys

files = sorted(glob.glob("*.py"))
for filename in files:
    with open(filename, "r", encoding="utf-8") as source:
        content = source.read()
    try:
        ast.parse(content, filename=filename)
        assert content.endswith("\n"), "missing final newline"
        assert content.splitlines()[0] == "#!/usr/bin/python3", "incorrect shebang"
    except Exception as error:
        print("ERROR in {}: {}".format(filename, error))
        sys.exit(1)
print("Passed checks for {} Python files.".format(len(files)))
PY

if command -v pycodestyle >/dev/null 2>&1; then
    pycodestyle *.py || echo "Review the pycodestyle messages above."
else
    echo "pycodestyle is not installed; style check skipped."
fi

echo
echo "Created project at: $PROJECT"
echo "Database-backed tasks have not been run; MySQL and required Python packages must be installed."
echo "Review the files, then commit and push when ready."
