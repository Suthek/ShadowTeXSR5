%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% ShadowTeXSR5.cls
%%
%% Author: Tobias Braun
%% Jan, 2020
%%
%% ALL FONTS USED ARE LICENSED FOR NON-COMMERCIAL PURPOSES ONLY
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ShadowTeXSR5}[2020/01/11 - Shadowrun Rulebook Template]

\LoadClass[a4paper, 10pt, twocolumn, twoside]{book}

%%%%%%%%%%%%%%%%%%%%
%%
%% PACKAGES
%%
%%%%%%%%%%%%%%%%%%%%

\RequirePackage{stfloats}
\RequirePackage{lmodern}
\RequirePackage[dvipdfx, rgb, table]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{hyphenat}
\RequirePackage[11pt]{moresize}
\RequirePackage{etoolbox}
\RequirePackage{multicol}
%\RequirePackage{ifthen}
\RequirePackage{xifthen}
\RequirePackage{tikz}
  \usetikzlibrary{fadings}
  \usetikzlibrary{patterns}
  \usetikzlibrary{calc}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{environ}
\RequirePackage{enumitem}
\RequirePackage{imakeidx}

%%%%%%%%%%%%%%%%%%%%
%%
%% CORE CHANGES
%%
%%%%%%%%%%%%%%%%%%%%

%Restrict placement of single-column floats to outer columns only.
%(experimental)

\def\@floatplacement{
  \def\zero{0}
  %Textpage bit, global:
  \ifodd\c@page
    \if@firstcolumn
      \renewcommand\textfraction{0.2}
	  \setlength{\textfloatsep}{1.7\baselineskip plus 0.2\baselineskip minus 0.5\baselineskip}
	  \global\@toproom \topfraction\@colht
  	  \global\@botroom \bottomfraction\@colht

      \@fpmin   \floatpagefraction\@colht

    \else
      \renewcommand\textfraction{0}
      \setlength{\textfloatsep}{0pt}
      \global\@toproom \@colht
  	  \global\@botroom \zero\@colht

      \@fpmin   \@colht      
    \fi
  \else
    \if@firstcolumn
      \renewcommand\textfraction{0}
      \setlength{\textfloatsep}{0pt}	  
	  \global\@toproom \@colht
  	  \global\@botroom \zero\@colht
      
      \@fpmin   \@colht
    \else
      \renewcommand\textfraction{0.2}
      \setlength{\textfloatsep}{1.7\baselineskip plus 0.2\baselineskip minus 0.5\baselineskip}
	  \global\@toproom \topfraction\@colht
      \global\@botroom \bottomfraction\@colht
      
      \@fpmin   \floatpagefraction\@colht
    \fi
  \fi
        \global\@topnum \c@topnumber 
      \global\@botnum \c@bottomnumber
  \global\@colnum  \c@totalnumber
  % Floatpage bit, local:
}

%Change \cleardoublepage so that new chapters begin on even sides
%instead of odd.
\renewcommand*\cleardoublepage{
  \clearpage
  \if@twoside
    \ifodd\c@page 
      \ifnum\c@page=1\else      
        \hbox{}\newpage
        \if@twocolumn
          \hbox{}%
          \newpage
        \fi
      \fi
    \fi
  \fi
}

%Two-Column TOC, extracted and adapted for starred version from multitoc package.

\newboolean{@multitoc@toc}
\newboolean{@multitoc@lot}
\newboolean{@multitoc@lof}

\setboolean{@multitoc@toc}{true}
\setboolean{@multitoc@lot}{false}
\setboolean{@multitoc@lof}{false}

\let\@multitoc@starttoc\@starttoc
\renewcommand*{\@starttoc}[1]{%
  \ifthenelse{\boolean{@multitoc@toc}\and\equal{#1}{toc}}{%
    \begin{multicols*}{2}%
      \@multitoc@starttoc{#1}%
    \end{multicols*}%
  }{}%
  \ifthenelse{\boolean{@multitoc@lot}\and\equal{#1}{lot}}{%
    \begin{multicols*}{2}%
      \@multitoc@starttoc{#1}%
    \end{multicols*}%
  }{}%
  \ifthenelse{\boolean{@multitoc@lof}\and\equal{#1}{lof}}{%
    \begin{multicols*}{2}%
      \@multitoc@starttoc{#1}%
    \end{multicols*}%
  }{}%
}


%%%%%%%%%%%%%%%%%%%%
%%
%% NEW VALUES
%%
%%%%%%%%%%%%%%%%%%%%

\newif\ifTitleSpread
\def\sr@doctitle{}
\def\sr@coverartist{}
\def\sr@writers{}
\def\sr@artists{}
\def\srbb@mainauthor{}
\def\srbb@texts{}
\def\srbb@cover{}
\def\srbb@illustrations{}
\def\srbb@spellreach{}
\def\srbb@spelldrain{}
\def\srbb@spelltype{}
\def\srbb@spelldur{}
\def\srbb@spelldmg{}
\def\srbb@example{}

%%%%%%%%%%%%%%%%%%%%
%%
%% NEW COMMANDS
%%
%%%%%%%%%%%%%%%%%%%%

\newcommand\styleB{\rightskip=0pt plus .8\hsize\relax \parfillskip=0pt plus-.7\hsize\relax}

\newcommand{\splashpicture}[1]{
  \def\tmp{#1}  
  \let\srsplash\tmp
  \pgfdeclareimage[width=\paperwidth, height=\paperheight]{splashimage}{./images/\tmp}
}

\newcommand*{\belowrulesepcolor}[1]{%
  \noalign{%
    \kern-\belowrulesep
    \begingroup
      \color{#1}%
      \hrule height\belowrulesep
    \endgroup
  }%
}
\newcommand*{\aboverulesepcolor}[1]{%
  \noalign{%
    \begingroup
      \color{#1}%
      \hrule height\aboverulesep
    \endgroup
    \kern-\aboverulesep
  }%
}

%%%%%%%%%%%%%%%%%%%%
%%
%% BASIC PAGE SETUP
%%
%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
%% COLORS
%%%

\definecolor{yellowtext}{HTML}{f9b00b}
\definecolor{redtext}{HTML}{931004}
\definecolor{whitetext}{gray}{0.5}
  
\definecolor{normalpage}{gray}{0.95}
\definecolor{storyblack}{gray}{0.1}
\definecolor{boxred}{HTML}{721a16}
\definecolor{headred}{HTML}{5e1519}
  
\newcommand{\globalcolor}[1]{%
  \color{#1}\global\let\default@color\current@color
}

%%%%%%%%%%%%%%%%%
%% FONTS
%%%

\RequirePackage{fontspec}

\newfontfamily{\bodyfont}[
  Path = ./core/fonts/,
  Extension = .ttf,
  UprightFont = *-rg,
  BoldFont = *-b,
  ItalicFont = *-i,
  BoldItalicFont = *-bi,
  NFSSFamily = srbody
]{srfont}
\newfontfamily{\deckerfont}[
  Path = ./core/fonts/,
  Extension = .ttf,  
  UprightFont = *-rg,
  BoldFont = *-b
]{dckr}
\newfontfamily{\headerfont}[
  Path = ./core/fonts/,
  Extension = .ttf,
  UprightFont = *-rg,
  UprightFeatures = {
  FakeStretch=0.75
  }
]{rexlia}
\newfontfamily{\boxfont}[
  Path = ./core/fonts/,
  Extension = .ttf,
  UprightFont = *-rg  
]{universcondensed}
  
\renewcommand{\rmdefault}{srbody}
\renewcommand{\sfdefault}{srbody}

%%%%%%%%%%%%%%%%%
%% GRAPHICS
%%%

\RequirePackage{pgf} 

\pgfdeclareimage{cover-black}{./core/tikz/Cover-black.pdf}
\pgfdeclareimage{cover-red}{./core/tikz/Cover-red.pdf}
\pgfdeclareimage{cover-blue}{./core/tikz/Cover-blue.pdf}
\pgfdeclareimage{cover-green}{./core/tikz/Cover-green.pdf}
\pgfdeclareimage{cover-yellow}{./core/tikz/Cover-yellow.pdf}
\pgfdeclareimage{cover-brown}{./core/tikz/Cover-brown.pdf}
\pgfdeclareimage{cover-grey}{./core/tikz/Cover-grey.pdf}

\pgfdeclareimage{leftfooter}{./core/tikz/FooterLeft.pdf}
\pgfdeclareimage{rightfooter}{./core/tikz/FooterRight.pdf}
\pgfdeclareimage{leftfootersimple}{./core/tikz/SimpleFooterLeft.pdf}
\pgfdeclareimage{rightfootersimple}{./core/tikz/SimpleFooterRight.pdf}

\pgfdeclareimage{bigleftheader}{./core/tikz/HeaderLeftBig.pdf}
\pgfdeclareimage{bigrightheader}{./core/tikz/HeaderRightBig.pdf}
\pgfdeclareimage{smallleftheader}{./core/tikz/HeaderLeftSmall.pdf}
\pgfdeclareimage{smallrightheader}{./core/tikz/HeaderRightSmall.pdf}

\pgfdeclareimage{widepictureframe}{./core/tikz/Twocolumnframe.pdf}
\pgfdeclareimage[width=\paperwidth, height=.98\paperheight]{longpictureframe}{./core/tikz/Columnframe.pdf}

%%%%%%%%%%%%%%%%%
%% GEOMETRY
%%%

\RequirePackage{geometry}

\geometry{a4paper, 
  includeheadfoot,
  top=0cm, 
  headheight=23mm, 
  headsep=7mm, 
  footskip=23mm, 
  bottom=7mm,
  left=20mm, 
  right=15mm
} 

%%%%%%%%%%%%%%%%%
%% BACKGROUND
%%%

\RequirePackage[pagecolor=normalpage]{pagecolor}
\RequirePackage{background}

\backgroundsetup{
  scale=1,
  opacity=.01,
  angle=0,
  contents={%
    \includegraphics[width=\paperwidth , height=\paperheight]{core/images/scanlines.png}
  }
}

%%%%%%%%%%%%%%%%%
%% PENALTIES
%%%

\widowpenalty10000
\clubpenalty10000

%%%%%%%%%%%%%%%%%%%%
%%
%% TABLE OF CONTENTS
%%
%%%%%%%%%%%%%%%%%%%%

\RequirePackage{tocloft}
\RequirePackage[nobottomtitles]{titlesec}

\patchcmd{\l@chapter}
  {\cftchapfont #1}%   search pattern
  {\texorpdfstring{\cftchapfont\uppercase{#1}}{#1}}% replace by
  {}%                  success
  {}%                  failure

\setcounter{tocdepth}{3}

\renewcommand{\cfttoctitlefont}{\color{redtext}\headerfont\Huge\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\\[-0.75em]\color{redtext}\titlerule}

\setlength{\cftchapnumwidth}{0pt}
\setlength{\cftsecnumwidth}{0pt}
\setlength{\cftsubsecnumwidth}{0pt}
\setlength{\cftsubsubsecnumwidth}{0pt}

%Dots
\renewcommand{\cftdot}{.}
\renewcommand{\cftdotsep}{0.1}
\renewcommand{\cftchapdotsep}{0.1}

%Indents
\renewcommand{\cftchapindent}{0em}
\renewcommand{\cftsecindent}{0em}
\renewcommand{\cftsubsecindent}{1em}
\renewcommand{\cftsubsubsecindent}{2em}

%Fonts
\renewcommand{\cftchapfont}{\boxfont\color{redtext}\bfseries}
\renewcommand{\cftchappagefont}{\boxfont\color{redtext}\bfseries}

\renewcommand{\cftsecfont}{\boxfont\color{redtext}\small\bfseries}
\renewcommand{\cftsecpagefont}{\boxfont\color{redtext}\small\bfseries}

\renewcommand{\cftsubsecfont}{\boxfont\small}
\renewcommand{\cftsubsecpagefont}{\boxfont\small}

\renewcommand{\cftsubsubsecfont}{\boxfont\small}
\renewcommand{\cftsubsubsecpagefont}{\boxfont\small}

%Leaders
\renewcommand{\cftchapleader}{\color{redtext}\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftsecleader}{\color{redtext}\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftsubsubsecleader}{\cftdotfill{\cftsecdotsep}}

%%%%%%%%%%%%%%%%%%%%
%%
%% PAGESTYLES/HEADER AND FOOTER
%%
%%%%%%%%%%%%%%%%%%%%
\graphicspath{{./images/}}
\RequirePackage{fancyhdr}

\renewcommand{\headrulewidth}{0pt}

%%%%%%%%%%%%%%%%%
%% FOOTERS
%%%

\newcommand{\footerleft}[1]{
\begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
	\node[anchor=center] at (.5\paperwidth,.5\paperheight) {\pgfuseimage{#1}};
	\node [anchor=west, white, font=\headerfont] at (27mm,9.5mm) {\LARGE\thepage\hspace{1cm}\large\MakeUppercase{\leftmark}\hspace{1em}\large\guillemotright};
	\end{tikzpicture}	
}

\newcommand{\footerright}[1]{
	\begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
	\node[anchor=center] at (.5\paperwidth,.5\paperheight) {\pgfuseimage{#1}};
	\node [anchor=east, align=right, white, font=\headerfont] at (\paperwidth-27mm,9.5mm) {\large\guillemotleft\hspace{1em}\large\MakeUppercase{\leftmark}\hspace{1cm}\LARGE\thepage};
	\end{tikzpicture}	

}

%%%%%%%%%%%%%%%%%
%% PLAIN
%%%

\fancypagestyle{plain}{
  \fancyhf{}	
  \fancyhead[LE]{
    \begin{tikzpicture}[remember picture, overlay, shift={(current page.center)}]
	  \ifTitleSpread
	    \suppressfloats[t]
	    \suppressfloats[b]	  
	    \node at (0,0) {\pgfuseimage{bigleftheader}};
	    \node[anchor=south west, fill=redtext, minimum height=6mm, white, font=\headerfont] at (-.5\paperwidth+15mm,.5\paperheight-14mm) {\MakeUppercase{\doctitle}};
	    \draw node[anchor=west, white, align=left, font=\headerfont\fontsize{60}{50}\selectfont] at (-.5\paperwidth+8mm,{(.5\paperheight)-(.5\headheight)})
 {\parbox{183mm}{\styleB \nohyphens{\MakeUppercase{\leftmark}}}};
      \else
        \node at (0,0) {\pgfuseimage{smallleftheader}};	  
	    \node[anchor=west, white, font=\headerfont] at (-.5\paperwidth+15mm,{(.5\paperheight)-((.5\headheight)-2mm)}) {\Large\guillemotright~~\normalsize\sr@doctitle~~\Large\guillemotleft};
	  \fi	  
	\end{tikzpicture}
  }
  \fancyhead[LO]{
    \begin{tikzpicture}[remember picture, overlay, shift={(current page.center)}]
      \ifTitleSpread
        \suppressfloats[t]
        \suppressfloats[b]
        \node at (0,0) {\pgfuseimage{bigrightheader}};
        \@ifundefined{srsplash}{}{
          \begin{scope}
            \clip(-.5\paperwidth,.5\paperheight) rectangle (.5\paperwidth,{.5\paperheight-(\headheight-3mm)});
            \node[red, anchor=center, opacity=0.25] at (0,.5\paperheight) {\pgfuseimage{splashimage}};
          \end{scope}
        } 
	  \else
        \node at (0,0) {\pgfuseimage{smallrightheader}};
        \@ifundefined{srsplash}{}{
          \begin{scope}
            \clip(-.5\paperwidth,.5\paperheight) rectangle (.5\paperwidth,{.5\paperheight-(\headheight-3mm)});
            \node[red, anchor=center, opacity=0.25] at (0,.5\paperheight) {\includegraphics[height=\paperheight, width=\paperwidth]{\srsplash}};
	      \end{scope}
        } 
        \node[anchor=east, align=left, white, font=\headerfont] at (.5\paperwidth-15mm,{(.5\paperheight)-((.5\headheight)-2mm)}) {\large\guillemotright~~\normalsize\sr@doctitle~~\Large\guillemotleft};
	  \fi
    \end{tikzpicture}
    \global\headheight=23mm
    \global\textheight=237mm
    \global\TitleSpreadfalse
  }
  \fancyfoot[LE]{
    \footerleft{leftfooter}
  }
  \fancyfoot[LO]{
    \footerright{rightfooter}
    \global\headsep=7mm
  }  
}

%%%%%%%%%%%%%%%%%
%% STORY
%%%

\fancypagestyle{story}{
  \fancyhf{}
  \fancyhead[LE]{
    \suppressfloats[t]
    \suppressfloats[b]
    \ifTitleSpread  
      \begin{tikzpicture}[remember picture, overlay]
        \node at (.5\paperwidth-15mm,.5\headheight) {\includegraphics[width=\paperwidth, height=\headheight]{\storyleftimage}};
        \fill[fill=redtext, path fading=east, fill opacity=.8] (-15mm,0) rectangle (\paperwidth, 3);
        \draw node[white, align=justify, font=\headerfont\fontsize{40}{35}\selectfont\styleB] at (65mm,15mm) {\parbox{140mm}{\styleB \nohyphens{\MakeUppercase{\leftmark}}}};
      \end{tikzpicture}
    \fi
  }
  \fancyhead[LO]{
    \suppressfloats[t]
    \suppressfloats[b]  
    \ifTitleSpread
      \begin{tikzpicture}[remember picture, overlay]
        \node at (.5\paperwidth-20mm,.5\headheight) {\includegraphics[width=\paperwidth, height=\headheight]{\storyrightimage}};
        \fill[anchor=south east, fill=redtext, path fading=west, fill opacity=.8] (.4\paperwidth,0) rectangle (\paperwidth-20mm, 10mm);
        \draw node[white, anchor=east, font=\headerfont\large] at (\paperwidth-40mm, 0.5) {\MakeUppercase{\storyauthor}};
      \end{tikzpicture}
    \fi
    \global\headheight=23mm
    \global\textheight=237mm
	\global\TitleSpreadfalse
  }
  \fancyfoot[LE]{
    \footerleft{leftfootersimple}
  }
  \fancyfoot[LO]{
    \footerright{rightfootersimple}
    \global\headsep=7mm
  }  
}

\pagestyle{plain}

%%%%%%%%%%%%%%%%%%%%
%%
%% CHAPTERS AND SECTIONS
%%
%%%%%%%%%%%%%%%%%%%%

\renewcommand{\chaptermark}[1]{ \markboth{#1}{} }
\renewcommand{\chaptername}{}
\renewcommand{\thechapter}{}
\renewcommand{\thesection}{}
\renewcommand{\thesubsection}{}

\titleformat{name=\section}[block]
  {\headerfont\huge\color{redtext}\raggedright\nohyphens}{}{0cm}{\MakeUppercase}[{\color{redtext}\nobreak\titlerule}]
  
\titleformat{name=\section,numberless}[block]
  {\headerfont\huge\color{redtext}\raggedright\nohyphens}{}{0cm}{\MakeUppercase}[{\color{redtext}\nobreak\titlerule}]


\titleformat{\subsection}
  {\headerfont\Large\color{redtext}\raggedright\nohyphens}{}{0cm}{\MakeUppercase}[{\color{redtext}\nobreak\titlerule}]

  
\titleformat{\subsubsection}
  {\headerfont\large\raggedright\nohyphens}{}{0cm}{\MakeUppercase}[{\color{black}\nobreak\titlerule}]



%%%%%%%%%%%%%%%
%% NEW CHAPTER DEFS
%%%

\newcommand{\storychapter}[4]{
  \def\tmp{#2}
  \let\storyauthor\tmp
  \def\tmp{#3}
  \let\storyleftimage\tmp
  \def\tmp{#4}  
  \let\storyrightimage\tmp
  \stchapter{#1}
}

\newcommand{\stchapter}{
  \cleardoublepage
  \phantomsection
  \global\TitleSpreadtrue
  \newpagecolor{storyblack}
  \globalcolor{white}
  \pagestyle{story}
  \newgeometry{ 
    includeheadfoot,
    top=0cm, 
    bottom=7mm,
    headheight=15cm, 
    headsep=5mm, 
    footskip=23mm, 
    left=20mm, 
    right=15mm
  }
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter
}

\renewcommand\chapter{
  \cleardoublepage  
  \phantomsection
  \global\TitleSpreadtrue
  \restorepagecolor
  \globalcolor{black}
  \pagestyle{plain}
  \newgeometry{ 
    includeheadfoot,
    top=0cm, 
    bottom=7mm,
    headheight=73mm, 
    headsep=10mm, 
    footskip=23mm, 
    left=20mm, 
    right=15mm
  }
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter
}
                    
\def\@chapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \refstepcounter{chapter}%
      \typeout{\@chapapp\space\thechapter.}%
      \addcontentsline{toc}{chapter}%
      {\protect\numberline{\thechapter}#1}%
    \else
      \addcontentsline{toc}{chapter}{#1}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
}

\def\@schapter#1{}

%%%%%%%%%%%%%%%%%%%%
%%
%% NEW ELEMENTS
%%
%%%%%%%%%%%%%%%%%%%%

\RequirePackage[many]{tcolorbox}

%%%%%%%%%%%%%%%%%%%
%% IMAGES
%%%
\newcommand{\twocolimage}[1]{
\begin{tcolorbox}[
    enhanced,
    float*=t,
    width=\textwidth,
    height=12cm,
    top=0mm,
    bottom=0mm,	
    left=0mm,
    right=0mm,    
    opacityframe=1,
    opacityback=1,
    colframe=storyblack,
    coltext=white,
    interior style={fill stretch image=#1, fill image opacity=1},
    interior code app={\node[anchor=center] at (frame.center) {\pgfuseimage{widepictureframe}};},
  ]
  \end{tcolorbox}
}

\RequirePackage{afterpage}
\RequirePackage{placeins}

\newcommand{\drawcolimg}[1]{
  \begin{tcolorbox}[
    enhanced,
    float=ht,
    width=\columnwidth,
    height=.99\textheight,
    top=0mm,
    bottom=0mm,	
    left=0mm,
    right=0mm,    
    opacityframe=1,
    opacityback=1,
    colframe=storyblack,
    coltext=white,
    interior style={fill stretch image=#1, fill image opacity=1},
    interior code app={\node[anchor=center] at (frame.center) {\pgfuseimage{longpictureframe}};},
  ]
  \end{tcolorbox}
}

\newcommand{\columnimage}[1]{
 \drawcolimg{#1}
 \afterpage{\afterpage{\FloatBarrier}}
}

%%%%%%%%%%%%%%%%%%%%
%% BOXES
%%%

\newcommand{\sr@blckbox}[2]{
\begin{tcolorbox}[
enhanced, 
fonttitle=\boxfont, 
float*=tb, 
colback=storyblack, 
left=2mm, 
right=2mm, 
bottom=6mm, top=3mm, 
title={\color{yellowtext}\Large\MakeUppercase{#1}}, 
width = \textwidth, 
arc=0mm, 
outer arc=0mm, 
colframe=storyblack, 
attach boxed title to top left={yshift=-1mm}, 
boxed title style={arc=0mm, top=2mm, bottom=1mm, colframe=storyblack, colback=storyblack, outer arc=0mm}, underlay boxed title={\fill[storyblack] ($(title.north east)+(-2mm, 0mm)$) -- ($(title.south east)+(-2mm, 0mm)$) -- ($(title.south east)+(2mm, 0mm)$) -- ++(2cm, 0mm) -- ($(title.north east)+(2mm, 0mm)$) -- cycle;}
]
\centering
#2
\end{tcolorbox}
}

\newcommand{\sr@lbox}[1]{
  \begin{tcolorbox}[
	enhanced,	
	before={\vspace{1em}\hspace{-32mm}},
	top=4mm,
    bottom=4mm,	
	left=25mm,
	right=5mm,    
    opacityframe=1,
    opacityback=1,
    interior style={left color=boxred,right color=redtext, fill plain image=./core/images/scanlines.png, fill image opacity=0.1},
    colframe=storyblack,
    coltext=white,
    text width=\dimexpr\columnwidth-7mm,
    frame style={fill plain image=./core/images/Skyline_Seattle_schwarz_1920x1080px.jpg},
    underlay={
		\fill[storyblack] ($(frame.north east) + (-7mm,-1mm)$) rectangle ++(-40mm, 2mm);
		\fill[storyblack] ($(frame.north east) + (-46mm,1mm)$) -- ++(-1mm, 0mm) -- ++(-6mm, -2mm) -- ++(7mm, 0mm) -- cycle;
		\fill[storyblack] ($(frame.north east) + (-7mm,1mm)$) -- ++(0mm, -2mm) -- ++(-45:9.9mm) -- ++(0mm, 2mm) -- cycle;
		\node[anchor=east, opacity=.25] at ($(frame.north east) + (-10mm,-.5mm)$) {\includegraphics[height=1.5mm, width=30mm]{./core/images/pattern.png}};
    },
    boxrule=2mm,
    arc is angular,    
    arc=6mm,outer arc=7mm
    ]
    #1
    \end{tcolorbox}
}

\newcommand{\sr@rbox}[1]{
  \begin{tcolorbox}[
	enhanced,
    top=4mm,
    bottom=4mm,	
	left=5mm,
    right=25mm,
	opacityframe=1,
    opacityback=1,
    interior style={left color=redtext,right color=boxred, fill plain image=./core/images/scanlines.png, fill image opacity=0.1},
    colframe=storyblack,
        interior style={left color=boxred,right color=redtext, fill plain image=./core/images/scanlines.png, fill image opacity=0.1},
    frame style={fill plain image=./core/images/Skyline_Seattle_schwarz_1920x1080px.jpg},
    underlay={
		\fill[storyblack] ($(frame.north west) + (7mm,-1mm)$) rectangle ++(40mm, 2mm);
		\fill[storyblack] ($(frame.north west) + (46mm,1mm)$) -- ++(1mm, 0mm) -- ++(6mm, -2mm) -- ++(-7mm, 0mm) -- cycle;
		\fill[storyblack] ($(frame.north west) + (7mm,1mm)$) -- ++(0mm, -2mm) -- ++(-135:9.9mm) -- ++(0mm, 2mm) -- cycle;
		\node[anchor=west, opacity=.25] at ($(frame.north west) + (10mm,-.5mm)$) {\includegraphics[height=1.5mm, width=30mm]{./core/images/pattern.png}};
    },
    coltext=white,
    text width=\dimexpr\columnwidth-7mm,
    boxrule=2mm,
  	arc is angular,    
    arc=6mm,outer arc=7mm]
    #1
    \end{tcolorbox}
}

\newcommand{\sr@rdblbox}[1]{
\begin{tcolorbox}[
	enhanced,
	top=4mm,
    bottom=4mm,	
	left=5mm,
	right=25mm,    
    opacityframe=1,
    opacityback=1,
    interior style={left color=redtext,right color=boxred, fill plain image=./core/images/scanlines.png, fill image opacity=0.1},
    colframe=storyblack,
    coltext=white,
    text width=\textwidth-7mm,
    frame style={fill plain image=./core/images/Skyline_Seattle_schwarz_1920x1080px.jpg},
    underlay={
		\fill[storyblack] ($(frame.north west) + (7mm,-1mm)$) rectangle ++(40mm, 2mm);
		\fill[storyblack] ($(frame.north west) + (46mm,1mm)$) -- ++(1mm, 0mm) -- ++(6mm, -2mm) -- ++(-7mm, 0mm) -- cycle;
		\fill[storyblack] ($(frame.north west) + (7mm,1mm)$) -- ++(0mm, -2mm) -- ++(-135:9.9mm) -- ++(0mm, 2mm) -- cycle;
		\node[anchor=west, opacity=.25] at ($(frame.north west) + (10mm,-.5mm)$) {\includegraphics[height=1.5mm, width=30mm]{./core/images/pattern.png}};
    },
    boxrule=2mm,
    arc is angular,    
    arc=6mm,outer arc=7mm,
    float*=tb,
    every float=\hspace{-7mm}
    ]
    #1
    \end{tcolorbox}
}

\newcommand{\sr@ldblbox}[1]{
\begin{tcolorbox}[
	enhanced,
	top=4mm,
    bottom=4mm,	
	left=25mm,
	right=5mm,    
    opacityframe=1,
    opacityback=1,
    interior style={left color=boxred,right color=redtext, fill plain image=./core/images/scanlines.png, fill image opacity=0.1},
    colframe=storyblack,
    coltext=white,
    text width=\textwidth-7mm,
    boxrule=2mm,
        frame style={fill plain image=./core/images/Skyline_Seattle_schwarz_1920x1080px.jpg},
    underlay={
		\fill[storyblack] ($(frame.north east) + (-7mm,-1mm)$) rectangle ++(-40mm, 2mm);
		\fill[storyblack] ($(frame.north east) + (-46mm,1mm)$) -- ++(-1mm, 0mm) -- ++(-6mm, -2mm) -- ++(7mm, 0mm) -- cycle;
		\fill[storyblack] ($(frame.north east) + (-7mm,1mm)$) -- ++(0mm, -2mm) -- ++(-45:9.9mm) -- ++(0mm, 2mm) -- cycle;
		\node[anchor=east, opacity=.25] at ($(frame.north east) + (-10mm,-.5mm)$) {\includegraphics[height=1.5mm, width=30mm]{./core/images/pattern.png}};
    },
    arc is angular,    
    arc=6mm,outer arc=7mm,
    float*=tb,
    every float=\hspace{-25mm}
    ] 
    #1
    \end{tcolorbox}
}

\newcommand{\sr@examplebox}[1]{
  \begin{tcolorbox}[
  enhanced, 
  float, 
  colback=storyblack, 
  left=3mm, 
  right=5mm, 
  bottom=3mm, 
  top=5mm,
  height=30mm,
  height plus=\textheight-30mm,
  boxrule=1pt, 
  title={\headerfont\color{yellowtext}\Large\MakeUppercase{\srbb@example}}, 
  width=\columnwidth, 
  arc=5mm, 
  outer arc=5mm, 
  colframe=storyblack, 
  colback=white,  
  arc is angular,
  attach boxed title to top left={xshift=5mm}, 
  boxed title style={enhanced, opacityframe=0, opacityback=0, left= 1mm, arc=0mm, top=2mm, bottom=1mm, outer arc=0mm, boxrule=1pt}, 
  underlay boxed title={
  \fill[storyblack] (title.north west) -- ++(-3.5mm, 0mm) -- ++(-135:5mm) -- ($(frame.south west) + (-2mm, 25mm)$) -- ++(-45:3mm) -- ($(frame.north west)+(1pt,-5mm)$) -- ++(45:7mm) -- ($(title.south west)+(1mm, -1pt)$) -- ($(title.south west)+(0mm, -1pt)$) -- ($(frame.north east)+(-15mm, -1pt)$) -- ++(135:3.2mm) -- ($(title.south east)+(20mm,2mm)$) -- ++(135:10.5mm) -- cycle;
  }
  ]
  #1
  \end{tcolorbox}
}

\newcommand{\sr@dblexamplebox}[1]{
  \begin{tcolorbox}[
  enhanced, 
  float*, 
  colback=storyblack, 
  left=3mm, 
  right=5mm, 
  bottom=3mm, 
  top=5mm,
  height=30mm,
  height plus=\textheight-30mm,
  boxrule=1pt, 
  title={\headerfont\color{yellowtext}\Large\MakeUppercase{\srbb@example}}, 
  width=\textwidth, 
  arc=5mm, 
  outer arc=5mm, 
  colframe=storyblack, 
  colback=white,  
  arc is angular,
  attach boxed title to top left={xshift=5mm}, 
  boxed title style={enhanced, opacityframe=0, opacityback=0, left= 1mm, arc=0mm, top=2mm, bottom=1mm, outer arc=0mm, boxrule=1pt}, 
  underlay boxed title={
  \fill[storyblack] (title.north west) -- ++(-3.5mm, 0mm) -- ++(-135:5mm) -- ($(frame.south west) + (-2mm, 25mm)$) -- ++(-45:3mm) -- ($(frame.north west)+(1pt,-5mm)$) -- ++(45:7mm) -- ($(title.south west)+(1mm, -1pt)$) -- ($(title.south west)+(0mm, -1pt)$) -- ($(frame.north east)+(-15mm, -1pt)$) -- ++(135:3.2mm) -- ($(title.south east)+(20mm,2mm)$) -- ++(135:10.5mm) -- cycle;
  }
  ]
  #1
  \end{tcolorbox}
}

\NewEnviron{blackbox}[1]{
\sr@blckbox{#1}{\BODY}
}

\NewEnviron{columnbox}[1][]{
  \hfuzz=30mm
  \par
  \boxfont
  \ifthenelse{\isempty{#1}}%
    {\if@firstcolumn
      \sr@lbox{\BODY}
    \else
      \sr@rbox{\BODY}
    \fi
  }% if #1 is empty
  {
    \ifthenelse{\equal{#1}{l}}{\sr@lbox{\BODY}}{\sr@rbox{\BODY}}
  }%
}

\NewEnviron{twocolbox}[1][]{
  \hfuzz=30mm
  \par
  \boxfont
  \ifthenelse{\isempty{#1}}{
    \ifodd\c@page
      \sr@rdblbox{\BODY}  
    \else
      \sr@ldblbox{\BODY}
    \fi
  }{
    \ifthenelse{\equal{#1}{l}}{\sr@ldblbox{\BODY}}{\sr@rdblbox{\BODY}}
  }
}

\NewEnviron{examplebox}{
\sr@examplebox{\BODY}
}

\NewEnviron{twocolexamplebox}{
\sr@dblexamplebox{\BODY}
}

%%%%%%%%%%%%%%%%%%%%
%% TABLES
%%%

\NewEnviron{srtable}[2]{
  \rowcolors{1}{\ifnumless{\rownum}{2}{black}{storyblack}}{storyblack!80!white}  
  \arrayrulecolor{yellowtext}
  \color{white}\small
  \begin{tabularx}{\textwidth}{#1}
  \toprule
  \belowrulesepcolor{black}
  #2\\
  \aboverulesepcolor{black}   
  \bottomrule
  \BODY
  \toprule
  \end{tabularx}
}

%%%%%%%%%%%%%%%%%%%
%% OTHER AREAS
%%%

\NewEnviron{deckercomment}[1]{
  \def\commentauthor{#1}
  \deckerfont
  \small
  \par
  \begin{itemize}[
  leftmargin=1.2em, 
  itemsep=-1ex,
  label={\begin{tcolorbox}[valign=center, halign=center,hbox,boxsep=-3.7mm, boxrule=0mm,colback=black, square, circular arc] {\color{normalpage}\bfseries\textgreater}	\end{tcolorbox}}
  ]
  \item \BODY \\
  \item #1
  \end{itemize}
  \par
}

\NewEnviron{spell}[2]{
\par\vspace{1em}\noindent
{\headerfont\Large\color{redtext}\MakeUppercase{#1}}\nopagebreak\\
{\headerfont\large\color{storyblack}\MakeUppercase{#2}}\nopagebreak\\[1pt]
\vspace{-1em}\hrule\vspace{1em}\noindent
\BODY
}


%%%%%%%%%%%%%%%%%%%%
%%
%% NEW COMMANDS II
%%
%%%%%%%%%%%%%%%%%%%%

\newcommand{\spellblock}[5][]{
\def\sr@tmp{}
\ifthenelse{\isempty{#1}}{}{
\def\sr@tmp{\textbf{\srbb@spelldmg:} #1}
}
\begin{tabular}{lll}
\textbf{\srbb@spelltype:} #2 & \textbf{\srbb@spellreach:} #3 & \sr@tmp\\
\textbf{\srbb@spelldur:} #4 & \textbf{\srbb@spelldrain:} #5 & \\
\end{tabular}
\par
}

\newcommand{\srmaketitle}[1][black]{
  \def\coverframe{cover-}
  \g@addto@macro\coverframe{#1}
  \let\sr@doctitle\@title
  \pagestyle{empty}
  \cleardoublepage
  \begin{titlepage}
    \hfuzz=100pt
    \@ifundefined{srsplash}{
      \begin{center}
        {\Huge\headerfont\color{redtext}\@title}\\
        {\Large\headerfont\color{redtext}\@author}
      \end{center}
      \end{titlepage}
    }{
      \begin{tikzpicture}[remember picture, overlay, shift={(current page.center)}]
        \node[opacity=1, inner sep=0pt, scale=0.9] at (0,-30mm) {\pgfuseimage{splashimage}};
        \node[opacity=1, inner sep=0pt] at (0,0) {\pgfuseimage{\coverframe}};
      \end{tikzpicture}
      \end{titlepage}
      \newpage
      \makeimpressum
      \newpage
      \mainmatter
      \tikz[remember picture,overlay] \node[opacity=1,inner sep=0pt] at (current page.center){\pgfuseimage{splashimage}};
    }

  %\setcounter{page}{2}
  \cleardoublepage
  \pagestyle{plain}
}

\newcommand{\makeimpressum}{
  \vspace*{.6\textheight}
  \begin{tcolorbox}[
    enhanced,
    before=\hspace{-25mm},
    top=4mm,
    bottom=4mm,	
    left=25mm,
    right=25mm,    
    opacityframe=1,
    opacityback=1,
    colback=boxred,
    interior style={fill plain image=./core/images/scanlines.png, fill image opacity=0.1},
    colframe=storyblack,
    coltext=white,
    text width=\textwidth-7mm,
    boxrule=2mm
  ]
  \begin{multicols*}{2}[{\color{yellowtext}\Huge Impressum}]
  \color{white}\normalsize
    
  \textbf{\srbb@mainauthor:} \@author\\
  \textbf{\srbb@texts:} \sr@writers\\
  \textbf{\srbb@cover:} \sr@coverartist\\
  \textbf{\srbb@illustrations:} \sr@artists
  \end{multicols*}
  \begin{center}
  {\bfseries This template was created for hobbyists and is NOT to be used for commercial purposes.}  
  \par
    The Topps Company, Inc. has sole ownership of the names, logo, artwork, marks, photographs, sounds, audio, video and/or any proprietary material used in connection with the game Shadowrun. The Topps Company, Inc. has granted permission to \@author ~to use such names, logos, artwork, marks and/or any proprietary materials for promotional and informational purposes on its website but does not endorse, and is not affiliated with \@author ~in any official capacity whatsoever.
    \par
    Shadowrun-Logo und Inhalte mit freundlicher Genehmigung von Pegasus Spiele unter Lizenz von Catalyst Game Labs und Topps Company, Inc. © 2014 Toppy Company, Inc. Alle Rechte vorbehalten. Shadowrun ist eine eingetragene Handelsmarke von Topps Company, Inc.
  \end{center}
\end{tcolorbox}
}

\newcommand{\storypar}{
  \begin{center}
  \resizebox{3mm}{!}{$\textcolor{redtext}\ast$}
  \end{center}
}

\newcommand{\artists}[1]{
\def\sr@artists{#1}
}

\newcommand{\coverartist}[1]{
\def\sr@coverartist{#1}
}

\newcommand{\writers}[1]{
\def\sr@writers{#1}
}

%%%%%%%%%%%%%%%%%%%%
%%
%% SOLITARY PACKAGES II
%%
%%%%%%%%%%%%%%%%%%%%

\RequirePackage[hidelinks]{hyperref}


%%%%%%%%%%%%%%%%%%%%
%%
%% TERMINOLOGY
%%
%%%%%%%%%%%%%%%%%%%%


\PassOptionsToPackage{ngerman}{babel}
\PassOptionsToPackage{english}{babel}

\RequirePackage{babel}

\addto\captionsenglish{% Replace "english" with the language you use
  \renewcommand{\contentsname}{Content}%
  \renewcommand{\srbb@mainauthor}{Main Author}
  \renewcommand{\srbb@cover}{Cover Image}
  \renewcommand{\srbb@illustrations}{Illustrations \& Maps}
  \renewcommand{\srbb@texts}{Texts}
  \renewcommand{\srbb@spelltype}{Type}
  \renewcommand{\srbb@spellreach}{Range}
  \renewcommand{\srbb@spelldur}{Duration}
  \renewcommand{\srbb@spelldrain}{Drain}
  \renewcommand{\srbb@spelldmg}{Damage}
  \renewcommand{\srbb@example}{Example}
}

\addto\captionsngerman{
  \renewcommand{\contentsname}{Inhalt}
  \renewcommand{\srbb@mainauthor}{Hauptautor}
  \renewcommand{\srbb@cover}{Coverbild}
  \renewcommand{\srbb@illustrations}{Illustrationen \& Karten}
  \renewcommand{\srbb@texts}{Texte}
  \renewcommand{\srbb@spelltype}{Art}
  \renewcommand{\srbb@spellreach}{Reichweite}
  \renewcommand{\srbb@spelldur}{Dauer}
  \renewcommand{\srbb@spelldrain}{Entzug}
  \renewcommand{\srbb@spelldmg}{Schaden}
  \renewcommand{\srbb@example}{Beispiel}
}



\graphicspath{{./images/}}

\indexsetup{level=\section*,toclevel=chapter}
\makeindex[options= -s ./index_style.ist, intoc]
\AtEndDocument{\cleardoublepage\restorepagecolor\globalcolor{black}\pagestyle{plain}\printindex}
\frontmatter


