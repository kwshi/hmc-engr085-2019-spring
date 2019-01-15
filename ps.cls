\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2018/12/26 E85 p-set class]

\LoadClass[twoside]{article}

% load packages
%% basic packages
\RequirePackage[ascii]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{microtype}

%% for document setup
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{titling}

%% fonts and text styles
\RequirePackage{lmodern}
\RequirePackage{fouriernc}
\RequirePackage{parskip}

%% math
\RequirePackage{
  amsmath,
  amsthm,
  amssymb,
  amsfonts,
}
\RequirePackage{mathtools, thmtools}

%% utility packages
\RequirePackage{mdframed}
\RequirePackage{cancel}
\RequirePackage{lastpage}
\RequirePackage{multicol}
\RequirePackage{color}
\RequirePackage{tikz}
\RequirePackage{hyperref}
\RequirePackage{marginnote}
\RequirePackage{isomath}
\RequirePackage{nicematrix}
\RequirePackage{centernot}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{enumitem}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{minted}
\RequirePackage{siunitx}
\RequirePackage{tabu}
\RequirePackage{makecell}
\RequirePackage{changepage}
\RequirePackage{longtable}
\RequirePackage[compatibility]{circuitikz}

% document setup
%% page dimensions
\geometry{
  top=.5in,
  bottom=.75in,
  right=1in,
  left=1in,
  headheight=2em,
  headsep=1em,
  marginparwidth=1.125in,
  marginparsep=.125in,
  includeheadfoot,
}

%% document metadata
\newcommand{\thecourse}{E85: Digital Design and Computer Engineering}
\newcommand{\ps}[1]{\newcommand{\theps}{#1}}
\newcommand{\thecoauthor}{}
\newcommand{\coauthor}[1]{\renewcommand{\thecoauthor}{#1}}

%% page decoration
\fancypagestyle{ps}{
  \fancyhf{}
  \chead{
    \textbf{\thecourse}\\
    \textbf{Problem Set \theps}
  }
  \rhead{{\small\mbox{\theauthor}}\\{\small\thecoauthor}}
  \cfoot{Page \thepage{} of \pageref{LastPage}}
  \lfoot{\small\textsc{\thedate}}
  \renewcommand{\headrulewidth}{0pt}
}
\pagestyle{ps}

%% mdframed spacing
\mdfsetup{
  skipabove=1em,
  skipbelow=1em,
}

%% list styles
\setlist[enumerate, 1]{label=\arabic*)}
\setlist[enumerate, 2]{label=\alph*)}
\setlist[enumerate, 3]{label=\roman*.}
\setlist[enumerate, 4]{label=\alph*)}

%% hyperlink styles
\hypersetup{
  colorlinks=true,
  urlcolor=blue!50!green,
  linkcolor=blue!50!green,
}

%% code listing styles
\usemintedstyle{bw}

%% tikz packages
\usetikzlibrary{
  calc,
  positioning,
  circuits.logic.US,
  circuits.logic.IEC,
  circuits.ee,
  circuits.ee.IEC,
}

%% circuitikz options
\ctikzset{
  bipoles/length=1cm,
  bipoles/thickness=1,
  bipoles/resistor/width=.75,
  bipoles/resistor/height=.125,
  bipoles/diode/width=.25,
  bipoles/diode/height=.25,
  bipoles/vsourceam/width=.75,
  bipoles/vsourceam/height=.75,
  monopoles/ground/width=.25,
  tripoles/pmos/height=1,
  tripoles/pmos/width=.5,
  tripoles/pmos/gate height=.5,
  tripoles/pmos/base height=.625,
  tripoles/nmos/height=1,
  tripoles/nmos/width=.5,
  tripoles/nmos/gate height=.5,
  tripoles/nmos/base height=.625,
}

%% siunitx options
\sisetup{
  per-mode=symbol,
  detect-all,
}

% pset-related environments & commands
\newenvironment{solution}{\begin{mdframed}}{\end{mdframed}}
\newcommand{\twocolumnlisting}[6]{
  \begin{tabular}{
    p{\dimexpr.5\linewidth-2\tabcolsep-\arrayrulewidth}|
    p{\dimexpr.5\linewidth-2\tabcolsep-\arrayrulewidth}
    }
    \toprule
    \textbf{#1}
    &\textbf{#4}\\
    \inputminted[fontsize=\footnotesize]{#2}{#3}
    &\inputminted[fontsize=\footnotesize]{#5}{#6}\\
    \bottomrule
  \end{tabular}
}
\newcommand{\figurebelow}{\textcolor{gray}{(figure below)}}

% math commands
\renewcommand{\vec}{\mathbfit}
\newcommand{\mat}{\mathbf}

%% common blackboard-bold symbols
\newcommand{\ZZ}{\mathbb Z}
\newcommand{\RR}{\mathbb R}
\newcommand{\QQ}{\mathbb Q}
\newcommand{\CC}{\mathbb C}
\newcommand{\KK}{\mathbb K}
\newcommand{\NN}{\mathbb N}
\newcommand{\PP}{\mathbb P}
\newcommand{\VV}{\mathbb V}

% transpose and complement
\newcommand{\T}{\mathsf{T}}
\renewcommand{\complement}{\mathsf{C}}

%% differential operators
\newcommand{\odif}{\mathop{}\! \mathrm d}
\newcommand{\dif}{\odif}
\newcommand{\pdif}{\mathop{}\! \partial}

\newcommand{\od}[3][]{\frac{\odif^{#1} {#2}}{\odif {#3}^{#1}}}
\newcommand{\pd}[3][]{\frac{\pdif^{#1} {#2}}{\pdif {#3}^{#1}}}

%% brackets & delimiters
\newcommand{\abs}[1]{\left\lvert {#1} \right\rvert}
\newcommand{\norm}[1]{\left\lVert {#1} \right\rVert}
\newcommand{\abracket}[1]{\left\langle {#1} \right\rangle}
\newcommand{\inner}{\abracket}
\newcommand{\floor}[1]{\left\lfloor {#1} \right\rfloor}
\newcommand{\ceil}[1]{\left\lceil {#1} \right\rceil}
\newcommand{\paren}[1]{\left( {#1} \right)}
\newcommand{\bracket}[1]{\left[ {#1} \right]}
\newcommand{\curly}[1]{\left\{ {#1} \right\}}
\newcommand{\set}{\curly}
\newcommand{\eval}[1]{\bigg\rvert_{#1}}
\newcommand{\setst}[2]{\set{{#1} \; : \; {#2}}}