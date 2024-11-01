*turtle.pyx*                                  Last change: 2023 Sep 15

"turtle" — Turtle graphics
**************************

**Source code:** Lib/turtle.py

======================================================================


Introduction
============

Turtle graphics is an implementation of the popular geometric drawing
tools introduced in Logo, developed by Wally Feurzeig, Seymour Papert
and Cynthia Solomon in 1967.


Get started
===========

Imagine a robotic turtle starting at (0, 0) in the x-y plane.  After
an "import turtle", give it the command "turtle.forward(15)", and it
moves (on-screen!) 15 pixels in the direction it is facing, drawing a
line as it moves.  Give it the command "turtle.right(25)", and it
rotates in-place 25 degrees clockwise.


Turtle star
^^^^^^^^^^^

Turtle can draw intricate shapes using programs that repeat simple
moves.

[image]

In Python, turtle graphics provides a representation of a physical
“turtle” (a little robot with a pen) that draws on a sheet of paper on
the floor.

It’s an effective and well-proven way for learners to encounter
programming concepts and interaction with software, as it provides
instant, visible feedback. It also provides convenient access to
graphical output in general.

Turtle drawing was originally created as an educational tool, to be
used by teachers in the classroom. For the programmer who needs to
produce some graphical output it can be a way to do that without the
overhead of introducing more complex or external libraries into their
work.


Tutorial
========

New users should start here. In this tutorial we’ll explore some of
the basics of turtle drawing.


Starting a turtle environment
-----------------------------

In a Python shell, import all the objects of the "turtle" module:
>
   from turtle import *
<
If you run into a "No module named '_tkinter'" error, you’ll have to
install the "Tk interface package" on your system.


Basic drawing
-------------

Send the turtle forward 100 steps:
>
   forward(100)
<
You should see (most likely, in a new window on your display) a line
drawn by the turtle, heading East. Change the direction of the turtle,
so that it turns 120 degrees left (anti-clockwise):
>
   left(120)
<
Let’s continue by drawing a triangle:
>
   forward(100)
   left(120)
   forward(100)
<
Notice how the turtle, represented by an arrow, points in different
directions as you steer it.

Experiment with those commands, and also with "backward()" and
"right()".


Pen control
~~~~~~~~~~~

Try changing the color - for example, "color('blue')" - and width of
the line - for example, "width(3)" - and then drawing again.

You can also move the turtle around without drawing, by lifting up the
pen: "up()" before moving. To start drawing again, use "down()".


The turtle’s position
~~~~~~~~~~~~~~~~~~~~~

Send your turtle back to its starting-point (useful if it has
disappeared off-screen):
>
   home()
<
The home position is at the center of the turtle’s screen. If you ever
need to know them, get the turtle’s x-y co-ordinates with:
>
   pos()
<
Home is at "(0, 0)".

And after a while, it will probably help to clear the window so we can
start anew:
>
   clearscreen()
<

Making algorithmic patterns
---------------------------

Using loops, it’s possible to build up geometric patterns:
>
   for steps in range(100):
       for c in ('blue', 'red', 'green'):
           color(c)
           forward(steps)
           right(30)
<
- which of course, are limited only by the imagination!

Let’s draw the star shape at the top of this page. We want red lines,
filled in with yellow:
>
   color('red')
   fillcolor('yellow')
<
Just as "up()" and "down()" determine whether lines will be drawn,
filling can be turned on and off:
>
   begin_fill()
<
Next we’ll create a loop:
>
   while True:
       forward(200)
       left(170)
       if abs(pos()) < 1:
           break
<
"abs(pos()) < 1" is a good way to know when the turtle is back at its
home position.

Finally, complete the filling:
>
   end_fill()
<
(Note that filling only actually takes place when you give the
"end_fill()" command.)


How to…
=======

This section covers some typical turtle use-cases and approaches.


Get started as quickly as possible
----------------------------------

One of the joys of turtle graphics is the immediate, visual feedback
that’s available from simple commands - it’s an excellent way to
introduce children to programming ideas, with a minimum of overhead
(not just children, of course).

The turtle module makes this possible by exposing all its basic
functionality as functions, available with "from turtle import *". The
turtle graphics tutorial covers this approach.

It’s worth noting that many of the turtle commands also have even more
terse equivalents, such as "fd()" for "forward()". These are
especially useful when working with learners for whom typing is not a
skill.

   You’ll need to have the "Tk interface package" installed on your
   system for turtle graphics to work. Be warned that this is not
   always straightforward, so check this in advance if you’re planning
   to use turtle graphics with a learner.


Use the "turtle" module namespace
---------------------------------

Using "from turtle import *" is convenient - but be warned that it
imports a rather large collection of objects, and if you’re doing
anything but turtle graphics you run the risk of a name conflict (this
becomes even more an issue if you’re using turtle graphics in a script
where other modules might be imported).

The solution is to use "import turtle" - "fd()" becomes "turtle.fd()",
"width()" becomes "turtle.width()" and so on. (If typing “turtle” over
and over again becomes tedious, use for example "import turtle as t"
instead.)


Use turtle graphics in a script
-------------------------------

It’s recommended to use the "turtle" module namespace as described
immediately above, for example:
>
   import turtle as t
   from random import random

   for i in range(100):
       steps = int(random() * 100)
       angle = int(random() * 360)
       t.right(angle)
       t.fd(steps)
<
Another step is also required though - as soon as the script ends,
Python will also close the turtle’s window. Add:
>
   t.mainloop()
<
to the end of the script. The script will now wait to be dismissed and
will not exit until it is terminated, for example by closing the
turtle graphics window.


Use object-oriented turtle graphics
-----------------------------------

See also: Explanation of the object-oriented interface

Other than for very basic introductory purposes, or for trying things
out as quickly as possible, it’s more usual and much more powerful to
use the object-oriented approach to turtle graphics. For example, this
allows multiple turtles on screen at once.

In this approach, the various turtle commands are methods of objects
(mostly of "Turtle" objects). You _can_ use the object-oriented
approach in the shell, but it would be more typical in a Python
script.

The example above then becomes:
>
   from turtle import Turtle
   from random import random

   t = Turtle()
   for i in range(100):
       steps = int(random() * 100)
       angle = int(random() * 360)
       t.right(angle)
       t.fd(steps)

   t.screen.mainloop()
<
Note the last line. "t.screen" is an instance of the "Screen" that a
Turtle instance exists on; it’s created automatically along with the
turtle.

The turtle’s screen can be customised, for example:
>
   t.screen.title('Object-oriented turtle demo')
   t.screen.bgcolor("orange")
<

Turtle graphics reference
=========================

Note:

  In the following documentation the argument list for functions is
  given. Methods, of course, have the additional first argument _self_
  which is omitted here.


Turtle methods
--------------

Turtle motion
   Move and draw
         "forward()" | "fd()"
         "backward()" | "bk()" | "back()"
         "right()" | "rt()"
         "left()" | "lt()"
         "goto()" | "setpos()" | "setposition()"
         "teleport()"
         "setx()"
         "sety()"
         "setheading()" | "seth()"
         "home()"
         "circle()"
         "dot()"
         "stamp()"
         "clearstamp()"
         "clearstamps()"
         "undo()"
         "speed()"

   Tell Turtle’s state
         "position()" | "pos()"
         "towards()"
         "xcor()"
         "ycor()"
         "heading()"
         "distance()"

   Setting and measurement
         "degrees()"
         "radians()"

Pen control
   Drawing state
         "pendown()" | "pd()" | "down()"
         "penup()" | "pu()" | "up()"
         "pensize()" | "width()"
         "pen()"
         "isdown()"

   Color control
         "color()"
         "pencolor()"
         "fillcolor()"

   Filling
         "filling()"
         "begin_fill()"
         "end_fill()"

   More drawing control
         "reset()"
         "clear()"
         "write()"

Turtle state
   Visibility
         "showturtle()" | "st()"
         "hideturtle()" | "ht()"
         "isvisible()"

   Appearance
         "shape()"
         "resizemode()"
         "shapesize()" | "turtlesize()"
         "shearfactor()"
         "tiltangle()"
         "tilt()"
         "shapetransform()"
         "get_shapepoly()"

Using events
      "onclick()"
      "onrelease()"
      "ondrag()"

Special Turtle methods
      "begin_poly()"
      "end_poly()"
      "get_poly()"
      "clone()"
      "getturtle()" | "getpen()"
      "getscreen()"
      "setundobuffer()"
      "undobufferentries()"


Methods of TurtleScreen/Screen
------------------------------

Window control
      "bgcolor()"
      "bgpic()"
      "clearscreen()"
      "resetscreen()"
      "screensize()"
      "setworldcoordinates()"

Animation control
      "delay()"
      "tracer()"
      "update()"

Using screen events
      "listen()"
      "onkey()" | "onkeyrelease()"
      "onkeypress()"
      "onclick()" | "onscreenclick()"
      "ontimer()"
      "mainloop()" | "done()"

Settings and special methods
      "mode()"
      "colormode()"
      "getcanvas()"
      "getshapes()"
      "register_shape()" | "addshape()"
      "turtles()"
      "window_height()"
      "window_width()"

Input methods
      "textinput()"
      "numinput()"

Methods specific to Screen
      "bye()"
      "exitonclick()"
      "setup()"
      "title()"


Methods of RawTurtle/Turtle and corresponding functions
=======================================================

Most of the examples in this section refer to a Turtle instance called
"turtle".


Turtle motion
-------------

turtle.forward(distance)                       *forward()..turtle.pyx*
turtle.fd(distance)                                 *fd()..turtle.pyx*

   Parameters:
      **distance** – a number (integer or float)

   Move the turtle forward by the specified _distance_, in the
   direction the turtle is headed.
>
      >>> turtle.position()
      (0.00,0.00)
      >>> turtle.forward(25)
      >>> turtle.position()
      (25.00,0.00)
      >>> turtle.forward(-75)
      >>> turtle.position()
      (-50.00,0.00)
<
turtle.back(distance)                             *back()..turtle.pyx*
turtle.bk(distance)                                 *bk()..turtle.pyx*
turtle.backward(distance)                     *backward()..turtle.pyx*

   Parameters:
      **distance** – a number

   Move the turtle backward by _distance_, opposite to the direction
   the turtle is headed.  Do not change the turtle’s heading.
>
      >>> turtle.position()
      (0.00,0.00)
      >>> turtle.backward(30)
      >>> turtle.position()
      (-30.00,0.00)
<
turtle.right(angle)                              *right()..turtle.pyx*
turtle.rt(angle)                                    *rt()..turtle.pyx*

   Parameters:
      **angle** – a number (integer or float)

   Turn turtle right by _angle_ units.  (Units are by default degrees,
   but can be set via the "degrees()" and "radians()" functions.)
   Angle orientation depends on the turtle mode, see "mode()".
>
      >>> turtle.heading()
      22.0
      >>> turtle.right(45)
      >>> turtle.heading()
      337.0
<
turtle.left(angle)                                *left()..turtle.pyx*
turtle.lt(angle)                                    *lt()..turtle.pyx*

   Parameters:
      **angle** – a number (integer or float)

   Turn turtle left by _angle_ units.  (Units are by default degrees,
   but can be set via the "degrees()" and "radians()" functions.)
   Angle orientation depends on the turtle mode, see "mode()".
>
      >>> turtle.heading()
      22.0
      >>> turtle.left(45)
      >>> turtle.heading()
      67.0
<
turtle.goto(x, y=None)                            *goto()..turtle.pyx*
turtle.setpos(x, y=None)                        *setpos()..turtle.pyx*
turtle.setposition(x, y=None)              *setposition()..turtle.pyx*

   Parameters:
      * **x** – a number or a pair/vector of numbers

      * **y** – a number or "None"

   If _y_ is "None", _x_ must be a pair of coordinates or a "Vec2D"
   (e.g. as returned by "pos()").

   Move turtle to an absolute position.  If the pen is down, draw
   line.  Do not change the turtle’s orientation.
>
      >>> tp = turtle.pos()
      >>> tp
      (0.00,0.00)
      >>> turtle.setpos(60,30)
      >>> turtle.pos()
      (60.00,30.00)
      >>> turtle.setpos((20,80))
      >>> turtle.pos()
      (20.00,80.00)
      >>> turtle.setpos(tp)
      >>> turtle.pos()
      (0.00,0.00)
<

                                              *teleport()..turtle.pyx*
turtle.teleport(x, y=None, *, fill_gap=False)

   Parameters:
      * **x** – a number or "None"

      * **y** – a number or "None"

      * **fill_gap** – a boolean

   Move turtle to an absolute position. Unlike goto(x, y), a line will
   not be drawn. The turtle’s orientation does not change. If
   currently filling, the polygon(s) teleported from will be filled
   after leaving, and filling will begin again after teleporting. This
   can be disabled with fill_gap=True, which makes the imaginary line
   traveled during teleporting act as a fill barrier like in goto(x,
   y).
>
      >>> tp = turtle.pos()
      >>> tp
      (0.00,0.00)
      >>> turtle.teleport(60)
      >>> turtle.pos()
      (60.00,0.00)
      >>> turtle.teleport(y=10)
      >>> turtle.pos()
      (60.00,10.00)
      >>> turtle.teleport(20, 30)
      >>> turtle.pos()
      (20.00,30.00)
<
turtle.setx(x)                                    *setx()..turtle.pyx*

   Parameters:
      **x** – a number (integer or float)

   Set the turtle’s first coordinate to _x_, leave second coordinate
   unchanged.
>
      >>> turtle.position()
      (0.00,240.00)
      >>> turtle.setx(10)
      >>> turtle.position()
      (10.00,240.00)
<
turtle.sety(y)                                    *sety()..turtle.pyx*

   Parameters:
      **y** – a number (integer or float)

   Set the turtle’s second coordinate to _y_, leave first coordinate
   unchanged.
>
      >>> turtle.position()
      (0.00,40.00)
      >>> turtle.sety(-10)
      >>> turtle.position()
      (0.00,-10.00)
<
turtle.setheading(to_angle)                 *setheading()..turtle.pyx*
turtle.seth(to_angle)                             *seth()..turtle.pyx*

   Parameters:
      **to_angle** – a number (integer or float)

   Set the orientation of the turtle to _to_angle_.  Here are some
   common directions in degrees:

   +---------------------+----------------------+
   | standard mode       | logo mode            |
   |=====================|======================|
   | 0 - east            | 0 - north            |
   +---------------------+----------------------+
   | 90 - north          | 90 - east            |
   +---------------------+----------------------+
   | 180 - west          | 180 - south          |
   +---------------------+----------------------+
   | 270 - south         | 270 - west           |
   +---------------------+----------------------+
>
      >>> turtle.setheading(90)
      >>> turtle.heading()
      90.0
<
turtle.home()                                     *home()..turtle.pyx*

   Move turtle to the origin – coordinates (0,0) – and set its heading
   to its start-orientation (which depends on the mode, see "mode()").
>
      >>> turtle.heading()
      90.0
      >>> turtle.position()
      (0.00,-10.00)
      >>> turtle.home()
      >>> turtle.position()
      (0.00,0.00)
      >>> turtle.heading()
      0.0
<

                                                *circle()..turtle.pyx*
turtle.circle(radius, extent=None, steps=None)

   Parameters:
      * **radius** – a number

      * **extent** – a number (or "None")

      * **steps** – an integer (or "None")

   Draw a circle with given _radius_.  The center is _radius_ units
   left of the turtle; _extent_ – an angle – determines which part of
   the circle is drawn.  If _extent_ is not given, draw the entire
   circle.  If _extent_ is not a full circle, one endpoint of the arc
   is the current pen position.  Draw the arc in counterclockwise
   direction if _radius_ is positive, otherwise in clockwise
   direction.  Finally the direction of the turtle is changed by the
   amount of _extent_.

   As the circle is approximated by an inscribed regular polygon,
   _steps_ determines the number of steps to use.  If not given, it
   will be calculated automatically.  May be used to draw regular
   polygons.
>
      >>> turtle.home()
      >>> turtle.position()
      (0.00,0.00)
      >>> turtle.heading()
      0.0
      >>> turtle.circle(50)
      >>> turtle.position()
      (-0.00,0.00)
      >>> turtle.heading()
      0.0
      >>> turtle.circle(120, 180)  # draw a semicircle
      >>> turtle.position()
      (0.00,240.00)
      >>> turtle.heading()
      180.0
<
turtle.dot(size=None, *color)                      *dot()..turtle.pyx*

   Parameters:
      * **size** – an integer >= 1 (if given)

      * **color** – a colorstring or a numeric color tuple

   Draw a circular dot with diameter _size_, using _color_.  If _size_
   is not given, the maximum of pensize+4 and 2*pensize is used.
>
      >>> turtle.home()
      >>> turtle.dot()
      >>> turtle.fd(50); turtle.dot(20, "blue"); turtle.fd(50)
      >>> turtle.position()
      (100.00,-0.00)
      >>> turtle.heading()
      0.0
<
turtle.stamp()                                   *stamp()..turtle.pyx*

   Stamp a copy of the turtle shape onto the canvas at the current
   turtle position.  Return a stamp_id for that stamp, which can be
   used to delete it by calling "clearstamp(stamp_id)".
>
      >>> turtle.color("blue")
      >>> stamp_id = turtle.stamp()
      >>> turtle.fd(50)
<
turtle.clearstamp(stampid)                  *clearstamp()..turtle.pyx*

   Parameters:
      **stampid** – an integer, must be return value of previous
      "stamp()" call

   Delete stamp with given _stampid_.
>
      >>> turtle.position()
      (150.00,-0.00)
      >>> turtle.color("blue")
      >>> astamp = turtle.stamp()
      >>> turtle.fd(50)
      >>> turtle.position()
      (200.00,-0.00)
      >>> turtle.clearstamp(astamp)
      >>> turtle.position()
      (200.00,-0.00)
<
turtle.clearstamps(n=None)                 *clearstamps()..turtle.pyx*

   Parameters:
      **n** – an integer (or "None")

   Delete all or first/last _n_ of turtle’s stamps.  If _n_ is "None",
   delete all stamps, if _n_ > 0 delete first _n_ stamps, else if _n_
   < 0 delete last _n_ stamps.
>
      >>> for i in range(8):
      ...     unused_stamp_id = turtle.stamp()
      ...     turtle.fd(30)
      >>> turtle.clearstamps(2)
      >>> turtle.clearstamps(-2)
      >>> turtle.clearstamps()
<
turtle.undo()                                     *undo()..turtle.pyx*

   Undo (repeatedly) the last turtle action(s).  Number of available
   undo actions is determined by the size of the undobuffer.
>
      >>> for i in range(4):
      ...     turtle.fd(50); turtle.lt(80)
      ...
      >>> for i in range(8):
      ...     turtle.undo()
<
turtle.speed(speed=None)                         *speed()..turtle.pyx*

   Parameters:
      **speed** – an integer in the range 0..10 or a speedstring (see
      below)

   Set the turtle’s speed to an integer value in the range 0..10.  If
   no argument is given, return current speed.

   If input is a number greater than 10 or smaller than 0.5, speed is
   set to 0.  Speedstrings are mapped to speedvalues as follows:

   * “fastest”:  0

   * “fast”:  10

   * “normal”:  6

   * “slow”:  3

   * “slowest”:  1

   Speeds from 1 to 10 enforce increasingly faster animation of line
   drawing and turtle turning.

   Attention: _speed_ = 0 means that _no_ animation takes place.
   forward/back makes turtle jump and likewise left/right make the
   turtle turn instantly.
>
      >>> turtle.speed()
      3
      >>> turtle.speed('normal')
      >>> turtle.speed()
      6
      >>> turtle.speed(9)
      >>> turtle.speed()
      9
<

Tell Turtle’s state
-------------------

turtle.position()                             *position()..turtle.pyx*
turtle.pos()                                       *pos()..turtle.pyx*

   Return the turtle’s current location (x,y) (as a "Vec2D" vector).
>
      >>> turtle.pos()
      (440.00,-0.00)
<
turtle.towards(x, y=None)                      *towards()..turtle.pyx*

   Parameters:
      * **x** – a number or a pair/vector of numbers or a turtle
        instance

      * **y** – a number if _x_ is a number, else "None"

   Return the angle between the line from turtle position to position
   specified by (x,y), the vector or the other turtle.  This depends
   on the turtle’s start orientation which depends on the mode -
   “standard”/”world” or “logo”.
>
      >>> turtle.goto(10, 10)
      >>> turtle.towards(0,0)
      225.0
<
turtle.xcor()                                     *xcor()..turtle.pyx*

   Return the turtle’s x coordinate.
>
      >>> turtle.home()
      >>> turtle.left(50)
      >>> turtle.forward(100)
      >>> turtle.pos()
      (64.28,76.60)
      >>> print(round(turtle.xcor(), 5))
      64.27876
<
turtle.ycor()                                     *ycor()..turtle.pyx*

   Return the turtle’s y coordinate.
>
      >>> turtle.home()
      >>> turtle.left(60)
      >>> turtle.forward(100)
      >>> print(turtle.pos())
      (50.00,86.60)
      >>> print(round(turtle.ycor(), 5))
      86.60254
<
turtle.heading()                               *heading()..turtle.pyx*

   Return the turtle’s current heading (value depends on the turtle
   mode, see "mode()").
>
      >>> turtle.home()
      >>> turtle.left(67)
      >>> turtle.heading()
      67.0
<
turtle.distance(x, y=None)                    *distance()..turtle.pyx*

   Parameters:
      * **x** – a number or a pair/vector of numbers or a turtle
        instance

      * **y** – a number if _x_ is a number, else "None"

   Return the distance from the turtle to (x,y), the given vector, or
   the given other turtle, in turtle step units.
>
      >>> turtle.home()
      >>> turtle.distance(30,40)
      50.0
      >>> turtle.distance((30,40))
      50.0
      >>> joe = Turtle()
      >>> joe.forward(77)
      >>> turtle.distance(joe)
      77.0
<

Settings for measurement
------------------------

turtle.degrees(fullcircle=360.0)               *degrees()..turtle.pyx*

   Parameters:
      **fullcircle** – a number

   Set angle measurement units, i.e. set number of “degrees” for a
   full circle. Default value is 360 degrees.
>
      >>> turtle.home()
      >>> turtle.left(90)
      >>> turtle.heading()
      90.0

      Change angle measurement unit to grad (also known as gon,
      grade, or gradian and equals 1/100-th of the right angle.)
      >>> turtle.degrees(400.0)
      >>> turtle.heading()
      100.0
      >>> turtle.degrees(360)
      >>> turtle.heading()
      90.0
<
turtle.radians()                               *radians()..turtle.pyx*

   Set the angle measurement units to radians.  Equivalent to
   "degrees(2*math.pi)".
>
      >>> turtle.home()
      >>> turtle.left(90)
      >>> turtle.heading()
      90.0
      >>> turtle.radians()
      >>> turtle.heading()
      1.5707963267948966
<

Pen control
-----------


Drawing state
~~~~~~~~~~~~~

turtle.pendown()                               *pendown()..turtle.pyx*
turtle.pd()                                         *pd()..turtle.pyx*
turtle.down()                                     *down()..turtle.pyx*

   Pull the pen down – drawing when moving.

turtle.penup()                                   *penup()..turtle.pyx*
turtle.pu()                                         *pu()..turtle.pyx*
turtle.up()                                         *up()..turtle.pyx*

   Pull the pen up – no drawing when moving.

turtle.pensize(width=None)                     *pensize()..turtle.pyx*
turtle.width(width=None)                         *width()..turtle.pyx*

   Parameters:
      **width** – a positive number

   Set the line thickness to _width_ or return it.  If resizemode is
   set to “auto” and turtleshape is a polygon, that polygon is drawn
   with the same line thickness.  If no argument is given, the current
   pensize is returned.
>
      >>> turtle.pensize()
      1
      >>> turtle.pensize(10)   # from here on lines of width 10 are drawn
<
turtle.pen(pen=None, **pendict)                    *pen()..turtle.pyx*

   Parameters:
      * **pen** – a dictionary with some or all of the below listed
        keys

      * **pendict** – one or more keyword-arguments with the below
        listed keys as keywords

   Return or set the pen’s attributes in a “pen-dictionary” with the
   following key/value pairs:

   * “shown”: True/False

   * “pendown”: True/False

   * “pencolor”: color-string or color-tuple

   * “fillcolor”: color-string or color-tuple

   * “pensize”: positive number

   * “speed”: number in range 0..10

   * “resizemode”: “auto” or “user” or “noresize”

   * “stretchfactor”: (positive number, positive number)

   * “outline”: positive number

   * “tilt”: number

   This dictionary can be used as argument for a subsequent call to
   "pen()" to restore the former pen-state.  Moreover one or more of
   these attributes can be provided as keyword-arguments.  This can be
   used to set several pen attributes in one statement.
>
      >>> turtle.pen(fillcolor="black", pencolor="red", pensize=10)
      >>> sorted(turtle.pen().items())
      [('fillcolor', 'black'), ('outline', 1), ('pencolor', 'red'),
       ('pendown', True), ('pensize', 10), ('resizemode', 'noresize'),
       ('shearfactor', 0.0), ('shown', True), ('speed', 9),
       ('stretchfactor', (1.0, 1.0)), ('tilt', 0.0)]
      >>> penstate=turtle.pen()
      >>> turtle.color("yellow", "")
      >>> turtle.penup()
      >>> sorted(turtle.pen().items())[:3]
      [('fillcolor', ''), ('outline', 1), ('pencolor', 'yellow')]
      >>> turtle.pen(penstate, fillcolor="green")
      >>> sorted(turtle.pen().items())[:3]
      [('fillcolor', 'green'), ('outline', 1), ('pencolor', 'red')]
<
turtle.isdown()                                 *isdown()..turtle.pyx*

   Return "True" if pen is down, "False" if it’s up.
>
      >>> turtle.penup()
      >>> turtle.isdown()
      False
      >>> turtle.pendown()
      >>> turtle.isdown()
      True
<

Color control
~~~~~~~~~~~~~

turtle.pencolor(*args)                        *pencolor()..turtle.pyx*

   Return or set the pencolor.

   Four input formats are allowed:

   "pencolor()"
      Return the current pencolor as color specification string or as
      a tuple (see example).  May be used as input to another
      color/pencolor/fillcolor call.

   "pencolor(colorstring)"
      Set pencolor to _colorstring_, which is a Tk color specification
      string, such as ""red"", ""yellow"", or ""#33cc8c"".

   "pencolor((r, g, b))"
      Set pencolor to the RGB color represented by the tuple of _r_,
      _g_, and _b_.  Each of _r_, _g_, and _b_ must be in the range
      0..colormode, where colormode is either 1.0 or 255 (see
      "colormode()").

   "pencolor(r, g, b)"
      Set pencolor to the RGB color represented by _r_, _g_, and _b_.
      Each of _r_, _g_, and _b_ must be in the range 0..colormode.

   If turtleshape is a polygon, the outline of that polygon is drawn
   with the newly set pencolor.
>
      >>> colormode()
      1.0
      >>> turtle.pencolor()
      'red'
      >>> turtle.pencolor("brown")
      >>> turtle.pencolor()
      'brown'
      >>> tup = (0.2, 0.8, 0.55)
      >>> turtle.pencolor(tup)
      >>> turtle.pencolor()
      (0.2, 0.8, 0.5490196078431373)
      >>> colormode(255)
      >>> turtle.pencolor()
      (51.0, 204.0, 140.0)
      >>> turtle.pencolor('#32c18f')
      >>> turtle.pencolor()
      (50.0, 193.0, 143.0)
<
turtle.fillcolor(*args)                      *fillcolor()..turtle.pyx*

   Return or set the fillcolor.

   Four input formats are allowed:

   "fillcolor()"
      Return the current fillcolor as color specification string,
      possibly in tuple format (see example).  May be used as input to
      another color/pencolor/fillcolor call.

   "fillcolor(colorstring)"
      Set fillcolor to _colorstring_, which is a Tk color
      specification string, such as ""red"", ""yellow"", or
      ""#33cc8c"".

   "fillcolor((r, g, b))"
      Set fillcolor to the RGB color represented by the tuple of _r_,
      _g_, and _b_.  Each of _r_, _g_, and _b_ must be in the range
      0..colormode, where colormode is either 1.0 or 255 (see
      "colormode()").

   "fillcolor(r, g, b)"
      Set fillcolor to the RGB color represented by _r_, _g_, and _b_.
      Each of _r_, _g_, and _b_ must be in the range 0..colormode.

   If turtleshape is a polygon, the interior of that polygon is drawn
   with the newly set fillcolor.
>
      >>> turtle.fillcolor("violet")
      >>> turtle.fillcolor()
      'violet'
      >>> turtle.pencolor()
      (50.0, 193.0, 143.0)
      >>> turtle.fillcolor((50, 193, 143))  # Integers, not floats
      >>> turtle.fillcolor()
      (50.0, 193.0, 143.0)
      >>> turtle.fillcolor('#ffffff')
      >>> turtle.fillcolor()
      (255.0, 255.0, 255.0)
<
turtle.color(*args)                              *color()..turtle.pyx*

   Return or set pencolor and fillcolor.

   Several input formats are allowed.  They use 0 to 3 arguments as
   follows:

   "color()"
      Return the current pencolor and the current fillcolor as a pair
      of color specification strings or tuples as returned by
      "pencolor()" and "fillcolor()".

   "color(colorstring)", "color((r,g,b))", "color(r,g,b)"
      Inputs as in "pencolor()", set both, fillcolor and pencolor, to
      the given value.

   "color(colorstring1, colorstring2)", "color((r1,g1,b1),
   (r2,g2,b2))"
      Equivalent to "pencolor(colorstring1)" and
      "fillcolor(colorstring2)" and analogously if the other input
      format is used.

   If turtleshape is a polygon, outline and interior of that polygon
   is drawn with the newly set colors.
>
      >>> turtle.color("red", "green")
      >>> turtle.color()
      ('red', 'green')
      >>> color("#285078", "#a0c8f0")
      >>> color()
      ((40.0, 80.0, 120.0), (160.0, 200.0, 240.0))
<
See also: Screen method "colormode()".


Filling
~~~~~~~

turtle.filling()                               *filling()..turtle.pyx*

   Return fillstate ("True" if filling, "False" else).
>
      >>> turtle.begin_fill()
      >>> if turtle.filling():
      ...    turtle.pensize(5)
      ... else:
      ...    turtle.pensize(3)
<
turtle.begin_fill()                         *begin_fill()..turtle.pyx*

   To be called just before drawing a shape to be filled.

turtle.end_fill()                             *end_fill()..turtle.pyx*

   Fill the shape drawn after the last call to "begin_fill()".

   Whether or not overlap regions for self-intersecting polygons or
   multiple shapes are filled depends on the operating system
   graphics, type of overlap, and number of overlaps.  For example,
   the Turtle star above may be either all yellow or have some white
   regions.
>
      >>> turtle.color("black", "red")
      >>> turtle.begin_fill()
      >>> turtle.circle(80)
      >>> turtle.end_fill()
<

More drawing control
~~~~~~~~~~~~~~~~~~~~

turtle.reset()                                   *reset()..turtle.pyx*

   Delete the turtle’s drawings from the screen, re-center the turtle
   and set variables to the default values.
>
      >>> turtle.goto(0,-22)
      >>> turtle.left(100)
      >>> turtle.position()
      (0.00,-22.00)
      >>> turtle.heading()
      100.0
      >>> turtle.reset()
      >>> turtle.position()
      (0.00,0.00)
      >>> turtle.heading()
      0.0
<
turtle.clear()                                   *clear()..turtle.pyx*

   Delete the turtle’s drawings from the screen.  Do not move turtle.
   State and position of the turtle as well as drawings of other
   turtles are not affected.

                                                 *write()..turtle.pyx*
turtle.write(arg, move=False, align='left', font=('Arial', 8, 'normal'))

   Parameters:
      * **arg** – object to be written to the TurtleScreen

      * **move** – True/False

      * **align** – one of the strings “left”, “center” or right”

      * **font** – a triple (fontname, fontsize, fonttype)

   Write text - the string representation of _arg_ - at the current
   turtle position according to _align_ (“left”, “center” or “right”)
   and with the given font.  If _move_ is true, the pen is moved to
   the bottom-right corner of the text.  By default, _move_ is
   "False".

   >>> turtle.write("Home = ", True, align="center")
   >>> turtle.write((0,0), True)


Turtle state
------------


Visibility
~~~~~~~~~~

turtle.hideturtle()                         *hideturtle()..turtle.pyx*
turtle.ht()                                         *ht()..turtle.pyx*

   Make the turtle invisible.  It’s a good idea to do this while
   you’re in the middle of doing some complex drawing, because hiding
   the turtle speeds up the drawing observably.
>
      >>> turtle.hideturtle()
<
turtle.showturtle()                         *showturtle()..turtle.pyx*
turtle.st()                                         *st()..turtle.pyx*

   Make the turtle visible.
>
      >>> turtle.showturtle()
<
turtle.isvisible()                           *isvisible()..turtle.pyx*

   Return "True" if the Turtle is shown, "False" if it’s hidden.

   >>> turtle.hideturtle()
   >>> turtle.isvisible()
   False
   >>> turtle.showturtle()
   >>> turtle.isvisible()
   True


Appearance
~~~~~~~~~~

turtle.shape(name=None)                          *shape()..turtle.pyx*

   Parameters:
      **name** – a string which is a valid shapename

   Set turtle shape to shape with given _name_ or, if name is not
   given, return name of current shape.  Shape with _name_ must exist
   in the TurtleScreen’s shape dictionary.  Initially there are the
   following polygon shapes: “arrow”, “turtle”, “circle”, “square”,
   “triangle”, “classic”.  To learn about how to deal with shapes see
   Screen method "register_shape()".
>
      >>> turtle.shape()
      'classic'
      >>> turtle.shape("turtle")
      >>> turtle.shape()
      'turtle'
<
turtle.resizemode(rmode=None)               *resizemode()..turtle.pyx*

   Parameters:
      **rmode** – one of the strings “auto”, “user”, “noresize”

   Set resizemode to one of the values: “auto”, “user”, “noresize”.
   If _rmode_ is not given, return current resizemode.  Different
   resizemodes have the following effects:

   * “auto”: adapts the appearance of the turtle corresponding to the
     value of pensize.

   * “user”: adapts the appearance of the turtle according to the
     values of stretchfactor and outlinewidth (outline), which are set
     by "shapesize()".

   * “noresize”: no adaption of the turtle’s appearance takes place.

   "resizemode("user")" is called by "shapesize()" when used with
   arguments.
>
      >>> turtle.resizemode()
      'noresize'
      >>> turtle.resizemode("auto")
      >>> turtle.resizemode()
      'auto'
<

                                             *shapesize()..turtle.pyx*
turtle.shapesize(stretch_wid=None, stretch_len=None, outline=None)

                                            *turtlesize()..turtle.pyx*
turtle.turtlesize(stretch_wid=None, stretch_len=None, outline=None)

   Parameters:
      * **stretch_wid** – positive number

      * **stretch_len** – positive number

      * **outline** – positive number

   Return or set the pen’s attributes x/y-stretchfactors and/or
   outline.  Set resizemode to “user”.  If and only if resizemode is
   set to “user”, the turtle will be displayed stretched according to
   its stretchfactors: _stretch_wid_ is stretchfactor perpendicular to
   its orientation, _stretch_len_ is stretchfactor in direction of its
   orientation, _outline_ determines the width of the shape’s outline.
>
      >>> turtle.shapesize()
      (1.0, 1.0, 1)
      >>> turtle.resizemode("user")
      >>> turtle.shapesize(5, 5, 12)
      >>> turtle.shapesize()
      (5, 5, 12)
      >>> turtle.shapesize(outline=8)
      >>> turtle.shapesize()
      (5, 5, 8)
<
turtle.shearfactor(shear=None)             *shearfactor()..turtle.pyx*

   Parameters:
      **shear** – number (optional)

   Set or return the current shearfactor. Shear the turtleshape
   according to the given shearfactor shear, which is the tangent of
   the shear angle. Do _not_ change the turtle’s heading (direction of
   movement). If shear is not given: return the current shearfactor,
   i. e. the tangent of the shear angle, by which lines parallel to
   the heading of the turtle are sheared.
>
      >>> turtle.shape("circle")
      >>> turtle.shapesize(5,2)
      >>> turtle.shearfactor(0.5)
      >>> turtle.shearfactor()
      0.5
<
turtle.tilt(angle)                                *tilt()..turtle.pyx*

   Parameters:
      **angle** – a number

   Rotate the turtleshape by _angle_ from its current tilt-angle, but
   do _not_ change the turtle’s heading (direction of movement).
>
      >>> turtle.reset()
      >>> turtle.shape("circle")
      >>> turtle.shapesize(5,2)
      >>> turtle.tilt(30)
      >>> turtle.fd(50)
      >>> turtle.tilt(30)
      >>> turtle.fd(50)
<
turtle.tiltangle(angle=None)                 *tiltangle()..turtle.pyx*

   Parameters:
      **angle** – a number (optional)

   Set or return the current tilt-angle. If angle is given, rotate the
   turtleshape to point in the direction specified by angle,
   regardless of its current tilt-angle. Do _not_ change the turtle’s
   heading (direction of movement). If angle is not given: return the
   current tilt-angle, i. e. the angle between the orientation of the
   turtleshape and the heading of the turtle (its direction of
   movement).
>
      >>> turtle.reset()
      >>> turtle.shape("circle")
      >>> turtle.shapesize(5,2)
      >>> turtle.tilt(45)
      >>> turtle.tiltangle()
      45.0
<

                                        *shapetransform()..turtle.pyx*
turtle.shapetransform(t11=None, t12=None, t21=None, t22=None)

   Parameters:
      * **t11** – a number (optional)

      * **t12** – a number (optional)

      * **t21** – a number (optional)

      * **t12** – a number (optional)

   Set or return the current transformation matrix of the turtle
   shape.

   If none of the matrix elements are given, return the transformation
   matrix as a tuple of 4 elements. Otherwise set the given elements
   and transform the turtleshape according to the matrix consisting of
   first row t11, t12 and second row t21, t22. The determinant t11 *
   t22 - t12 * t21 must not be zero, otherwise an error is raised.
   Modify stretchfactor, shearfactor and tiltangle according to the
   given matrix.
>
      >>> turtle = Turtle()
      >>> turtle.shape("square")
      >>> turtle.shapesize(4,2)
      >>> turtle.shearfactor(-0.5)
      >>> turtle.shapetransform()
      (4.0, -1.0, -0.0, 2.0)
<
turtle.get_shapepoly()                   *get_shapepoly()..turtle.pyx*

   Return the current shape polygon as tuple of coordinate pairs. This
   can be used to define a new shape or components of a compound
   shape.
>
      >>> turtle.shape("square")
      >>> turtle.shapetransform(4, -1, 0, 2)
      >>> turtle.get_shapepoly()
      ((50, -20), (30, 20), (-50, 20), (-30, -20))
<

Using events
------------

turtle.onclick(fun, btn=1, add=None)           *onclick()..turtle.pyx*

   Parameters:
      * **fun** – a function with two arguments which will be called
        with the coordinates of the clicked point on the canvas

      * **btn** – number of the mouse-button, defaults to 1 (left
        mouse button)

      * **add** – "True" or "False" – if "True", a new binding will be
        added, otherwise it will replace a former binding

   Bind _fun_ to mouse-click events on this turtle.  If _fun_ is
   "None", existing bindings are removed.  Example for the anonymous
   turtle, i.e. the procedural way:
>
      >>> def turn(x, y):
      ...     left(180)
      ...
      >>> onclick(turn)  # Now clicking into the turtle will turn it.
      >>> onclick(None)  # event-binding will be removed
<
turtle.onrelease(fun, btn=1, add=None)       *onrelease()..turtle.pyx*

   Parameters:
      * **fun** – a function with two arguments which will be called
        with the coordinates of the clicked point on the canvas

      * **btn** – number of the mouse-button, defaults to 1 (left
        mouse button)

      * **add** – "True" or "False" – if "True", a new binding will be
        added, otherwise it will replace a former binding

   Bind _fun_ to mouse-button-release events on this turtle.  If _fun_
   is "None", existing bindings are removed.
>
      >>> class MyTurtle(Turtle):
      ...     def glow(self,x,y):
      ...         self.fillcolor("red")
      ...     def unglow(self,x,y):
      ...         self.fillcolor("")
      ...
      >>> turtle = MyTurtle()
      >>> turtle.onclick(turtle.glow)     # clicking on turtle turns fillcolor red,
      >>> turtle.onrelease(turtle.unglow) # releasing turns it to transparent.
<
turtle.ondrag(fun, btn=1, add=None)             *ondrag()..turtle.pyx*

   Parameters:
      * **fun** – a function with two arguments which will be called
        with the coordinates of the clicked point on the canvas

      * **btn** – number of the mouse-button, defaults to 1 (left
        mouse button)

      * **add** – "True" or "False" – if "True", a new binding will be
        added, otherwise it will replace a former binding

   Bind _fun_ to mouse-move events on this turtle.  If _fun_ is
   "None", existing bindings are removed.

   Remark: Every sequence of mouse-move-events on a turtle is preceded
   by a mouse-click event on that turtle.
>
      >>> turtle.ondrag(turtle.goto)
<
   Subsequently, clicking and dragging the Turtle will move it across
   the screen thereby producing handdrawings (if pen is down).


Special Turtle methods
----------------------

turtle.begin_poly()                         *begin_poly()..turtle.pyx*

   Start recording the vertices of a polygon.  Current turtle position
   is first vertex of polygon.

turtle.end_poly()                             *end_poly()..turtle.pyx*

   Stop recording the vertices of a polygon.  Current turtle position
   is last vertex of polygon.  This will be connected with the first
   vertex.

turtle.get_poly()                             *get_poly()..turtle.pyx*

   Return the last recorded polygon.
>
      >>> turtle.home()
      >>> turtle.begin_poly()
      >>> turtle.fd(100)
      >>> turtle.left(20)
      >>> turtle.fd(30)
      >>> turtle.left(60)
      >>> turtle.fd(50)
      >>> turtle.end_poly()
      >>> p = turtle.get_poly()
      >>> register_shape("myFavouriteShape", p)
<
turtle.clone()                                   *clone()..turtle.pyx*

   Create and return a clone of the turtle with same position, heading
   and turtle properties.
>
      >>> mick = Turtle()
      >>> joe = mick.clone()
<
turtle.getturtle()                           *getturtle()..turtle.pyx*
turtle.getpen()                                 *getpen()..turtle.pyx*

   Return the Turtle object itself.  Only reasonable use: as a
   function to return the “anonymous turtle”:
>
      >>> pet = getturtle()
      >>> pet.fd(50)
      >>> pet
      <turtle.Turtle object at 0x...>
<
turtle.getscreen()                           *getscreen()..turtle.pyx*

   Return the "TurtleScreen" object the turtle is drawing on.
   TurtleScreen methods can then be called for that object.
>
      >>> ts = turtle.getscreen()
      >>> ts
      <turtle._Screen object at 0x...>
      >>> ts.bgcolor("pink")
<
turtle.setundobuffer(size)               *setundobuffer()..turtle.pyx*

   Parameters:
      **size** – an integer or "None"

   Set or disable undobuffer.  If _size_ is an integer, an empty
   undobuffer of given size is installed.  _size_ gives the maximum
   number of turtle actions that can be undone by the "undo()"
   method/function.  If _size_ is "None", the undobuffer is disabled.
>
      >>> turtle.setundobuffer(42)
<
turtle.undobufferentries()           *undobufferentries()..turtle.pyx*

   Return number of entries in the undobuffer.
>
      >>> while undobufferentries():
      ...     undo()
<

Compound shapes
---------------

To use compound turtle shapes, which consist of several polygons of
different color, you must use the helper class "Shape" explicitly as
described below:

1. Create an empty Shape object of type “compound”.

2. Add as many components to this object as desired, using the
   "addcomponent()" method.

   For example:
>
      >>> s = Shape("compound")
      >>> poly1 = ((0,0),(10,-5),(0,10),(-10,-5))
      >>> s.addcomponent(poly1, "red", "blue")
      >>> poly2 = ((0,0),(10,-5),(-10,-5))
      >>> s.addcomponent(poly2, "blue", "red")
<
3. Now add the Shape to the Screen’s shapelist and use it:
>
      >>> register_shape("myshape", s)
      >>> shape("myshape")
<
Note:

  The "Shape" class is used internally by the "register_shape()"
  method in different ways.  The application programmer has to deal
  with the Shape class _only_ when using compound shapes like shown
  above!


Methods of TurtleScreen/Screen and corresponding functions
==========================================================

Most of the examples in this section refer to a TurtleScreen instance
called "screen".


Window control
--------------

turtle.bgcolor(*args)                          *bgcolor()..turtle.pyx*

   Parameters:
      **args** – a color string or three numbers in the range
      0..colormode or a 3-tuple of such numbers

   Set or return background color of the TurtleScreen.
>
      >>> screen.bgcolor("orange")
      >>> screen.bgcolor()
      'orange'
      >>> screen.bgcolor("#800080")
      >>> screen.bgcolor()
      (128.0, 0.0, 128.0)
<
turtle.bgpic(picname=None)                       *bgpic()..turtle.pyx*

   Parameters:
      **picname** – a string, name of a gif-file or ""nopic"", or
      "None"

   Set background image or return name of current backgroundimage.  If
   _picname_ is a filename, set the corresponding image as background.
   If _picname_ is ""nopic"", delete background image, if present.  If
   _picname_ is "None", return the filename of the current
   backgroundimage.
>
      >>> screen.bgpic()
      'nopic'
      >>> screen.bgpic("landscape.gif")
      >>> screen.bgpic()
      "landscape.gif"
<
turtle.clear()

   Note:

     This TurtleScreen method is available as a global function only
     under the name "clearscreen".  The global function "clear" is a
     different one derived from the Turtle method "clear".

turtle.clearscreen()                       *clearscreen()..turtle.pyx*

   Delete all drawings and all turtles from the TurtleScreen.  Reset
   the now empty TurtleScreen to its initial state: white background,
   no background image, no event bindings and tracing on.

turtle.reset()

   Note:

     This TurtleScreen method is available as a global function only
     under the name "resetscreen".  The global function "reset" is
     another one derived from the Turtle method "reset".

turtle.resetscreen()                       *resetscreen()..turtle.pyx*

   Reset all Turtles on the Screen to their initial state.

                                            *screensize()..turtle.pyx*
turtle.screensize(canvwidth=None, canvheight=None, bg=None)

   Parameters:
      * **canvwidth** – positive integer, new width of canvas in
        pixels

      * **canvheight** – positive integer, new height of canvas in
        pixels

      * **bg** – colorstring or color-tuple, new background color

   If no arguments are given, return current (canvaswidth,
   canvasheight).  Else resize the canvas the turtles are drawing on.
   Do not alter the drawing window.  To observe hidden parts of the
   canvas, use the scrollbars. With this method, one can make visible
   those parts of a drawing which were outside the canvas before.

   >>> screen.screensize()
   (400, 300)
   >>> screen.screensize(2000,1500)
   >>> screen.screensize()
   (2000, 1500)

   e.g. to search for an erroneously escaped turtle ;-)

                                   *setworldcoordinates()..turtle.pyx*
turtle.setworldcoordinates(llx, lly, urx, ury)

   Parameters:
      * **llx** – a number, x-coordinate of lower left corner of
        canvas

      * **lly** – a number, y-coordinate of lower left corner of
        canvas

      * **urx** – a number, x-coordinate of upper right corner of
        canvas

      * **ury** – a number, y-coordinate of upper right corner of
        canvas

   Set up user-defined coordinate system and switch to mode “world” if
   necessary.  This performs a "screen.reset()".  If mode “world” is
   already active, all drawings are redrawn according to the new
   coordinates.

   **ATTENTION**: in user-defined coordinate systems angles may appear
   distorted.
>
      >>> screen.reset()
      >>> screen.setworldcoordinates(-50,-7.5,50,7.5)
      >>> for _ in range(72):
      ...     left(10)
      ...
      >>> for _ in range(8):
      ...     left(45); fd(2)   # a regular octagon
<

Animation control
-----------------

turtle.delay(delay=None)                         *delay()..turtle.pyx*

   Parameters:
      **delay** – positive integer

   Set or return the drawing _delay_ in milliseconds.  (This is
   approximately the time interval between two consecutive canvas
   updates.)  The longer the drawing delay, the slower the animation.

   Optional argument:
>
      >>> screen.delay()
      10
      >>> screen.delay(5)
      >>> screen.delay()
      5
<
turtle.tracer(n=None, delay=None)               *tracer()..turtle.pyx*

   Parameters:
      * **n** – nonnegative integer

      * **delay** – nonnegative integer

   Turn turtle animation on/off and set delay for update drawings.  If
   _n_ is given, only each n-th regular screen update is really
   performed.  (Can be used to accelerate the drawing of complex
   graphics.)  When called without arguments, returns the currently
   stored value of n. Second argument sets delay value (see
   "delay()").
>
      >>> screen.tracer(8, 25)
      >>> dist = 2
      >>> for i in range(200):
      ...     fd(dist)
      ...     rt(90)
      ...     dist += 2
<
turtle.update()                                 *update()..turtle.pyx*

   Perform a TurtleScreen update. To be used when tracer is turned
   off.

See also the RawTurtle/Turtle method "speed()".


Using screen events
-------------------

turtle.listen(xdummy=None, ydummy=None)         *listen()..turtle.pyx*

   Set focus on TurtleScreen (in order to collect key-events).  Dummy
   arguments are provided in order to be able to pass "listen()" to
   the onclick method.

turtle.onkey(fun, key)                           *onkey()..turtle.pyx*
turtle.onkeyrelease(fun, key)             *onkeyrelease()..turtle.pyx*

   Parameters:
      * **fun** – a function with no arguments or "None"

      * **key** – a string: key (e.g. “a”) or key-symbol (e.g.
        “space”)

   Bind _fun_ to key-release event of key.  If _fun_ is "None", event
   bindings are removed. Remark: in order to be able to register key-
   events, TurtleScreen must have the focus. (See method "listen()".)
>
      >>> def f():
      ...     fd(50)
      ...     lt(60)
      ...
      >>> screen.onkey(f, "Up")
      >>> screen.listen()
<
turtle.onkeypress(fun, key=None)            *onkeypress()..turtle.pyx*

   Parameters:
      * **fun** – a function with no arguments or "None"

      * **key** – a string: key (e.g. “a”) or key-symbol (e.g.
        “space”)

   Bind _fun_ to key-press event of key if key is given, or to any
   key-press-event if no key is given. Remark: in order to be able to
   register key-events, TurtleScreen must have focus. (See method
   "listen()".)
>
      >>> def f():
      ...     fd(50)
      ...
      >>> screen.onkey(f, "Up")
      >>> screen.listen()
<
turtle.onclick(fun, btn=1, add=None)

                                         *onscreenclick()..turtle.pyx*
turtle.onscreenclick(fun, btn=1, add=None)

   Parameters:
      * **fun** – a function with two arguments which will be called
        with the coordinates of the clicked point on the canvas

      * **btn** – number of the mouse-button, defaults to 1 (left
        mouse button)

      * **add** – "True" or "False" – if "True", a new binding will be
        added, otherwise it will replace a former binding

   Bind _fun_ to mouse-click events on this screen.  If _fun_ is
   "None", existing bindings are removed.

   Example for a TurtleScreen instance named "screen" and a Turtle
   instance named "turtle":
>
      >>> screen.onclick(turtle.goto) # Subsequently clicking into the TurtleScreen will
      >>>                             # make the turtle move to the clicked point.
      >>> screen.onclick(None)        # remove event binding again
<
   Note:

     This TurtleScreen method is available as a global function only
     under the name "onscreenclick".  The global function "onclick" is
     another one derived from the Turtle method "onclick".

turtle.ontimer(fun, t=0)                       *ontimer()..turtle.pyx*

   Parameters:
      * **fun** – a function with no arguments

      * **t** – a number >= 0

   Install a timer that calls _fun_ after _t_ milliseconds.
>
      >>> running = True
      >>> def f():
      ...     if running:
      ...         fd(50)
      ...         lt(60)
      ...         screen.ontimer(f, 250)
      >>> f()   ### makes the turtle march around
      >>> running = False
<
turtle.mainloop()                             *mainloop()..turtle.pyx*
turtle.done()                                     *done()..turtle.pyx*

   Starts event loop - calling Tkinter’s mainloop function. Must be
   the last statement in a turtle graphics program. Must _not_ be used
   if a script is run from within IDLE in -n mode (No subprocess) -
   for interactive use of turtle graphics.
>
      >>> screen.mainloop()
<

Input methods
-------------

turtle.textinput(title, prompt)              *textinput()..turtle.pyx*

   Parameters:
      * **title** – string

      * **prompt** – string

   Pop up a dialog window for input of a string. Parameter title is
   the title of the dialog window, prompt is a text mostly describing
   what information to input. Return the string input. If the dialog
   is canceled, return "None".
>
      >>> screen.textinput("NIM", "Name of first player:")
<

                                              *numinput()..turtle.pyx*
turtle.numinput(title, prompt, default=None, minval=None, maxval=None)

   Parameters:
      * **title** – string

      * **prompt** – string

      * **default** – number (optional)

      * **minval** – number (optional)

      * **maxval** – number (optional)

   Pop up a dialog window for input of a number. title is the title of
   the dialog window, prompt is a text mostly describing what
   numerical information to input. default: default value, minval:
   minimum value for input, maxval: maximum value for input. The
   number input must be in the range minval .. maxval if these are
   given. If not, a hint is issued and the dialog remains open for
   correction. Return the number input. If the dialog is canceled,
   return "None".
>
      >>> screen.numinput("Poker", "Your stakes:", 1000, minval=10, maxval=10000)
<

Settings and special methods
----------------------------

turtle.mode(mode=None)                            *mode()..turtle.pyx*

   Parameters:
      **mode** – one of the strings “standard”, “logo” or “world”

   Set turtle mode (“standard”, “logo” or “world”) and perform reset.
   If mode is not given, current mode is returned.

   Mode “standard” is compatible with old "turtle".  Mode “logo” is
   compatible with most Logo turtle graphics.  Mode “world” uses user-
   defined “world coordinates”. **Attention**: in this mode angles
   appear distorted if "x/y" unit-ratio doesn’t equal 1.

   +--------------+---------------------------+---------------------+
   | Mode         | Initial turtle heading    | positive angles     |
   |==============|===========================|=====================|
   | “standard”   | to the right (east)       | counterclockwise    |
   +--------------+---------------------------+---------------------+
   | “logo”       | upward    (north)         | clockwise           |
   +--------------+---------------------------+---------------------+
>
      >>> mode("logo")   # resets turtle heading to north
      >>> mode()
      'logo'
<
turtle.colormode(cmode=None)                 *colormode()..turtle.pyx*

   Parameters:
      **cmode** – one of the values 1.0 or 255

   Return the colormode or set it to 1.0 or 255.  Subsequently _r_,
   _g_, _b_ values of color triples have to be in the range
   0..*cmode*.
>
      >>> screen.colormode(1)
      >>> turtle.pencolor(240, 160, 80)
      Traceback (most recent call last):
           ...
      TurtleGraphicsError: bad color sequence: (240, 160, 80)
      >>> screen.colormode()
      1.0
      >>> screen.colormode(255)
      >>> screen.colormode()
      255
      >>> turtle.pencolor(240,160,80)
<
turtle.getcanvas()                           *getcanvas()..turtle.pyx*

   Return the Canvas of this TurtleScreen.  Useful for insiders who
   know what to do with a Tkinter Canvas.
>
      >>> cv = screen.getcanvas()
      >>> cv
      <turtle.ScrolledCanvas object ...>
<
turtle.getshapes()                           *getshapes()..turtle.pyx*

   Return a list of names of all currently available turtle shapes.
>
      >>> screen.getshapes()
      ['arrow', 'blank', 'circle', ..., 'turtle']
<

                                        *register_shape()..turtle.pyx*
turtle.register_shape(name, shape=None)
turtle.addshape(name, shape=None)             *addshape()..turtle.pyx*

   There are three different ways to call this function:

   1. _name_ is the name of a gif-file and _shape_ is "None": Install
      the corresponding image shape.
>
         >>> screen.register_shape("turtle.gif")
<
      Note:

        Image shapes _do not_ rotate when turning the turtle, so they
        do not display the heading of the turtle!

   2. _name_ is an arbitrary string and _shape_ is a tuple of pairs of
      coordinates: Install the corresponding polygon shape.
>
         >>> screen.register_shape("triangle", ((5,-3), (0,5), (-5,-3)))
<
   3. _name_ is an arbitrary string and _shape_ is a (compound)
      "Shape" object: Install the corresponding compound shape.

   Add a turtle shape to TurtleScreen’s shapelist.  Only thusly
   registered shapes can be used by issuing the command
   "shape(shapename)".

turtle.turtles()                               *turtles()..turtle.pyx*

   Return the list of turtles on the screen.
>
      >>> for turtle in screen.turtles():
      ...     turtle.color("red")
<
turtle.window_height()                   *window_height()..turtle.pyx*

   Return the height of the turtle window.
>
      >>> screen.window_height()
      480
<
turtle.window_width()                     *window_width()..turtle.pyx*

   Return the width of the turtle window.
>
      >>> screen.window_width()
      640
<

Methods specific to Screen, not inherited from TurtleScreen
-----------------------------------------------------------

turtle.bye()                                       *bye()..turtle.pyx*

   Shut the turtlegraphics window.

turtle.exitonclick()                       *exitonclick()..turtle.pyx*

   Bind "bye()" method to mouse clicks on the Screen.

   If the value “using_IDLE” in the configuration dictionary is
   "False" (default value), also enter mainloop.  Remark: If IDLE with
   the "-n" switch (no subprocess) is used, this value should be set
   to "True" in "turtle.cfg".  In this case IDLE’s own mainloop is
   active also for the client script.

                                                 *setup()..turtle.pyx*
turtle.setup(width=_CFG['width'], height=_CFG['height'], startx=_CFG['leftright'], starty=_CFG['topbottom'])

   Set the size and position of the main window.  Default values of
   arguments are stored in the configuration dictionary and can be
   changed via a "turtle.cfg" file.

   Parameters:
      * **width** – if an integer, a size in pixels, if a float, a
        fraction of the screen; default is 50% of screen

      * **height** – if an integer, the height in pixels, if a float,
        a fraction of the screen; default is 75% of screen

      * **startx** – if positive, starting position in pixels from the
        left edge of the screen, if negative from the right edge, if
        "None", center window horizontally

      * **starty** – if positive, starting position in pixels from the
        top edge of the screen, if negative from the bottom edge, if
        "None", center window vertically
>
      >>> screen.setup (width=200, height=200, startx=0, starty=0)
      >>>              # sets window to 200x200 pixels, in upper left of screen
      >>> screen.setup(width=.75, height=0.5, startx=None, starty=None)
      >>>              # sets window to 75% of screen by 50% of screen and centers
<
turtle.title(titlestring)                        *title()..turtle.pyx*

   Parameters:
      **titlestring** – a string that is shown in the titlebar of the
      turtle graphics window

   Set title of turtle window to _titlestring_.
>
      >>> screen.title("Welcome to the turtle zoo!")
<

Public classes
==============

class turtle.RawTurtle(canvas)                 *RawTurtle..turtle.pyx*
class turtle.RawPen(canvas)                       *RawPen..turtle.pyx*

   Parameters:
      **canvas** – a "tkinter.Canvas", a "ScrolledCanvas" or a
      "TurtleScreen"

   Create a turtle.  The turtle has all methods described above as
   “methods of Turtle/RawTurtle”.

class turtle.Turtle                               *Turtle..turtle.pyx*

   Subclass of RawTurtle, has the same interface but draws on a
   default "Screen" object created automatically when needed for the
   first time.

class turtle.TurtleScreen(cv)               *TurtleScreen..turtle.pyx*

   Parameters:
      **cv** – a "tkinter.Canvas"

   Provides screen oriented methods like "bgcolor()" etc. that are
   described above.

class turtle.Screen                               *Screen..turtle.pyx*

   Subclass of TurtleScreen, with four methods added.

class turtle.ScrolledCanvas(master)       *ScrolledCanvas..turtle.pyx*

   Parameters:
      **master** – some Tkinter widget to contain the ScrolledCanvas,
      i.e. a Tkinter-canvas with scrollbars added

   Used by class Screen, which thus automatically provides a
   ScrolledCanvas as playground for the turtles.

class turtle.Shape(type_, data)                    *Shape..turtle.pyx*

   Parameters:
      **type_** – one of the strings “polygon”, “image”, “compound”

   Data structure modeling shapes.  The pair "(type_, data)" must
   follow this specification:

   +-------------+------------------------------------------------------------+
   | _type__     | _data_                                                     |
   |=============|============================================================|
   | “polygon”   | a polygon-tuple, i.e. a tuple of pairs of coordinates      |
   +-------------+------------------------------------------------------------+
   | “image”     | an image  (in this form only used internally!)             |
   +-------------+------------------------------------------------------------+
   | “compound”  | "None" (a compound shape has to be constructed using the   |
   |             | "addcomponent()" method)                                   |
   +-------------+------------------------------------------------------------+

                                    *Shape.addcomponent()..turtle.pyx*
   addcomponent(poly, fill, outline=None)

      Parameters:
         * **poly** – a polygon, i.e. a tuple of pairs of numbers

         * **fill** – a color the _poly_ will be filled with

         * **outline** – a color for the poly’s outline (if given)

      Example:
>
         >>> poly = ((0,0),(10,-5),(0,10),(-10,-5))
         >>> s = Shape("compound")
         >>> s.addcomponent(poly, "red", "blue")
         >>> # ... add more components and then use register_shape()
<
      See Compound shapes.

class turtle.Vec2D(x, y)                           *Vec2D..turtle.pyx*

   A two-dimensional vector class, used as a helper class for
   implementing turtle graphics.  May be useful for turtle graphics
   programs too.  Derived from tuple, so a vector is a tuple!

   Provides (for _a_, _b_ vectors, _k_ number):

   * "a + b" vector addition

   * "a - b" vector subtraction

   * "a * b" inner product

   * "k * a" and "a * k" multiplication with scalar

   * "abs(a)" absolute value of a

   * "a.rotate(angle)" rotation


Explanation
===========

A turtle object draws on a screen object, and there a number of key
classes in the turtle object-oriented interface that can be used to
create them and relate them to each other.

A "Turtle" instance will automatically create a "Screen" instance if
one is not already present.

"Turtle" is a subclass of "RawTurtle", which _doesn’t_ automatically
create a drawing surface - a _canvas_ will need to be provided or
created for it. The _canvas_ can be a "tkinter.Canvas",
"ScrolledCanvas" or "TurtleScreen".

"TurtleScreen" is the basic drawing surface for a turtle. "Screen" is
a subclass of "TurtleScreen", and includes some additional methods for
managing its appearance (including size and title) and behaviour.
"TurtleScreen"’s constructor needs a "tkinter.Canvas" or a
"ScrolledCanvas" as an argument.

The functional interface for turtle graphics uses the various methods
of "Turtle" and "TurtleScreen"/"Screen". Behind the scenes, a screen
object is automatically created whenever a function derived from a
"Screen" method is called. Similarly, a turtle object is automatically
created whenever any of the functions derived from a Turtle method is
called.

To use multiple turtles on a screen, the object-oriented interface
must be used.


Help and configuration
======================


How to use help
---------------

The public methods of the Screen and Turtle classes are documented
extensively via docstrings.  So these can be used as online-help via
the Python help facilities:

* When using IDLE, tooltips show the signatures and first lines of the
  docstrings of typed in function-/method calls.

* Calling "help()" on methods or functions displays the docstrings:
>
     >>> help(Screen.bgcolor)
     Help on method bgcolor in module turtle:

     bgcolor(self, *args) unbound turtle.Screen method
         Set or return backgroundcolor of the TurtleScreen.

         Arguments (if given): a color string or three numbers
         in the range 0..colormode or a 3-tuple of such numbers.


         >>> screen.bgcolor("orange")
         >>> screen.bgcolor()
         "orange"
         >>> screen.bgcolor(0.5,0,0.5)
         >>> screen.bgcolor()
         "#800080"

     >>> help(Turtle.penup)
     Help on method penup in module turtle:

     penup(self) unbound turtle.Turtle method
         Pull the pen up -- no drawing when moving.

         Aliases: penup | pu | up

         No argument

         >>> turtle.penup()
<
* The docstrings of the functions which are derived from methods have
  a modified form:
>
     >>> help(bgcolor)
     Help on function bgcolor in module turtle:

     bgcolor(*args)
         Set or return backgroundcolor of the TurtleScreen.

         Arguments (if given): a color string or three numbers
         in the range 0..colormode or a 3-tuple of such numbers.

         Example::

           >>> bgcolor("orange")
           >>> bgcolor()
           "orange"
           >>> bgcolor(0.5,0,0.5)
           >>> bgcolor()
           "#800080"

     >>> help(penup)
     Help on function penup in module turtle:

     penup()
         Pull the pen up -- no drawing when moving.

         Aliases: penup | pu | up

         No argument

         Example:
         >>> penup()
<
These modified docstrings are created automatically together with the
function definitions that are derived from the methods at import time.


Translation of docstrings into different languages
--------------------------------------------------

There is a utility to create a dictionary the keys of which are the
method names and the values of which are the docstrings of the public
methods of the classes Screen and Turtle.

                                   *write_docstringdict()..turtle.pyx*
turtle.write_docstringdict(filename='turtle_docstringdict')

   Parameters:
      **filename** – a string, used as filename

   Create and write docstring-dictionary to a Python script with the
   given filename.  This function has to be called explicitly (it is
   not used by the turtle graphics classes).  The docstring dictionary
   will be written to the Python script "_filename_.py".  It is
   intended to serve as a template for translation of the docstrings
   into different languages.

If you (or your students) want to use "turtle" with online help in
your native language, you have to translate the docstrings and save
the resulting file as e.g. "turtle_docstringdict_german.py".

If you have an appropriate entry in your "turtle.cfg" file this
dictionary will be read in at import time and will replace the
original English docstrings.

At the time of this writing there are docstring dictionaries in German
and in Italian.  (Requests please to glingl@aon.at.)


How to configure Screen and Turtles
-----------------------------------

The built-in default configuration mimics the appearance and behaviour
of the old turtle module in order to retain best possible
compatibility with it.

If you want to use a different configuration which better reflects the
features of this module or which better fits to your needs, e.g. for
use in a classroom, you can prepare a configuration file "turtle.cfg"
which will be read at import time and modify the configuration
according to its settings.

The built in configuration would correspond to the following
"turtle.cfg":
>
   width = 0.5
   height = 0.75
   leftright = None
   topbottom = None
   canvwidth = 400
   canvheight = 300
   mode = standard
   colormode = 1.0
   delay = 10
   undobuffersize = 1000
   shape = classic
   pencolor = black
   fillcolor = black
   resizemode = noresize
   visible = True
   language = english
   exampleturtle = turtle
   examplescreen = screen
   title = Python Turtle Graphics
   using_IDLE = False
<
Short explanation of selected entries:

* The first four lines correspond to the arguments of the
  "Screen.setup" method.

* Line 5 and 6 correspond to the arguments of the method
  "Screen.screensize".

* _shape_ can be any of the built-in shapes, e.g: arrow, turtle, etc.
  For more info try "help(shape)".

* If you want to use no fill color (i.e. make the turtle transparent),
  you have to write "fillcolor = """ (but all nonempty strings must
  not have quotes in the cfg file).

* If you want to reflect the turtle its state, you have to use
  "resizemode = auto".

* If you set e.g. "language = italian" the docstringdict
  "turtle_docstringdict_italian.py" will be loaded at import time (if
  present on the import path, e.g. in the same directory as "turtle").

* The entries _exampleturtle_ and _examplescreen_ define the names of
  these objects as they occur in the docstrings.  The transformation
  of method-docstrings to function-docstrings will delete these names
  from the docstrings.

* _using_IDLE_: Set this to "True" if you regularly work with IDLE and
  its "-n" switch (“no subprocess”).  This will prevent
  "exitonclick()" to enter the mainloop.

There can be a "turtle.cfg" file in the directory where "turtle" is
stored and an additional one in the current working directory.  The
latter will override the settings of the first one.

The "Lib/turtledemo" directory contains a "turtle.cfg" file.  You can
study it as an example and see its effects when running the demos
(preferably not from within the demo-viewer).


"turtledemo" — Demo scripts
===========================

The "turtledemo" package includes a set of demo scripts.  These
scripts can be run and viewed using the supplied demo viewer as
follows:
>
   python -m turtledemo
<
Alternatively, you can run the demo scripts individually.  For
example,
>
   python -m turtledemo.bytedesign
<
The "turtledemo" package directory contains:

* A demo viewer "__main__.py" which can be used to view the sourcecode
  of the scripts and run them at the same time.

* Multiple scripts demonstrating different features of the "turtle"
  module.  Examples can be accessed via the Examples menu.  They can
  also be run standalone.

* A "turtle.cfg" file which serves as an example of how to write and
  use such files.

The demo scripts are:

+------------------+--------------------------------+-------------------------+
| Name             | Description                    | Features                |
|==================|================================|=========================|
| bytedesign       | complex classical turtle       | "tracer()", delay,      |
|                  | graphics pattern               | "update()"              |
+------------------+--------------------------------+-------------------------+
| chaos            | graphs Verhulst dynamics,      | world coordinates       |
|                  | shows that computer’s          |                         |
|                  | computations can generate      |                         |
|                  | results sometimes against the  |                         |
|                  | common sense expectations      |                         |
+------------------+--------------------------------+-------------------------+
| clock            | analog clock showing time of   | turtles as clock’s      |
|                  | your computer                  | hands, ontimer          |
+------------------+--------------------------------+-------------------------+
| colormixer       | experiment with r, g, b        | "ondrag()"              |
+------------------+--------------------------------+-------------------------+
| forest           | 3 breadth-first trees          | randomization           |
+------------------+--------------------------------+-------------------------+
| fractalcurves    | Hilbert & Koch curves          | recursion               |
+------------------+--------------------------------+-------------------------+
| lindenmayer      | ethnomathematics (indian       | L-System                |
|                  | kolams)                        |                         |
+------------------+--------------------------------+-------------------------+
| minimal_hanoi    | Towers of Hanoi                | Rectangular Turtles as  |
|                  |                                | Hanoi discs (shape,     |
|                  |                                | shapesize)              |
+------------------+--------------------------------+-------------------------+
| nim              | play the classical nim game    | turtles as nimsticks,   |
|                  | with three heaps of sticks     | event driven (mouse,    |
|                  | against the computer.          | keyboard)               |
+------------------+--------------------------------+-------------------------+
| paint            | super minimalistic drawing     | "onclick()"             |
|                  | program                        |                         |
+------------------+--------------------------------+-------------------------+
| peace            | elementary                     | turtle: appearance and  |
|                  |                                | animation               |
+------------------+--------------------------------+-------------------------+
| penrose          | aperiodic tiling with kites    | "stamp()"               |
|                  | and darts                      |                         |
+------------------+--------------------------------+-------------------------+
| planet_and_moon  | simulation of gravitational    | compound shapes,        |
|                  | system                         | "Vec2D"                 |
+------------------+--------------------------------+-------------------------+
| rosette          | a pattern from the wikipedia   | "clone()", "undo()"     |
|                  | article on turtle graphics     |                         |
+------------------+--------------------------------+-------------------------+
| round_dance      | dancing turtles rotating       | compound shapes, clone  |
|                  | pairwise in opposite direction | shapesize, tilt,        |
|                  |                                | get_shapepoly, update   |
+------------------+--------------------------------+-------------------------+
| sorting_animate  | visual demonstration of        | simple alignment,       |
|                  | different sorting methods      | randomization           |
+------------------+--------------------------------+-------------------------+
| tree             | a (graphical) breadth first    | "clone()"               |
|                  | tree (using generators)        |                         |
+------------------+--------------------------------+-------------------------+
| two_canvases     | simple design                  | turtles on two canvases |
+------------------+--------------------------------+-------------------------+
| yinyang          | another elementary example     | "circle()"              |
+------------------+--------------------------------+-------------------------+

Have fun!


Changes since Python 2.6
========================

* The methods "Turtle.tracer", "Turtle.window_width" and
  "Turtle.window_height" have been eliminated. Methods with these
  names and functionality are now available only as methods of
  "Screen". The functions derived from these remain available. (In
  fact already in Python 2.6 these methods were merely duplications of
  the corresponding "TurtleScreen"/"Screen" methods.)

* The method "Turtle.fill()" has been eliminated. The behaviour of
  "begin_fill()" and "end_fill()" have changed slightly: now every
  filling process must be completed with an "end_fill()" call.

* A method "Turtle.filling" has been added. It returns a boolean
  value: "True" if a filling process is under way, "False" otherwise.
  This behaviour corresponds to a "fill()" call without arguments in
  Python 2.6.


Changes since Python 3.0
========================

* The "Turtle" methods "shearfactor()", "shapetransform()" and
  "get_shapepoly()" have been added. Thus the full range of regular
  linear transforms is now available for transforming turtle shapes.
  "tiltangle()" has been enhanced in functionality: it now can be used
  to get or set the tilt angle.

* The "Screen" method "onkeypress()" has been added as a complement to
  "onkey()". As the latter binds actions to the key release event, an
  alias: "onkeyrelease()" was also added for it.

* The method "Screen.mainloop" has been added, so there is no longer a
  need to use the standalone "mainloop()" function when working with
  "Screen" and "Turtle" objects.

* Two input methods have been added: "Screen.textinput" and
  "Screen.numinput". These pop up input dialogs and return strings and
  numbers respectively.

* Two example scripts "tdemo_nim.py" and "tdemo_round_dance.py" have
  been added to the "Lib/turtledemo" directory.

vim:tw=78:ts=8:ft=help:norl: