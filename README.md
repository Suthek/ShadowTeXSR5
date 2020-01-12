# ShadowTeXSR5
## Installation
 What you need: 
  - A XeTeX compiler. Most LaTeX environments like [MikTeX](https://miktex.org/) or [TeXLive](https://www.tug.org/texlive/) will have it included.
  - The ShadowTeXSR5.cls (once it exists)
  - The core folder; it contains all the static material used in the document (backgrounds etc.)
  - An image folder; you can create that yourself. It's where you store any pictures you want to include in the document. The provided folder contains some template images.
  - The index_style.mst. Rename it to <yourtexfilename>.mst.
  - A *.tex file
  
  
  ## Initiation
  
  To get your rulebook started, copy this code into your *.tex file; it'll contain all the commands needed to start.
  
  ```
\documentclass{ShadowTeXSR5}
%How you want to name your Book. The title will show up in the headers
%Or on the alternative cover page.
\title{My Rulebook}
%Main author
\author{Me}
%List of artists, if available. Can leave empty.
%\artists{Me, Myself \& I}
%Cover artist, if available. Can leave empty.
%\coverartist{Me, too}
%Text Writers, if available. Can leave empty.
%\writers{Not me}
%Filename of the image you wish to be on the cover. It'll also show as an overlay in the headers. 
%If no image is provided, the document will show an alternative (boring) cover page and not overlay anything on the headers.
\splashpicture{Splash.jpg}

\begin{document}
%You can use this to select your Language of choice. Currently only ngerman and english are supported.
\selectlanguage{english}
%This builds and prints the cover page, splash page and impressum.
\srmaketitle
%This builds the TOC.
\tableofcontents

%From here on, your content can start.



\end{document}  
```
## Colors

Pre-Defined colors are:
- whitetext
- redtext
- whitetext
- normalpage
- storyblack
- boxred
- headred
 
## Available Commands

### Setup

- `\title{}`: Title of your book.
- `\author{}`, `\writers{}`, `\artists{}`, `\coverartist{}`: Can be used to credit writers and artists who help with the book in the Impressum. 
- `\splashpicture{}`: Filename of splash picture in ./images/ folder
- `\srmaketitle`: Creates the cover, impressum and splash picture. Cover colors can be added as optional argument. (e.g. `\srmaketitle[red]`) Options: black, blue, brown, green, grey, red, yellow. Default: black


### Structure  
- `\chapter{}`, `\section{}`, `\subsection{}`, `\subsubsection{}`: as per regular LaTeX
- `\storychapter{Title}{Author}{LeftImage}{RightImage}`: Creates a black themed chapter for stories.
- `\storypar` creates a new paragraph with a red asterisk inbetween. For use within the storychapter.

### Boxes

All boxes are environments that are used with `\begin{name}` and `\end{name}`.

- `columnbox`: creates a red box in one column. The Layout changes depending on which column it's in and should dynamically do the right thing; should a box refuse to play nice, you can force it into a configuration using `\begin{columnbox}[l]` or `\begin{columnbox}[r]`.
- `twocolbox`: like `columnbox`, only the box spreads over both columns. Optional arguments apply as well.
- `blackbox`: creates a dark-themed box. With white text. Takes a title as argument.
- `examplebox`: Creates a white box used for example texts.
- `twocolexamplebox`: Like `examplebox`, but two columns.
  
### Images

- `twocolimage`: Creates a two-column image with frame. File name provided through argument.
- `columnimage`: Creates a tall image taking up one column.

### Tables

The environment `\begin{srtable}{layout}{Header}` & `\end{srtable}` creates a table to be used within a `twocolumnblackbox`. Layout describes [tabularx column-Layout](https://en.wikibooks.org/wiki/LaTeX/Tables#The_tabularx_package). The body contains all lines of the table except for the header line, which is provided through the second argument.

### Small Sections

These sections are environments as well.

- `deckercomment`: Takes one argument (`\begin{deckercomment}{author}`) and creates a block of text for the comments of deckers to your texts.
- `spell`: Takes two arguments (`\begin{spell}{title}{subtitle}`) and creates a block of text used for qualities or spells.

### Other commands

- `spellblock`: This command takes 4 arguments and a 5th optional one. `\spellblock[Damage]{Type}{Range}{Duration}{Drain}`. This can be used in the `spell` environment to add the core spell features.

### Indexing
To create an index entry for a term, write `\index{Term}` in the text where you want the entry to link to.
For more details see [here](https://en.wikibooks.org/wiki/LaTeX/Indexing#Sophisticated_indexing).