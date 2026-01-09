.chap Producing Documentation

The purpose of this document is twofold: to provide an overview of the
Open Watcom documentation system togehter with the steps necessary for
editing and producing online or printed documents, and at the same time
serve as an example of the documentation system usage.
.np
It is useful to note that the online documentation is almost, but not quite,
independent of the rest of the Open Watcom compilers and tools. One
important exception is online help files for Open Watcom GUI tools. Formatting
online documentation generates include files containing symbolic constants
designating help entries. These are used during building of the tools
binaries. If the binaries are not built with the right header files, the
online help will be out of sync and not all that helpful.
.np
There's one other link going in the other direction: certain documentation
files live with their respective projects and not in the documents tree.
This is especially true for error message documentation for the compilers
and tools.


.section Setting up
.*
.np
.ix 'setting up'
.ix 'installation'
Any supported host system can be used to produce most of the documentation.
A Win32 system is needed for producing Windows help files in the WinHlp32
and CHM format (unless you can run the required help compilers on your host
platform).
.np
A tool for converting PostScript files to PDF is required to produce PDF
documentation. GhostScript has been found to work well for this purpose.
.np
The required environment setup is taken care of by running appropriately
modified
.id setvars.cmd/setvars.bat/setvars.sh.
.np
Note that to produce Win32 online documentation, you will need the appropriate
help compilers (usually hcrtf and hcw).


.section Building PostScript Documentation
.*
.ix 'PostScript'
.np
Here are the steps to formatting a book for printing on a PostScript
printer.
.millust begin
cd %OWROOT%\docs\ps
wmake hbook=<bn>
.millust end
.np
where
.id <bn>
is one of
.millust begin
devguide    Developer's Guide (this document)
c_readme    C/C++ Read Me First
cguide      C/C++ User's Guide
cguideq     C/C++ User's Guide for QNX
clib        C Library Reference (for all systems except QNX)
clibqnx     C Library Reference for QNX (stale)
cpplib      C++ Class Library Reference
ctools      C/C++ Tools User's Guide
cw          CauseWay User's Guide
f77graph    F77 Graphics Library Reference
f_readme    F77 Read Me First
fpguide     F77 Programmer's Guide
ftools      F77 Tools User's Guide
fuguide     F77 User's Guide
guitool     Graphical Tools User's Guide
ide         IDE User's Guide
lguide      Linker User's Guide
pguide      C/C++ Programmer's Guide
wd          Debugger User's Guide
.millust end
.np
The output file is of type
.id .ps.
You should be able to send this file to any PostScript printer or view
it in GhostScript or convert it to PDF or do whatever it is you do with
PostScript files.

.*
.section Building Online Help Documentation
.*
.np
For Microsoft Help format (old Windows 3.x help format):
.begbull
.bull
Switch to the appropriate directory:
.millust begin
cd %OWROOT%\docs\win
.millust end
.bull
Run
.id wmake
to create all online help.
.bull
Note that the requisite help processing tools (whpcvt, whc) must be built
first.
.endbull
.np
For Microsoft Help format ("new" Windows NT/95 help format):
.begbull
.bull
Switch to the appropriate directory:
.millust begin
cd %OWROOT%\docs\nt
.millust end
.bull
Run
.id wmake
to create all online help.
.bull
Note that you must have the Microsoft Help Compiler (hcrtf) installed
and the whcpvt tool must be built first.
.endbull
.np
For Watcom Help format (for the WHELP command):
.begbull
.bull
Switch to the appropriate directory:
.millust begin
cd %OWROOT%\docs\dos
.millust end
.bull
Run
.id wmake
to create all online help.
.bull
Note that the requisite help processing tools (whpcvt, hcdos) must be built
first.
.endbull
.np
For OS/2 Help format:
.begbull
.bull
Switch to the appropriate directory:
.millust begin
cd %OWROOT%\docs\os2
.millust end
.bull
Run
.id wmake
to create all OS/2 online help.
.bull
The Watcom IPF Compiler (wipfc) is used for this and the OS/2
documentation no longer needs to be built on OS/2 systems.
.endbull
.np
To format one document at a time, go to the appropriate directory
(for instance
.id docs\os2
) and run wmake with argument
.id hbook=<book_name>
where
.id <book_name>
is one of the online books listed above.
.*
.section Editing the Documentation
.*
.np
All the documentation is stored in ASCII text files with the file
extension "GML". The files are annotated with a combination of Script
keywords/macros and GML (Generalized Markup Language) tags.
.np
The Script keywords and macros are of the form ".tag" (i.e., they
begin with a period
and are followed by two or more letters or digits). Script tags will
be most familiar to anyone who has ever used Waterloo Script or IBM
Script. The tagged format is also similar in idea to other tagged
formatting systems like RUNOFF or ROFF.
.np
The GML tags are of the form ":TAG." (i.e., they begin with a colon,
followed by some letters and digits and end with a period). GML tags
will be most familiar to anyone who has ever used IBM GML or Waterloo
GML. This tag set is a variant of SGML. The most familiar SGML tag
format is
.id <TAG>.
In Watcom GML, the "<" and ">" are replaced by the
":" and ".". If you know HTML, you know how tags work &mdash HTML is
just another variant of SGML.
.np
The tag set includes a base set of predefined tags. In addition to
this base set, you can define an extended tag set using the built-in
macro language. The base Script keyword set employs two letters (e.g.,
.dm, .if, .se, .cp, .us). The user-defined macros can employ
two, three, four or more letters (e.g. .chapter, .section, .beglevel).
For a good example of user-defined Script macros, see
.id %OWROOT%\docs\doc\gml\fmtmacro.gml.
GML tags can also be defined. For a
good example of user-defined GML tags, see
.id %OWROOT%\docs\doc\gml\cppextra.gml.
.np
These tags are described here for you, not so that you can begin defining
your own tags, but so that you will recognize them in the ASCII text
that comprises the documentation. But of course no-one's stopping you
from defining your own tags should you feel so inclined.
.np
Here's a snippet from one of the doc files.
.millust begin
    .np
    The recommended options for generating the fastest 16-bit Intel code
    are:
    .ix 'fastest 16-bit code'
    .begnote
    .note Pentium Pro
    &sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.6 &sw.fpi87 &sw.fp6
    .note Pentium
    &sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.5 &sw.fpi87 &sw.fp5
    .note 486
    &sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.4 &sw.fpi87 &sw.fp3
    .note 386
    &sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.3 &sw.fpi87 &sw.fp3
    .note 286
    &sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.2 &sw.fpi87 &sw.fp2
    .note 186
    &sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.1 &sw.fpi87
    .note 8086
    &sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.0 &sw.fpi87
    .endnote
    .np
    The recommended options for generating the fastest 32-bit Intel code
    are:
.millust end
.np
The ".np" is a user-defined macro for "start a new paragraph". The ".ix"
creates an index entry in the index. It doesn't appear with the text.
In on-line help, this index entry becomes a searchable item. The
".begnote", ".note", and ".endnote" user-defined macros are used to
create an unordered list. Every piece of text entered into the source
file is identified by macros like these.
.np
The best way to understand what the macros do is to look at a printed
copy of the document and see what it looks like. Luckily for you,
you don't have to look very far:
.np
The recommended options for generating the fastest 16-bit Intel code
are:
.ix 'fastest 16-bit code'
.begnote
.note Pentium Pro
&sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.6 &sw.fpi87 &sw.fp6
.note Pentium
&sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.5 &sw.fpi87 &sw.fp5
.note 486
&sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.4 &sw.fpi87 &sw.fp3
.note 386
&sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.3 &sw.fpi87 &sw.fp3
.note 286
&sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.2 &sw.fpi87 &sw.fp2
.note 186
&sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.1 &sw.fpi87
.note 8086
&sw.oneatx &sw.oh &sw.oi+ &sw.ei &sw.zp8 &sw.0 &sw.fpi87
.endnote
.np
The recommended options for generating the fastest 32-bit Intel code
are:
.np
The WATCOM GML program (WGML) is a compiler/interpreter that reads the
document's source files to produce an output file. In our case, we
want PostScript for printing and we want another form for generation
of online help. This second form is a non-printable form that is
suitable for post-processing to turn it into IPF for the OS/2 IPF
compiler, RTF for the WinHelp tools, special Watcom-defined format
for use with a DOS-based help tool (WHELP) or the ever-popular HTML.
.np
If you are a programmer, and that is likely, you'll be somewhat comfortable
with the whole process of turning ASCII text into documentation. WGML is
a text processor (compiler) that reads a source file (GML) which, in turn,
imbeds other source files, and produces an output file (the object
file). WGML is very fast. It was very fast in the old 20MHz 386 days
and is, of course, much faster with today's processors. The C Library
Reference comprising 1,241 pages takes one minute to format into
PostScript on a 600 MHz Pentium-III.
.np
If you ever used TeX or LaTeX you will be comfortable with the
concept of nonvisual content-driven formatting. If you only know
so-called WYSIWYG word processors heavily relying on visual
formatting, you might be surprised to find that it is possible to
let the computer do lot of the hard work. Just give up the idea
of controlling every pixel &mdash it never works right anyway. Instead
of saying "this is Arial 10pt Bold" you will say "this is a keyword"
or "this is a code example" and let the machine worry about
formatting.
.*
.section Diagnostic Messages
.*
.np
If you see
.id ***WARNING***
messages issued by WGML, you can ignore them. Of course it is better
if you don't and correct whatever is causing the warnings.
If you see
.id ***ERROR***
messages, you cannot ignore them and have to fix them before any
output is produced.
