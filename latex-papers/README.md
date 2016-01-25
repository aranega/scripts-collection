# The Latex Scientific Papers Initialization Struggle

Writing scientific papers for a journal/conference with Latex is really a
blessing. You already have the template you need to use and everything is fine.

But it is usually a 11 steps process:

1. First you have to find zip file. For an obscure reason, each time I try
to find one, this is a kind of seek and hide game where I'm not able to find the
good link (I'm probably pretty bad).
1. Download it in your `tmp` folder (in my case) or as almost everybody
does, on your desktop and forget about it.
1. Unzip it (most part of the time it is zip format), put all the files in your
paper folder you forgot to create.
1. See that the zip file was poorly built and that there is no root folder and
delete the unzipped files.
1. Create your paper folder.
1. Copy one of your previous `main.tex` template of one of your previous template
or create an empty one (for braves only).
1. See that you forgot about how the zip was name and/or you deleted it with the
other files.
1. Re-download it and search it on your FS/Desktop.
1. Unzip all the mess in your project.
1. Copy one of your previous Makefile or facilities to deal with the latex
compilation.
1. Promise to yourself that the next time you will write a script to do this stuff.

And the next time... re-do all the steps because your forgot about writing your
script.

Also, when you have to deal with images... stuffs can be hard and conversions
to perform very cumbersome.

For all these reasons, I finally create a dirty script that do the work for me.
As I'm pretty sure I'm not the only one out there struggling with paper
initialization each time I have to write one, I decided to release it.

This script had been successfully tested on GNU Linux, but should work on other
UNIX (I wrote should guys).  

## Project Hierarchy

    +- templates/          this folder contains the files copied during paper init
    | +- Makefile          the used Makefile
    | +- template.tex      the used template (you can adapt it)
    + paper-init.bash      the init script


## Installation

This is craft you have there so no fancy stuffs, just clone the repository and
make the `paper-init.bash` script executable.

    $ git clone https://github.com/aranega/scripts-collection.git
    $ chmod u+x latex-papers/paper-init.bash

If you want to move the script/templates folder in another location, do what you
want, but do no forget about modifying the `TEMPLATESPATH` variable so it points
to the new `template.tex, Makefile` location.

If you want to change the template directory name, edit the script and change
the `TEMPLATEDIR` variable so it has the new directory name.


## Dependencies and Image Requirements

The `Makefile` depends on three tools:

* __latexmk__ for latex compilation chain
* __Inkscape__ for SVG conversion to EPS (nicer result than ImageMagick)
* __ImageMagick__ for PNG conversion to EPS

All images should be placed in the `imgs` directory in SVG or PNG format. The
`Makefile` performs the format transformation to EPS format on its own.


## Init Papers

    $ pwd
    /home/vince/
    $ paper-init.bash MYPAPERNAME   <-- here is the call
    $ ls MYPAPERNAME
    Makefile  imgs  styles  MYPAPERNAME.bib  MYPAPERNAME.tex

This will create a new project folder name `MYPAPERNAME` in `/home/vince`. Ok that's
nice, but a little bit more would be great.

    $ paper-init.bash -s lncs MYPAPER

This command will download and unzip for you the `lncs` style in your project. At
the moment, the only styles known are lncs, elsevier, acm, ieee (you can add more).

    $ paper-init.bash -d /tmp -s lncs MYPAPER

This command will do the same as the previous one but it also will create your
project in the `/tmp` directory.

    $ paper-init.bash -c -s ieee -d /tmp MYPAPER

This command will clean your current style and change it to the `ieee` one. If
you are not in the folder that contains your project, you have to use the `-d`
option.

    $ paper-init.bash -u "http://www.domain.com/tomystyle.zip" MYPAPER

This command will create a new MYPAPER project using the templates located at the
given url. If there is many urls, you can use this syntax:

    $ paper-init.bash -u "url1 url2 ... urln" MYPAPER

## Compile a Paper

Build the paper:

    $ make

Clean the paper tmp files and the produced PDF:

    $ make clean
