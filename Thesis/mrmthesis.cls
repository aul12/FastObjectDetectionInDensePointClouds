%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% University of Ulm %%
%% Faculty of Engineering and Computer Science
%% Institute of Measurement, Control and Microtechnology
%%
%%
%% Template for Student Research Projects, Diploma, Bachelor and Master Thesis
%%
%% by order of Dr.-Ing. Michael Buchholz
%%                      created by Stephan Grensemann 2010
%%
%% Updated versions by Michael Buchholz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initiate a new class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mrmthesis}[2015/05/11 v. 1.9b Uni Ulm - Measurement, Control and Microtechnology]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Change log
%
%v1.9b 2015/05/11 New faculty name including psychology 
%
%v1.9a 2014/08/07 Correction of two typos in declaration text
%
%v1.9 2014/07/10 update of student declaration and English translations
%
%v1.8 2014/04/03 mrmbibstyle updated to v1.1
%
%v1.7 2013/12/02 added support for female labels of persons on description page
%                added amsmath to required packages of class to avoid problems with loading
%                amsmath after hyperref
%
%v1.6 2012/12/17 added boolean option "namebehindauthortitle" and changed standard placement
%                of author title behind name, added author title to project description page
%                changed biblatex backend to biber, added compatibility option for bibtex8
%
%v1.5 2012/05/08 subfig replaced by subcaption and force "modern" version of caption package
%                (see new version of l2tabu, thanks to Thomas Pfeiffer for his hint)
%
%v1.4 2011/07/28 page numbering changed in front matter (title page is no page i)
%                added boolean option "confidential" for confidential marking on title page
%
%v1.3 2011/03/11 added option "backend=bibtex8" for biblatex package due to input
%                encoding with latin1, necessary for newer versions of biblatex
%
%v1.2 2010/11/10 fixed too large vertical distances on description page
%
%v1.1 2010/08/04 fixed typo on title page
%
%v1.0 2010/07/12 first release
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%following packages are required now!
\RequirePackage{ifpdf}
\RequirePackage{ifthen}
\RequirePackage[patch]{kvoptions}       %enables to use options in key value format for package options
                                        % option: patch ->allows spaces and special characters as key and values
\SetupKeyvalOptions {
  family = mrm,
  prefix = mrm@
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%declaring variables
\newboolean{en}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%declaring options & process
\DeclareDefaultOption{}                  %if unknown options do nothing! No Warning as well!
\DeclareStringOption[de]{language}
\DeclareStringOption[master]{thesis}
\DeclareStringOption[img/]{logopath}
\DeclareStringOption[0.75cm]{BCOR}
\DeclareBoolOption[false]{confidential}
\DeclareBoolOption[false]{namebehindauthortitle}
\DeclareBoolOption[false]{backendbibtex} %new in v1.6 for backward compatibility

\ProcessKeyvalOptions*

\ifthenelse{\equal{\mrm@language}{en}}{\setboolean{en}{true}}{\setboolean{en}{false}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%based on KOMA scrbook / loading packages
\LoadClass[12pt,a4paper,%
          numbers=noenddot,%
          parskip=full-,%
          titlepage,twoside=true]{scrbook}
\RequirePackage[automark]{scrpage2}             %for headings and footing
\RequirePackage{scrhack}
\RequirePackage{setspace}
%set space between lines
\singlespacing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\newif\if@frontmatter\@frontmattertrue              %to check if command is executed in frontmatter segment
\g@addto@macro{\mainmatter}{\@frontmatterfalse}     %set \if@frontmatter=false after first \mainmatter call in the document
\g@addto@macro{\appendix}{\cleardoublepage}         %add an clearpage because \appendix and \begin{appendix} ... \end{appendix}
                                                    %won't do it automaticly
\ifthenelse{\equal{\mrm@language}{de}}{             %if language=de, chapter will be printed as "Literaturverzeichnis"
            \g@addto@macro{\appendix}{\renewcommand{\bibname}{Literaturverzeichnis}}
            }{}%else nothing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%packages for type area, writings and so on
\RequirePackage{microtype}                %An interface to the micro-typographic features of pdfTeX

\ifthenelse{\boolean{en}}{%
  \RequirePackage[ngerman,english]{babel}}{%
  \RequirePackage[english,ngerman]{babel}}
\RequirePackage[latin1]{inputenc} \RequirePackage[T1]{fontenc} \RequirePackage{lmodern}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%further required packages
\RequirePackage{graphicx}                                 %enhanced support for graphics

%%% v1.5: changed for forcing "newer" versions of caption package, see l2tabu
%\RequirePackage[format=hang,font=rm,textfont=rm,%
%                labelfont=bf,margin=0.5cm]{caption} %Customising captions in floating environments
\RequirePackage[format=hang,font=rm,textfont=rm,%
                labelfont=bf,margin=0.5cm]{caption}[2008/08/24] %Customizing captions in floating environments
%%% v1.5:  subfig is no longer maintained, now using subcaption (cf. l2tabu)
%\RequirePackage[format=hang,labelfont=rm,margin=0.15cm,%
%                subrefformat=parens]{subfig}              %Figures broken into subfigures
\RequirePackage[format=hang,labelfont=rm,margin=0.15cm,%
                subrefformat=parens]{subcaption}              %Allow floats (e.g. figures) to be composed of several subfloats with own subcaptions

\RequirePackage{xcolor}                                   %provides both foreground (text, rules, etc.) and background colour management
\definecolor{black}{gray}{0} % 10% gray
\definecolor{mrmconfcolor}{RGB}{163,38,56}%

\RequirePackage[intlimits,tbtags]{amsmath}              %load amsmath before hyperref to avoid unwanted behavior with subequation links

\RequirePackage[colorlinks=true,linkcolor=black,%
                citecolor=black,urlcolor=black,%
                hyperfootnotes=false]{hyperref}
\ifpdf \hypersetup{breaklinks=true} \fi

%%% v1.4: added for "confidential" option
\ifthenelse{\boolean{mrm@confidential}}{%
    \RequirePackage{eso-pic}%
    }{}%else do nothing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%declaration of used commands
\newcommand{\@ifprint}[2]{\ifthenelse{\equal{#1}{\empty}}{#1}{#2}} %if Argument 1 is empty print nothing, else print Argument 2
\newcommand{\@institute}{\ifthenelse{\boolean{en}}
  {Faculty of Engineering, Computer Science and Psychology\\ %%% v1.9b: new faculty name
   Institute of Measurement, Control and Microtechnology}
  {Fakult\"at f\"ur Ingenieurwissenschaften, Informatik und Psychologie\\  %%% v1.9b: new faculty name
     Institut f\"ur Mess-, Regel- und Mikrotechnik}}
\newcommand{\@header}{\vspace*{-2.5cm}
                      \begin{center}
                        \ifpdf
                            \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
                                \includegraphics[scale=0.4]{\mrm@logopath
                                unilogo_bild.pdf} &
                                \includegraphics[scale=0.4]{\mrm@logopath
                                unilogo_wort.pdf}
                            \end{tabular*}
                        \else
                            \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
                                \includegraphics[scale=0.4]{\mrm@logopath
                                unilogo_bild.eps} &
                                \includegraphics[scale=0.4]{\mrm@logopath
                                unilogo_wort.eps}
                            \end{tabular*}
                        \fi
                      \textsf{\large \@institute}
                      \end{center}}
\newcommand{\@thesis}{\ifthenelse{\boolean{en}}{Master's Thesis}{Masterarbeit}}
\newcommand{\@dtitle}{\@title}
\newcommand{\descriptiontitle}[1]{\ifthenelse{\equal{#1}{\empty}}{}{\renewcommand{\@dtitle}{#1}}}
\newcommand{\@atitle}{\@title}
\newcommand{\affirmationtitle}[1]{\ifthenelse{\equal{#1}{\empty}}{}{\renewcommand{\@atitle}{#1}}}
\newcommand{\@authortitle}{}
\newcommand{\authortitle}[1]{\renewcommand{\@authortitle}{#1}}
\newcommand{\@authorlabel}{Bearbeiter}
\renewcommand{\author}[2][m]{\renewcommand{\@author}{#2}%
            \ifthenelse{\equal{#1}{f}}{\renewcommand{\@authorlabel}{Bearbeiterin}}%
            {\renewcommand{\@authorlabel}{Bearbeiter}}}
\newcommand{\@supervisor}{}
\newcommand{\@supervisorlabel}{Betreuer}
\newcommand{\supervisor}[2][m]{\renewcommand{\@supervisor}{#2}%
            \ifthenelse{\equal{#1}{f}}{\renewcommand{\@supervisorlabel}{Betreuerin}}%
            {\renewcommand{\@supervisorlabel}{Betreuer}}}
\newcommand{\@examiner}{}
\newcommand{\examiner}[1]{\renewcommand{\@examiner}{#1}}
\newcommand{\@coexaminer}{}
\newcommand{\coexaminer}[1]{\renewcommand{\@coexaminer}{#1}}
\newcommand{\@issuedate}{}
\newcommand{\issuedate}[1]{\renewcommand{\@issuedate}{\ifthenelse{\equal{#1}{}}{\today}{#1}}}
\newcommand{\@submissiondate}{}
\newcommand{\submissiondate}[1]{\renewcommand{\@submissiondate}{#1}}
\newcommand{\@place}{Ulm}
\newcommand{\place}[1]{\renewcommand{\@place}{\ifthenelse{\equal{#1}{}}{Ulm}{#1}}}
\newcommand{\projectdescription}[1]{}

%%% v1.4: added for "confidential" option
\newcommand{\@confidentialMainText}{\ifthenelse{\boolean{en}}{--- Do Not Publish! ---}{--- Nicht ver\"offentlichen! ---}}
\newcommand{\@confidentialSubText}{\ifthenelse{\boolean{en}}{Please keep confidential and do not pass to any third parties!}{Bitte vertraulich behandeln und nicht an Dritte weitergeben!}}
\newcommand{\confidentialMainText}[1]{\renewcommand{\@confidentialMainText}{#1}}
\newcommand{\confidentialSubText}[1]{\renewcommand{\@confidentialSubText}{#1}}
% Background picture omitted for optical reasons
%\newcommand{\@confidentialBGPicText}{\ifthenelse{\boolean{en}}{CONFIDENTIAL}{VERTRAULICH}}
%\newboolean{confidentialBGPicture}
%\setboolean{confidentialBGPicture}{true}
%\newcommand{\confidentialBGPicText}[1]{\ifthenelse{\equal{#1}{}}{\setboolean{confidentialBGPicture}{false}}{\setboolean{confidentialBGPicture}{true}}\renewcommand{\@confidentialBGPicText}{#1}}
%\@onlypreamble\confidentialBGPicText



\@onlypreamble\descriptiontitle
\@onlypreamble\affirmationtitle
\@onlypreamble\authortitle
\@onlypreamble\supervisor
\@onlypreamble\examiner
\@onlypreamble\coexaminer
\@onlypreamble\issuedate
\@onlypreamble\submissiondate
\@onlypreamble\place
\@onlypreamble\confidentialMainText
\@onlypreamble\confidentialSubText


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%switch thesis in correct language
\ifthenelse{\equal{\mrm@thesis}{master}}{}{}
\ifthenelse{\equal{\mrm@thesis}{diplom}}{\renewcommand{\@thesis}{\ifthenelse{\boolean{en}}{Diploma Thesis}{Diplomarbeit}}}{}
\ifthenelse{\equal{\mrm@thesis}{stud}}{\renewcommand{\@thesis}{\ifthenelse{\boolean{en}}{Student Research Project}{Studienarbeit}}}{}
\ifthenelse{\equal{\mrm@thesis}{bachelor}}{\renewcommand{\@thesis}{\ifthenelse{\boolean{en}}{Bachelor's Thesis}{Bachelorarbeit}}}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand*{\chapterpagestyle}{scrplain}
\KOMAoptions{cleardoublepage=scrplain}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%force seriffont
\addtokomafont{sectioning}{\rmfamily}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%setup headings
\pagestyle{scrheadings}
\clearscrheadfoot                                         %clear all default settings
\setheadsepline{1pt}                                      %seperator between headline and text

\if@mainmatter
  \newcommand{\ifnosection}{\ifthenelse{\equal{\headmark}{}}{%
                            \thechapter\ \leftmark}{\rightmark}}
  \renewcommand{\chaptermark}[1]{\markboth{#1}{}}         %chapter without chapternumber
  \rehead[]{\headmark}                                    %inner leftside chapter WITHOUT number
  \lohead[]{\ifnosection}                                 %inner rightside if section, section, else chapter WITH number
\fi \ohead[]{\pagemark}                                       %pagemark outer on each page

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%table of contents
\setcounter{tocdepth}{3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%using und configuration of biblatex instead of bibtex
%v1.6: Default backend changed to biber, new own bib style included
\ifthenelse{\boolean{mrm@backendbibtex}}{%bibtex was chosen
    \RequirePackage[style=mrmbibstyle,sorting=anyvt,
                    sortcites=true,firstinits=false,%
                    useprefix=false,%
                    uniquename=init,hyperref=auto,%
                    minnames=3,maxnames=5,%
                    minitems=3,maxitems=99,%
                    minalphanames=3,maxalphanames=4,
                    maxcitenames=99,%
                    autopunct=false,%
        %v1.2: added option backend=bibtex8 for input enconding with latin1
                    bibwarn=true, % Warnings for errors in bibfile, default: true
                    backend=bibtex8]{biblatex}}%
{%Default option, biber is biblatex backend
    \RequirePackage[style=mrmbibstyle,sorting=anyvt,
                    sortcites=true,firstinits=false,%
                    useprefix=false,%
                    uniquename=init,hyperref=auto,%
                    minnames=3,maxnames=5,%
                    minitems=3,maxitems=99,%
                    minalphanames=3,maxalphanames=4,
                    maxcitenames=99,%
                    autopunct=false,%
                    bibwarn=true, % Warnings for errors in bibfile, default: true
                    backend=biber]{biblatex}}
\ifthenelse{\boolean{en}}{%
  \RequirePackage[autostyle=try,english=american]{csquotes}}{%
  \RequirePackage[autostyle=try,german=quotes]{csquotes}} %provides advanced facilities for inline and display quotations
                                                          % autostyle=try -> option controls multilingual support, requires babel,
                                                          % will not issue any warnings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%titlepage
\renewcommand{\maketitle}{%
  \if@frontmatter
  \begin{titlepage}
%%% TEST ONLY    \setcounter{page}\m@ne %\cleardoublepage below should be replaced by \newapge, \thispagesytel{empty} and \setcounter{page}{0}
    \@header
      \vfill

    \begin{center}
      \Huge \textsf{\textbf{\@title}}

      \vspace{2cm}
      \Large \textsf{\@thesis}

      \vspace{0.4cm}
      \large \textsf{\ifthenelse{\boolean{en}}{by}{von}}

      \vspace{0.4cm}
      \Large
      % v1.6: added option for title in front of or behind name
      \ifthenelse{\boolean{mrm@namebehindauthortitle}}{%title in front of name
            \textsf{\@ifprint{\@authortitle}{\@authortitle\ }\@author}%
        }{% title behind name
            \textsf{\@author\@ifprint{\@authortitle}{,\ \@authortitle}}%
        }

      \vspace{1.0cm}
      \normalsize \textsf{\@submissiondate}
    \end{center}
%%% v1.4: added for "confidential" option
     \ifthenelse{\boolean{mrm@confidential}}{%
        \vfill
        \begin{center}
        \Large \textcolor{mrmconfcolor}{\textsf{\@confidentialMainText}}\\
        \large \textcolor{mrmconfcolor}{\textsf{\@confidentialSubText}}%
        \end{center}
% Background picture omitted for optical reasons
%        \ifthenelse{\boolean{confidentialBGPicture}}{%resizebox works only if text is not empty
%            \AddToShipoutPictureBG*{%
%                \setlength{\unitlength}{0.1cm}%
%                \put(25,35){\rotatebox{54.7}{\resizebox{22cm}{!}{\textcolor{mrmconfcolor!10}{\textsf{\@confidentialBGPicText}}}}}%
%            }%
%        }{}%
      }{}
%%% end of "confidential" part
     \vfill
    \begin{minipage}[b]{\textwidth}
      \begin{center}
        \normalsize
        \parbox{0cm}{\textsf{
          \begin{tabbing}{l l}
            Links2345678 \= Rechts23456789012345678 \kill
            \ifthenelse{\boolean{en}}
            {Supervisor:              \>\@supervisor  \\[5pt]
            Examiner:               \>\@examiner    \\
            \@ifprint{\@coexaminer}{Co-examiner:} \>\@coexaminer  \\}
            {Betreuer:               \>\@supervisor  \\[5pt]
            1. Pr\"ufer:             \>\@examiner   \\
            \@ifprint{\@coexaminer}{2. Pr\"ufer:} \>\@coexaminer \\}
          \end{tabbing}}}
       \end{center}
     \end{minipage}
     \vspace*{-2.8cm}
  \end{titlepage}
  \cleardoublepage
%%% v1.4: page numbering changed (no frontmatter starts with title page), the following
%%%       \setcounter command was removed
%  \setcounter{page}{1}
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%project description
\renewcommand{\projectdescription}[1]{%
  \if@frontmatter
  \thispagestyle{empty}
  \@header
   \begin{center}
      \large \textsf{\@thesis}

      \Large \textbf{\textsf{\@dtitle}}
  \end{center}

    \normalsize \textsf{#1}

  \vfill
    \vspace*{-2.4cm} %-1.5cm
    \rule{\textwidth}{0.2pt}

    %v1.6: added author title to project description page
    \begin{minipage}[b]{\textwidth}{
          \sffamily
          \begin{tabular*}{\textwidth}{@{}l@{\hspace{1cm}}l@{}} \ifthenelse{\boolean{en}}
            {Date of issue:            & \@issuedate       \\
            Date of submission:        & \@submissiondate  \\[2pt]
            Author:                    & \ifthenelse{\boolean{mrm@namebehindauthortitle}}{\textsf{\@ifprint{\@authortitle}{\@authortitle\ }\@author}}{\@author\@ifprint{\@authortitle}{,\ \@authortitle}} \\
            Supervisor:                & \@supervisor       \\[2pt]
            Examiner:                  & \@examiner         \\
            \@ifprint{\@coexaminer}{Co-examiner:} & \@coexaminer       \\}
            {Ausgabedatum:             & \@issuedate        \\
            Abgabedatum:               & \@submissiondate   \\[3pt]
            \@authorlabel:             & \ifthenelse{\boolean{mrm@namebehindauthortitle}}{\textsf{\@ifprint{\@authortitle}{\@authortitle\ }\@author}}{\@author\@ifprint{\@authortitle}{,\ \@authortitle}} \\
            \@supervisorlabel:         & \@supervisor       \\[3pt]
            1. Pr\"ufer:               & \@examiner         \\
            \@ifprint{\@coexaminer}{2. Pr\"ufer:} & \@coexaminer      \\}
          \end{tabular*}}
   \end{minipage}
   \vspace*{-2.8cm}
\newpage \cleardoublepage \fi }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%affirmation
\ifthenelse{\boolean{en}}{ \newcommand{\affirmation}{
    \if@frontmatter
    \thispagestyle{empty}
      \mbox{}\vfill

    I hereby declare that this thesis titled:
    \begin{center}
      \textbf{\@atitle}
    \end{center}
    is the product of my own independent work and that I have used no other sources and
    materials than those specified. The passages taken from other works,
    either verbatim or paraphrased in the spirit of the original quote, are
    identified in each individual case by indicating the source.\\
    I further declare that all my academic work has been written in line with the
    principles of proper academic research according to the official ``Satzung
    der Universit\"at Ulm zur Sicherung guter wissenschaftlicher Praxis''
    (University Statute for the Safeguarding of Proper Academic Practice).
\\

    \begin{flushleft}
      \@place, \@submissiondate

      \vspace{2cm} \hspace{1cm} \@author
    \end{flushleft}
    \vspace*{-2.2cm}
    \newpage
    \cleardoublepage
    \fi
}}{ \newcommand{\affirmation}{
    \if@frontmatter
    \thispagestyle{empty}
      \mbox{}\vfill

    Hiermit versichere ich, dass ich die vorliegende Arbeit mit dem Titel
    \begin{center}
      \textbf{\@atitle}
    \end{center}
    bis auf die offizielle Betreuung selbstst\"andig und ohne fremde Hilfe angefertigt habe und
    die benutzten Quellen und Hilfsmittel vollst\"andig angegeben sind. Aus fremden Quellen direkt
    oder indirekt \"ubernommene Gedanken sind jeweils unter Angabe der Quelle als solche kenntlich
    gemacht.\\
    Ich erkl\"are au{\ss}erdem, dass die vorliegende Arbeit entsprechend den Grunds\"atzen guten
    wissenschaftlichen Arbeitens gem\"a{\ss} der \glqq{}Satzung der Universit\"at Ulm zur Sicherung
    guter wissenschaftlicher Praxis\grqq{} erstellt wurde. \\

    \begin{flushleft}
      \@place, den \@submissiondate

      \vspace{2cm} \hspace{1cm} \@author
    \end{flushleft}
    \vspace*{-2.2cm}
    \newpage
    \cleardoublepage
    \fi
}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%extrafrontchapter i.e. foreword, thanks
\newcommand{\extrafrontchapter}[2]{
  \if@frontmatter
  \chapter*{#1}
  \pagestyle{scrplain}
  #2
  \newpage
  \cleardoublepage
  \pagestyle{scrheadings}
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\KOMAoptions{headinclude=true,BCOR=\mrm@BCOR,DIV=12}
\recalctypearea
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
