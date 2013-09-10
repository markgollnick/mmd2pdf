## EE 230
### Lab 02
#### Prepared by Mark R. Gollnick

--------

### Part 1: Basic Information

This is **bold text**, this is *italic text*.

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

--------

These are unordered lists.

**List Of Paragraphs**

* This is the first item in an unordered list

* This is the second item

    * This is a sub-point

    * This is another sub-point

        * Level three!

        * Wow.

* This is the third item

**List Of Items**

* This is the first item in an unordered list
* This is the second item
    * This is a sub-point
    * This is another sub-point
        * Level three!
        * Wow.
* This is the third item

<div style="page-break-after: always;"></div>

--------

These are ordered lists.

**List Of Paragraphs**

1. This is an item

2. This is another item

    * Don't forget about this one

    * And this one

        1. How about this one?

        2. Or this?

3. This is the last item

**List Of Items**

1. This is an item
2. This is another item
    * Don't forget about this one
    * And this one
        1. How about this one?
        2. Or this?
3. This is the last item

--------

![This is an image.](test.png)

<div style="page-break-after: always;"></div>

--------

### Part 2: Advanced Information

This is a dictionary.

Red
: Roses are red

Violet
: Violets are blue

That there is a dictionary.

--------

This is a table.

| Header 1 | Header 2 |
| -------- | -------- |
| Testing  | Hi mom!  |

There's the table.

--------

This is a quote.

> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
> tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
> quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
> consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
> cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
> proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

<div style="page-break-after: always;"></div>

--------

### Part 3: Technical Information

Check out this source code:

`hello.c`

    #include <stdio.h>

    int main(void) {
        printf("Hello, world!\n");
        return 0;
    }

--------

Math (will only work if `--math` was specified, otherwise, will be plain LaTeX)

\\(
{A}_{v} = \frac{{v}_{i}}{{v}_{o}}
\\)

--------

This is a [hyperlink][google].

[google]: http://www.google.com/

<div style="page-break-after: always;"></div>

--------

### Part 4: Multi-Depth Testing

1. This is...

    * ...an example of...

        ...some depth testing (with paragraphs).

2. *This* is...
    * ...an example of...
        ...some depth testing (without paragraphs).

3. How about...

    * Tables?

        | Such | As   |
        | ---- | ---- |
        | this | one? |

    * Quotes?

        > Some
        > Good
        > Ol'
        > Quotes

    * Code Blocks?

            THIS
            IS
            A
            TEST

--------

| Testing Table | Robustness |
| ------------- | ---------- |
| * List item   | > Quote    |
| `monospace`   |     code   |

--------

> This is a blockquote test.
>
> > Multiple levels are supported.
> >
> > Each level supports full functionality:
> >
> > * Lists
> > * Work!
> >
> > | Tables |
> > | ------ |
> > | Work!  |
> >
> >     Code
> >     Works!
>
> Pretty cool, huh?

--------

The End.
