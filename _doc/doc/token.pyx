*token.pyx*                                   Last change: 2023 Sep 15

"token" — Constants used with Python parse trees
************************************************

**Source code:** Lib/token.py

======================================================================

This module provides constants which represent the numeric values of
leaf nodes of the parse tree (terminal tokens).  Refer to the file
"Grammar/Tokens" in the Python distribution for the definitions of the
names in the context of the language grammar.  The specific numeric
values which the names map to may change between Python versions.

The module also provides a mapping from numeric codes to names and
some functions.  The functions mirror definitions in the Python C
header files.

token.tok_name                                   *tok_name..token.pyx*

   Dictionary mapping the numeric values of the constants defined in
   this module back to name strings, allowing more human-readable
   representation of parse trees to be generated.

token.ISTERMINAL(x)                          *ISTERMINAL()..token.pyx*

   Return "True" for terminal token values.

token.ISNONTERMINAL(x)                    *ISNONTERMINAL()..token.pyx*

   Return "True" for non-terminal token values.

token.ISEOF(x)                                    *ISEOF()..token.pyx*

   Return "True" if _x_ is the marker indicating the end of input.

The token constants are:

token.ENDMARKER                                 *ENDMARKER..token.pyx*

token.NAME                                           *NAME..token.pyx*

token.NUMBER                                       *NUMBER..token.pyx*

token.STRING                                       *STRING..token.pyx*

token.NEWLINE                                     *NEWLINE..token.pyx*

token.INDENT                                       *INDENT..token.pyx*

token.DEDENT                                       *DEDENT..token.pyx*

token.LPAR                                           *LPAR..token.pyx*

   Token value for ""("".

token.RPAR                                           *RPAR..token.pyx*

   Token value for "")"".

token.LSQB                                           *LSQB..token.pyx*

   Token value for ""["".

token.RSQB                                           *RSQB..token.pyx*

   Token value for ""]"".

token.COLON                                         *COLON..token.pyx*

   Token value for "":"".

token.COMMA                                         *COMMA..token.pyx*

   Token value for "","".

token.SEMI                                           *SEMI..token.pyx*

   Token value for "";"".

token.PLUS                                           *PLUS..token.pyx*

   Token value for ""+"".

token.MINUS                                         *MINUS..token.pyx*

   Token value for ""-"".

token.STAR                                           *STAR..token.pyx*

   Token value for ""*"".

token.SLASH                                         *SLASH..token.pyx*

   Token value for ""/"".

token.VBAR                                           *VBAR..token.pyx*

   Token value for ""|"".

token.AMPER                                         *AMPER..token.pyx*

   Token value for ""&"".

token.LESS                                           *LESS..token.pyx*

   Token value for ""<"".

token.GREATER                                     *GREATER..token.pyx*

   Token value for "">"".

token.EQUAL                                         *EQUAL..token.pyx*

   Token value for ""="".

token.DOT                                             *DOT..token.pyx*

   Token value for ""."".

token.PERCENT                                     *PERCENT..token.pyx*

   Token value for ""%"".

token.LBRACE                                       *LBRACE..token.pyx*

   Token value for ""{"".

token.RBRACE                                       *RBRACE..token.pyx*

   Token value for ""}"".

token.EQEQUAL                                     *EQEQUAL..token.pyx*

   Token value for ""=="".

token.NOTEQUAL                                   *NOTEQUAL..token.pyx*

   Token value for ""!="".

token.LESSEQUAL                                 *LESSEQUAL..token.pyx*

   Token value for ""<="".

token.GREATEREQUAL                           *GREATEREQUAL..token.pyx*

   Token value for "">="".

token.TILDE                                         *TILDE..token.pyx*

   Token value for ""~"".

token.CIRCUMFLEX                               *CIRCUMFLEX..token.pyx*

   Token value for ""^"".

token.LEFTSHIFT                                 *LEFTSHIFT..token.pyx*

   Token value for ""<<"".

token.RIGHTSHIFT                               *RIGHTSHIFT..token.pyx*

   Token value for "">>"".

token.DOUBLESTAR                               *DOUBLESTAR..token.pyx*

   Token value for ""**"".

token.PLUSEQUAL                                 *PLUSEQUAL..token.pyx*

   Token value for ""+="".

token.MINEQUAL                                   *MINEQUAL..token.pyx*

   Token value for ""-="".

token.STAREQUAL                                 *STAREQUAL..token.pyx*

   Token value for ""*="".

token.SLASHEQUAL                               *SLASHEQUAL..token.pyx*

   Token value for ""/="".

token.PERCENTEQUAL                           *PERCENTEQUAL..token.pyx*

   Token value for ""%="".

token.AMPEREQUAL                               *AMPEREQUAL..token.pyx*

   Token value for ""&="".

token.VBAREQUAL                                 *VBAREQUAL..token.pyx*

   Token value for ""|="".

token.CIRCUMFLEXEQUAL                     *CIRCUMFLEXEQUAL..token.pyx*

   Token value for ""^="".

token.LEFTSHIFTEQUAL                       *LEFTSHIFTEQUAL..token.pyx*

   Token value for ""<<="".

token.RIGHTSHIFTEQUAL                     *RIGHTSHIFTEQUAL..token.pyx*

   Token value for "">>="".

token.DOUBLESTAREQUAL                     *DOUBLESTAREQUAL..token.pyx*

   Token value for ""**="".

token.DOUBLESLASH                             *DOUBLESLASH..token.pyx*

   Token value for ""//"".

token.DOUBLESLASHEQUAL                   *DOUBLESLASHEQUAL..token.pyx*

   Token value for ""//="".

token.AT                                               *AT..token.pyx*

   Token value for ""@"".

token.ATEQUAL                                     *ATEQUAL..token.pyx*

   Token value for ""@="".

token.RARROW                                       *RARROW..token.pyx*

   Token value for ""->"".

token.ELLIPSIS                                   *ELLIPSIS..token.pyx*

   Token value for ""..."".

token.COLONEQUAL                               *COLONEQUAL..token.pyx*

   Token value for "":="".

token.EXCLAMATION                             *EXCLAMATION..token.pyx*

   Token value for ""!"".

token.OP                                               *OP..token.pyx*

token.TYPE_IGNORE                             *TYPE_IGNORE..token.pyx*

token.TYPE_COMMENT                           *TYPE_COMMENT..token.pyx*

token.SOFT_KEYWORD                           *SOFT_KEYWORD..token.pyx*

token.FSTRING_START                         *FSTRING_START..token.pyx*

token.FSTRING_MIDDLE                       *FSTRING_MIDDLE..token.pyx*

token.FSTRING_END                             *FSTRING_END..token.pyx*

token.COMMENT                                     *COMMENT..token.pyx*

token.NL                                               *NL..token.pyx*

token.ERRORTOKEN                               *ERRORTOKEN..token.pyx*

token.N_TOKENS                                   *N_TOKENS..token.pyx*

token.NT_OFFSET                                 *NT_OFFSET..token.pyx*

The following token type values aren’t used by the C tokenizer but are
needed for the "tokenize" module.

token.COMMENT

   Token value used to indicate a comment.

token.NL

   Token value used to indicate a non-terminating newline.  The
   "NEWLINE" token indicates the end of a logical line of Python code;
   "NL" tokens are generated when a logical line of code is continued
   over multiple physical lines.

token.ENCODING                                   *ENCODING..token.pyx*

   Token value that indicates the encoding used to decode the source
   bytes into text. The first token returned by "tokenize.tokenize()"
   will always be an "ENCODING" token.

token.TYPE_COMMENT

   Token value indicating that a type comment was recognized.  Such
   tokens are only produced when "ast.parse()" is invoked with
   "type_comments=True".

Changed in version 3.5: Added "AWAIT" and "ASYNC" tokens.

Changed in version 3.7: Added "COMMENT", "NL" and "ENCODING" tokens.

Changed in version 3.7: Removed "AWAIT" and "ASYNC" tokens. “async”
and “await” are now tokenized as "NAME" tokens.

Changed in version 3.8: Added "TYPE_COMMENT", "TYPE_IGNORE",
"COLONEQUAL". Added "AWAIT" and "ASYNC" tokens back (they’re needed to
support parsing older Python versions for "ast.parse()" with
"feature_version" set to 6 or lower).

Changed in version 3.13: Removed "AWAIT" and "ASYNC" tokens again.

vim:tw=78:ts=8:ft=help:norl: