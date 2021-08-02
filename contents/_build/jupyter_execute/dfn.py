#!/usr/bin/env python
# coding: utf-8

# # Direct Functions (dfn)
# 
# > Programming is a skill best acquired by practice and example rather than from books.
# 
# Alan Turing

# Until now, we've mainly used APL as a toolkit for array manipulation using its built-in primitives. Sure, it goes a long way, but to fully take advantage of it, we also need to be able to create our own functions and operators. Fortunately, the syntax -- if we can even call it that -- for user-defined functions, is super-simple. As someone said on the APL Orchard chatroom, all you need to do is "slap curly braces around your code, and you're done". It's not _quite_ that simple, but not far from it.
# 
# The definition of a _dfn_ (direct function) is enclosed in a pair of curly braces. It's what's known as an anonymous function, or a lambda, in other languages, meaning that there is no syntactic sugar for naming a function beyond ordinary assignment using _gets_, `←`:
# 
# ```apl
# name ← { 
#    ⍝ expressions
# }
# ```
# 
# First a bit of necessary admin: if a dfn fits entirely on a single line, you can type it out directly in the RIDE IDE. So far, so expected. If your dfn extends across multiple lines, you can't (at the time of writing) just type it in. Yes, this is indeed incomprehensible. Instead, in order to enter such a function, you need to enter:
# 
#     )ed name
#    
# if you want to create a function called `name`. RIDE will open its function editor and let you enter your code there. Once you want to test your function, you first need to save it, which in APL-speak is called "to fix your function". The default way (and you're unlikely to ever discover this by yourself) to fix (save) your function is to hit "escape". Yes, really. UX is sacrified on the altar of tradition. Fortunately -- and I recommend you do so right now -- RIDE allows you to re-bind keystrokes by hitting the little keyboard symbol in the top-right corner.
# 
# Locate the row that says "Fix the current function" and map that to the key combo that is save on your platform. And whilst you're there, make a note of the keys binding to "Forward" and "Backward" -- they default to ctrl-shift-enter and ctrl-shift-backspace. In the REPL, these mean forward/back in the history of executed lines, like the arrow keys in the shell. The arrow keys instead moves up and down spatially, in the _output_, which to me is incomprehensible, unnatural, not matching any other language's REPL behaviour, and irritating even after having used RIDE for a long time now. However, seasoned Dyalogers claim that this behaviour _is_ useful (even if I can't see it). You might also want to rebind "Strong interrupt" to ctrl-c while you're at it.
# 
# The other thing to note is that in RIDE there is no visual cue that an editor window contains unsaved changes. This is sure to bite you sooner or later.
# 
# In a Jupyter notebook, like here, the situation is actually a bit better. The only quirk is that in order to enter a multi-line dfn, you need to start the cell with `]dinput`:

# In[1]:


]dinput
MyFirstFunction ← {
    ⍝ Add left and right
    ⍺+⍵
}


# In[ ]:




