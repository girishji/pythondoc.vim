*tkinter.dnd.pyx*                             Last change: 2023 Sep 15

"tkinter.dnd" — Drag and drop support
*************************************

**Source code:** Lib/tkinter/dnd.py

======================================================================

Note:

  This is experimental and due to be deprecated when it is replaced
  with the Tk DND.

The "tkinter.dnd" module provides drag-and-drop support for objects
within a single application, within the same window or between
windows. To enable an object to be dragged, you must create an event
binding for it that starts the drag-and-drop process. Typically, you
bind a ButtonPress event to a callback function that you write (see
Bindings and Events). The function should call "dnd_start()", where
‘source’ is the object to be dragged, and ‘event’ is the event that
invoked the call (the argument to your callback function).

Selection of a target object occurs as follows:

1. Top-down search of area under mouse for target widget

   * Target widget should have a callable _dnd_accept_ attribute

   * If _dnd_accept_ is not present or returns None, search moves to
     parent widget

   * If no target widget is found, then the target object is None

2. Call to _<old_target>.dnd_leave(source, event)_

3. Call to _<new_target>.dnd_enter(source, event)_

4. Call to _<target>.dnd_commit(source, event)_ to notify of drop

5. Call to _<source>.dnd_end(target, event)_ to signal end of drag-
   and-drop

                                         *DndHandler..tkinter.dnd.pyx*
class tkinter.dnd.DndHandler(source, event)

   The _DndHandler_ class handles drag-and-drop events tracking Motion
   and ButtonRelease events on the root of the event widget.

   cancel(event=None)              *DndHandler.cancel()..tkinter.dnd.pyx*

      Cancel the drag-and-drop process.

   finish(event, commit=0)         *DndHandler.finish()..tkinter.dnd.pyx*

      Execute end of drag-and-drop functions.

   on_motion(event)             *DndHandler.on_motion()..tkinter.dnd.pyx*

      Inspect area below mouse for target objects while drag is
      performed.

   on_release(event)           *DndHandler.on_release()..tkinter.dnd.pyx*

      Signal end of drag when the release pattern is triggered.

tkinter.dnd.dnd_start(source, event)    *dnd_start()..tkinter.dnd.pyx*

   Factory function for drag-and-drop process.

See also: Bindings and Events

vim:tw=78:ts=8:ft=help:norl: