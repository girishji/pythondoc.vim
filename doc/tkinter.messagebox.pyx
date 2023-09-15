*tkinter.messagebox.pyx*                      Last change: 2023 Sep 15

"tkinter.messagebox" — Tkinter message prompts
**********************************************

**Source code:** Lib/tkinter/messagebox.py

======================================================================

The "tkinter.messagebox" module provides a template base class as well
as a variety of convenience methods for commonly used configurations.
The message boxes are modal and will return a subset of (True, False,
OK, None, Yes, No) based on the user’s selection. Common message box
styles and layouts include but are not limited to:

   [image]

                                     *Message..tkinter.messagebox.pyx*
class tkinter.messagebox.Message(master=None, **options)

   Create a default information message box.

**Information message box**

                                  *showinfo()..tkinter.messagebox.pyx*
tkinter.messagebox.showinfo(title=None, message=None, **options)

**Warning message boxes**

                               *showwarning()..tkinter.messagebox.pyx*
tkinter.messagebox.showwarning(title=None, message=None, **options)

                                 *showerror()..tkinter.messagebox.pyx*
tkinter.messagebox.showerror(title=None, message=None, **options)

**Question message boxes**

                               *askquestion()..tkinter.messagebox.pyx*
tkinter.messagebox.askquestion(title=None, message=None, **options)

                               *askokcancel()..tkinter.messagebox.pyx*
tkinter.messagebox.askokcancel(title=None, message=None, **options)

                            *askretrycancel()..tkinter.messagebox.pyx*
tkinter.messagebox.askretrycancel(title=None, message=None, **options)

                                  *askyesno()..tkinter.messagebox.pyx*
tkinter.messagebox.askyesno(title=None, message=None, **options)

                            *askyesnocancel()..tkinter.messagebox.pyx*
tkinter.messagebox.askyesnocancel(title=None, message=None, **options)

vim:tw=78:ts=8:ft=help:norl: