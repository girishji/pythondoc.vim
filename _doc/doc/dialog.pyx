*dialog.pyx*                                  Last change: 2023 Sep 15

Tkinter Dialogs
***************


"tkinter.simpledialog" — Standard Tkinter input dialogs
=======================================================

**Source code:** Lib/tkinter/simpledialog.py

======================================================================

The "tkinter.simpledialog" module contains convenience classes and
functions for creating simple modal dialogs to get a value from the
user.

                                              *askfloat()..dialog.pyx*
tkinter.simpledialog.askfloat(title, prompt, **kw)

                                            *askinteger()..dialog.pyx*
tkinter.simpledialog.askinteger(title, prompt, **kw)

                                             *askstring()..dialog.pyx*
tkinter.simpledialog.askstring(title, prompt, **kw)

   The above three functions provide dialogs that prompt the user to
   enter a value of the desired type.

                                                  *Dialog..dialog.pyx*
class tkinter.simpledialog.Dialog(parent, title=None)

   The base class for custom dialogs.

      body(master)                               *Dialog.body()..dialog.pyx*

         Override to construct the dialog’s interface and return the
         widget that should have initial focus.

      buttonbox()                           *Dialog.buttonbox()..dialog.pyx*

         Default behaviour adds OK and Cancel buttons. Override for
         custom button layouts.


"tkinter.filedialog" — File selection dialogs
=============================================

**Source code:** Lib/tkinter/filedialog.py

======================================================================

The "tkinter.filedialog" module provides classes and factory functions
for creating file/directory selection windows.


Native Load/Save Dialogs
------------------------

The following classes and functions provide file dialog windows that
combine a native look-and-feel with configuration options to customize
behaviour. The following keyword arguments are applicable to the
classes and functions listed below:

      _parent_ - the window to place the dialog on top of

      _title_ - the title of the window

      _initialdir_ - the directory that the dialog starts in

      _initialfile_ - the file selected upon opening of the dialog

      _filetypes_ - a sequence of (label, pattern) tuples, ‘*’ wildcard is allowed

      _defaultextension_ - default extension to append to file (save dialogs)

      _multiple_ - when true, selection of multiple items is allowed

**Static factory functions**

The below functions when called create a modal, native look-and-feel
dialog, wait for the user’s selection, then return the selected
value(s) or "None" to the caller.

                                           *askopenfile()..dialog.pyx*
tkinter.filedialog.askopenfile(mode='r', **options)

                                          *askopenfiles()..dialog.pyx*
tkinter.filedialog.askopenfiles(mode='r', **options)

   The above two functions create an "Open" dialog and return the
   opened file object(s) in read-only mode.

                                         *asksaveasfile()..dialog.pyx*
tkinter.filedialog.asksaveasfile(mode='w', **options)

   Create a "SaveAs" dialog and return a file object opened in write-
   only mode.

                                       *askopenfilename()..dialog.pyx*
tkinter.filedialog.askopenfilename(**options)

                                      *askopenfilenames()..dialog.pyx*
tkinter.filedialog.askopenfilenames(**options)

   The above two functions create an "Open" dialog and return the
   selected filename(s) that correspond to existing file(s).

                                     *asksaveasfilename()..dialog.pyx*
tkinter.filedialog.asksaveasfilename(**options)

   Create a "SaveAs" dialog and return the selected filename.

                                          *askdirectory()..dialog.pyx*
tkinter.filedialog.askdirectory(**options)

      Prompt user to select a directory.
      Additional keyword option:
         _mustexist_ - determines if selection must be an existing directory.

                                                    *Open..dialog.pyx*
class tkinter.filedialog.Open(master=None, **options)

                                                  *SaveAs..dialog.pyx*
class tkinter.filedialog.SaveAs(master=None, **options)

   The above two classes provide native dialog windows for saving and
   loading files.

**Convenience classes**

The below classes are used for creating file/directory windows from
scratch. These do not emulate the native look-and-feel of the
platform.

                                               *Directory..dialog.pyx*
class tkinter.filedialog.Directory(master=None, **options)

   Create a dialog prompting the user to select a directory.

Note:

  The _FileDialog_ class should be subclassed for custom event
  handling and behaviour.

                                              *FileDialog..dialog.pyx*
class tkinter.filedialog.FileDialog(master, title=None)

   Create a basic file selection dialog.

   cancel_command(event=None)   *FileDialog.cancel_command()..dialog.pyx*

      Trigger the termination of the dialog window.

                          *FileDialog.dirs_double_event()..dialog.pyx*
   dirs_double_event(event)

      Event handler for double-click event on directory.

                          *FileDialog.dirs_select_event()..dialog.pyx*
   dirs_select_event(event)

      Event handler for click event on directory.

                         *FileDialog.files_double_event()..dialog.pyx*
   files_double_event(event)

      Event handler for double-click event on file.

                         *FileDialog.files_select_event()..dialog.pyx*
   files_select_event(event)

      Event handler for single-click event on file.

   filter_command(event=None)   *FileDialog.filter_command()..dialog.pyx*

      Filter the files by directory.

   get_filter()                     *FileDialog.get_filter()..dialog.pyx*

      Retrieve the file filter currently in use.

   get_selection()               *FileDialog.get_selection()..dialog.pyx*

      Retrieve the currently selected item.

                                         *FileDialog.go()..dialog.pyx*
   go(dir_or_file=os.curdir, pattern='*', default='', key=None)

      Render dialog and start event loop.

   ok_event(event)                    *FileDialog.ok_event()..dialog.pyx*

      Exit dialog returning current selection.

   quit(how=None)                         *FileDialog.quit()..dialog.pyx*

      Exit dialog returning filename, if any.

   set_filter(dir, pat)             *FileDialog.set_filter()..dialog.pyx*

      Set the file filter.

   set_selection(file)           *FileDialog.set_selection()..dialog.pyx*

      Update the current file selection to _file_.

                                          *LoadFileDialog..dialog.pyx*
class tkinter.filedialog.LoadFileDialog(master, title=None)

   A subclass of FileDialog that creates a dialog window for selecting
   an existing file.

   ok_command()                 *LoadFileDialog.ok_command()..dialog.pyx*

      Test that a file is provided and that the selection indicates an
      already existing file.

                                          *SaveFileDialog..dialog.pyx*
class tkinter.filedialog.SaveFileDialog(master, title=None)

   A subclass of FileDialog that creates a dialog window for selecting
   a destination file.

   ok_command()                 *SaveFileDialog.ok_command()..dialog.pyx*

      Test whether or not the selection points to a valid file that is
      not a directory. Confirmation is required if an already existing
      file is selected.


"tkinter.commondialog" — Dialog window templates
================================================

**Source code:** Lib/tkinter/commondialog.py

======================================================================

The "tkinter.commondialog" module provides the "Dialog" class that is
the base class for dialogs defined in other supporting modules.

class tkinter.commondialog.Dialog(master=None, **options)

   show(color=None, **options)                *Dialog.show()..dialog.pyx*

      Render the Dialog window.

See also: Modules "tkinter.messagebox", Reading and Writing Files

vim:tw=78:ts=8:ft=help:norl: