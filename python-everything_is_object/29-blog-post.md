# Python 3: Mutable, Immutable... Everything Is an Object!

[Insert a relevant picture here before publishing.]

## Introduction

Python is an object-oriented programming language in which
everything is an object. Understanding objects helps explain
how variables store references, why changing a list can affect
another variable, and why changing an integer does not have the
same effect. In this post, I explain object identity, types,
mutable and immutable objects, aliases, and how arguments are
passed to functions.

## id and type

In Python, every object has an identity, a type, and a value.
The `id()` function returns an object's identity. In CPython,
this identity is its memory address. The `type()` function
returns the object's type.

Example:

```python
number = 10

print(type(number))
print(id(number))
```

The output of `type(number)` is:

```text
<class 'int'>
```

The value returned by `id()` can differ between executions.

Two variables can be checked using `is` to determine whether
they refer to the same object. The `==` operator checks whether
their values are equal.

## Mutable objects

A mutable object can be changed after it has been created.
Examples of built-in mutable objects include lists, dictionaries,
sets, and byte arrays.

Example:

```python
first = [1, 2, 3]
second = first

first.append(4)

print(second)
```

Output:

```text
[1, 2, 3, 4]
```

Both variables refer to the same list. Changing the list through
one variable is visible through the other.

Memory illustration:

```text
first  ─────┐
            ├────> [1, 2, 3, 4]
second ─────┘
             One shared list object
```

This is an example of aliasing: two or more variable names
refer to the same object.

## Immutable objects

An immutable object cannot be changed after it has been created.
Examples include integers, floats, complex numbers, strings,
tuples, frozen sets, and bytes.

Example:

```python
a = 10
b = a

a = 20

print(a)
print(b)
```

Output:

```text
20
10
```

The assignment `a = 20` makes `a` refer to another integer
object. It does not change the original integer object.

Memory illustration:

```text
Before reassignment:

a ─────┐
       ├────> 10
b ─────┘

After a = 20:

a ──────────> 20

b ──────────> 10
```

A tuple is immutable, but it can contain a mutable object.
For example, a tuple can contain a list. The tuple's elements
cannot be reassigned, but the list inside it can still be changed.
A frozen set is also immutable, and its elements must be hashable.

## Why does it matter, and how does Python treat mutable and immutable objects?

Understanding mutability matters because assignment does not
always create a new object. When two variables refer to the same
mutable object, a change made through either variable can be
seen through both. With immutable objects, an operation that
appears to change a value creates or refers to another object
instead.

For example, `list.append()` modifies an existing list.
However, `list + [value]` creates a new list and assigns the
new reference when used with reassignment.

Python also has an implementation detail in CPython called
small integer caching. CPython pre-creates and reuses 262 small
integer objects, from -5 through 256. The internal constants
`NSMALLNEGINTS` and `NSMALLPOSINTS` describe the cached
negative and non-negative integer ranges. These values are
useful because small integers occur frequently in programs.
This is a CPython implementation detail, not a rule that every
Python implementation must follow.

## How arguments are passed to functions and what this implies

Python passes object references to functions through assignment.
A function parameter becomes a local name referring to the
object supplied by the caller.

With an immutable object, reassigning the parameter does not
change the caller's variable:

```python
def increment(number):
    number += 1

value = 1
increment(value)
print(value)
```

Output:

```text
1
```

With a mutable object, modifying the object through the
parameter can affect the caller's object:

```python
def add_item(items):
    items.append(4)

values = [1, 2, 3]
add_item(values)
print(values)
```

Output:

```text
[1, 2, 3, 4]
```

However, assigning a parameter to another object does not
reassign the caller's variable:

```python
def assign_value(first, second):
    first = second

list_one = [1, 2, 3]
list_two = [4, 5, 6]

assign_value(list_one, list_two)
print(list_one)
```

Output:

```text
[1, 2, 3]
```

This shows the difference between modifying an object and
reassigning a local variable.

## Conclusion

Understanding that everything in Python is an object makes
references, identity, aliases, and mutability easier to understand.
The difference between `is` and `==` is especially important:
`is` checks identity, while `==` checks equality. Mutable objects
can be changed in place, while immutable objects cannot.
Knowing how Python passes object references to functions helps
prevent unexpected changes and makes programs easier to reason
about.
