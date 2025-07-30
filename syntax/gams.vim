" Vim syntax file
" Language:        GAMS (General Algebraic Modeling System)
" Filenames:       *.gms, *.lst, *.inc, *.dat
" Maintainer:      vim-gams contributors
" License:         MIT
" Quit when a syntax file was already loaded

if exists("b:current_syntax")
  finish
endif

" GAMS is not case sensitive
syn case ignore

" ============================================================================
" SYNTAX HIGHLIGHTING SETTINGS FOR LONG LINES
" ============================================================================

" Increase syntax highlighting limits for long lines
setlocal synmaxcol=0
setlocal syntax=on

" ============================================================================
" STRINGS AND CHARACTERS (MOVED EARLY FOR PRECEDENCE)
" ============================================================================

" String constants - Define early to take precedence
syn region gamsString matchgroup=Delimiter start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region gamsString matchgroup=Delimiter start=+'+  skip=+\\\\\|\\"+  end=+'+

" ============================================================================
" KEYWORDS AND STATEMENTS
" ============================================================================

" Core GAMS statements and keywords
syn keyword gamsStatement       solve using
syn keyword gamsStatement       display
syn keyword gamsStatement       option
syn keyword gamsStatement       alias
syn keyword gamsStatement       abort
syn keyword gamsStatement       free semicont semiint sos1 sos2 binary integer
syn keyword gamsStatement       positive negative variable variables
syn keyword gamsStatement       xxpto

" Additional GAMS keywords from official documentation
syn keyword gamsStatement       scalar scalars
syn keyword gamsStatement       table tables
syn keyword gamsStatement       model models
syn keyword gamsStatement       set sets
syn keyword gamsStatement       parameter parameters
syn keyword gamsStatement       equation equations
syn keyword gamsStatement       variable variables
syn keyword gamsStatement       file files
syn keyword gamsStatement       put putclose putpage puttl puthd
syn keyword gamsStatement       loop while repeat until for to downto by
syn keyword gamsStatement       if else elseif endif
syn keyword gamsStatement       card ord
syn keyword gamsStatement       sum prod smax smin
syn keyword gamsStatement       abs ceil floor round trunc
syn keyword gamsStatement       sin cos tan asin acos atan
syn keyword gamsStatement       sinh cosh tanh asinh acosh atanh
syn keyword gamsStatement       exp log log10 sqrt power
syn keyword gamsStatement       uniform normal beta gamma
syn keyword gamsStatement       errorf entropy fact
syn keyword gamsStatement       mapval mod div
syn keyword gamsStatement       sign signpower
syn keyword gamsStatement       time ctime
syn keyword gamsStatement       eps na undf inf
syn keyword gamsStatement       yes no
syn keyword gamsStatement       all

" Logical operators - Moved to gamsStatement for better highlighting
syn keyword gamsStatement       and or xor not
syn keyword gamsStatement       sameas

" Model types and solver options
syn keyword gamsStatement       lp mip nlp mcp mpec cns dnlp minlp qcp
syn keyword gamsStatement       miqcp rmip rminlp rmiqcp
syn keyword gamsStatement       cplex gurobi xpress mosek
syn keyword gamsStatement       ipopt knitro conopt snopt
syn keyword gamsStatement       baron antigone couenne
syn keyword gamsStatement       path mpec

" GAMS control statements
syn keyword gamsStatement       stop
syn keyword gamsStatement       execute execute_load execute_unload
syn keyword gamsStatement       gdxin gdxout
syn keyword gamsStatement       include batinclude libinclude sysinclude
syn keyword gamsStatement       ontext offtext
syn keyword gamsStatement       onlisting offlisting
syn keyword gamsStatement       oneolcom offeolcom
syn keyword gamsStatement       onupper offupper
syn keyword gamsStatement       onwarning offwarning
syn keyword gamsStatement       onundf offundf
syn keyword gamsStatement       oneps offeps
syn keyword gamsStatement       onempty offempty
syn keyword gamsStatement       onmulti offmulti
syn keyword gamsStatement       onglobal offglobal
syn keyword gamsStatement       onput offput
syn keyword gamsStatement       onsymlist offsymlist
syn keyword gamsStatement       onsymxref offsymxref
syn keyword gamsStatement       onuellist offuellist
syn keyword gamsStatement       onuelxref offuelxref
syn keyword gamsStatement       ondigit offdigit
syn keyword gamsStatement       oninline offinline
syn keyword gamsStatement       onmargin offmargin
syn keyword gamsStatement       onnestcom offnestcom
syn keyword gamsStatement       onend offend

" GAMS system variables and functions
syn keyword gamsStatement       system fileSys
syn keyword gamsStatement       gdxxrw
syn keyword gamsStatement       limrow limcol
syn keyword gamsStatement       optfile optca optcr
syn keyword gamsStatement       savepoint
syn keyword gamsStatement       scaleopt
syn keyword gamsStatement       scenario

" Additional GAMS keywords from documentation
syn keyword gamsStatement       index
syn keyword gamsStatement       binomial
syn keyword gamsStatement       edist
syn keyword gamsStatement       ncpcm
syn keyword gamsStatement       ncpf
syn keyword gamsStatement       pi
syn keyword gamsStatement       poly
syn keyword gamsStatement       betareg
syn keyword gamsStatement       gammareg
syn keyword gamsStatement       logbeta
syn keyword gamsStatement       loggamma
syn keyword gamsStatement       uniformint
syn keyword gamsStatement       precision
syn keyword gamsStatement       sigmoid
syn keyword gamsStatement       asc

" Boolean values
syn keyword gamsYesNo           yes no

" ============================================================================
" CONTROL STRUCTURES AND LOGICAL OPERATORS
" ============================================================================

" Control structures
syn keyword gamsConditional     if else elseif ifi exist ife
syn match   gamsConditional     "\$"

" Loops and iteration
syn keyword gamsRepeat          loop while repeat until for to downto by

" ============================================================================
" MATHEMATICAL OPERATORS AND FUNCTIONS
" ============================================================================

" Mathematical operators - Enhanced highlighting
syn match   gamsMathsOperators "[-+^/]\|\*\*"
syn match   gamsMathsOperators "="
syn match   gamsMathsOperators "=="
syn match   gamsMathsOperators "<>"
syn match   gamsMathsOperators ">="
syn match   gamsMathsOperators "<="
syn match   gamsMathsOperators ">"
syn match   gamsMathsOperators "<"

" Comparison operators
syn match   gamsComparison     "<=>\|=\|->\|<>\|>\|<"
syn keyword gamsComparison     eq ne gt ge lt le eqv imp

" Mathematical and statistical functions - Enhanced highlighting
syn keyword gamsFunction       abs asc sigmoid sum ..
syn keyword gamsFunction       acos acosh asin asinh atan atan2
syn keyword gamsFunction       atanh ceil ctime cos cosh exp floor log log10
syn keyword gamsFunction       max min precision round sin sinh sqrt tan tanh sqrt
syn keyword gamsFunction       smax smin
syn keyword gamsFunction       time trunc div
syn keyword gamsFunction       beta betareg binomial edist entropy errorf fact
syn keyword gamsFunction       gamma gammareg logbeta loggamma normal
syn keyword gamsFunction       mapval mod ncpcm ncpf pi poly power
syn keyword gamsFunction       sign signpower trunc uniform uniformint

" Special GAMS functions - Enhanced highlighting
syn keyword gamsSpecialFunction card ord

" ============================================================================
" EXECUTION TIME COMMANDS
" ============================================================================

" GDX commands
syn keyword gamsSpecial        execute_load execute_unload

" ============================================================================
" DOLLAR COMMANDS
" ============================================================================

" Dollar command region
syn region gamsDollarCommand matchgroup=gamsDollarCommandName start="^\$[[:alpha:]]\+" end="$" transparent

" Include and file commands
syn match gamsSpecial "\$include"
syn match gamsSpecial "\$batinclude"
syn match gamsSpecial "\$libinclude"
syn match gamsSpecial "\$sysinclude"
syn match gamsSpecial "\$gdxin"
syn match gamsSpecial "\$gdxout"
syn match gamsSpecial "\$load"
syn match gamsSpecial "\$unload"

" Control flow commands
syn match gamsSpecial "\$if"
syn match gamsSpecial "\$ifi"
syn match gamsSpecial "\$endif"
syn match gamsSpecial "\$endifi"
syn match gamsSpecial "\$iftheni"
syn match gamsSpecial "\$ifthene"
syn match gamsSpecial "\$goto"
syn match gamsSpecial "\$label"
syn match gamsSpecial "\$exit"
syn match gamsSpecial "\$kill"
syn match gamsSpecial "\$abort"
syn match gamsSpecial "\$terminate"
syn match gamsSpecial "\$stop"

" Output control commands
syn match gamsSpecial "\$offlisting"
syn match gamsSpecial "\$onlisting"
syn match gamsSpecial "\$oneolcom"
syn match gamsSpecial "\$offeolcom"
syn match gamsSpecial "\$stars"
syn match gamsSpecial "\$comment"
syn match gamsSpecial "\$dollar"
syn match gamsSpecial "\$double"
syn match gamsSpecial "\$single"
syn match gamsSpecial "\$echo"
syn match gamsSpecial "\$echon"
syn match gamsSpecial "\$eject"
syn match gamsSpecial "\$error"
syn match gamsSpecial "\$escape"
syn match gamsSpecial "\$expose"
syn match gamsSpecial "\$hidden"
syn match gamsSpecial "\$hide"

" Variable and environment commands
syn match gamsSpecial "\$setglobal"
syn match gamsSpecial "\$dropglobal"
syn match gamsSpecial "\$setlocal"
syn match gamsSpecial "\$droplocal"
syn match gamsSpecial "\$setenv"
syn match gamsSpecial "\$setnames"
syn match gamsSpecial "\$onglobal"
syn match gamsSpecial "\$offglobal"
syn match gamsSpecial "\$setargs"
syn match gamsSpecial "\$onmulti"
syn match gamsSpecial "\$offmulti"
syn match gamsSpecial "\$onempty"
syn match gamsSpecial "\$offempty"

" Formatting and display commands
syn match gamsSpecial "\$inlinecom"
syn match gamsSpecial "\$lines"
syn match gamsSpecial "\$log"
syn match gamsSpecial "\$maxcol"
syn match gamsSpecial "\$mincol"
syn match gamsSpecial "\$offdigit"
syn match gamsSpecial "\$ondigit"
syn match gamsSpecial "\$offend"
syn match gamsSpecial "\$onend"
syn match gamsSpecial "\$offeps"
syn match gamsSpecial "\$oneps"
syn match gamsSpecial "\$offinline"
syn match gamsSpecial "\$oninline"
syn match gamsSpecial "\$offmargin"
syn match gamsSpecial "\$onmargin"
syn match gamsSpecial "\$offnestcom"
syn match gamsSpecial "\$onnestcom"

" Output commands
syn match gamsSpecial "\$onput"
syn match gamsSpecial "\$onputs"
syn match gamsSpecial "\$onputv"
syn match gamsSpecial "\$offput"

" Symbol and reference commands
syn match gamsSpecial "\$onsymlist"
syn match gamsSpecial "\$offsymlist"
syn match gamsSpecial "\$onsymxref"
syn match gamsSpecial "\$offsymxref"
syn match gamsSpecial "\$onuellist"
syn match gamsSpecial "\$offuellist"
syn match gamsSpecial "\$onuelxref"
syn match gamsSpecial "\$offuelxref"

" Warning and error control
syn match gamsSpecial "\$onundf"
syn match gamsSpecial "\$offundf"
syn match gamsSpecial "\$onupper"
syn match gamsSpecial "\$offupper"
syn match gamsSpecial "\$onwarning"
syn match gamsSpecial "\$offwarning"

" Utility commands
syn match gamsSpecial "\$phantom"
syn match gamsSpecial "\$prefixpath"
syn match gamsSpecial "\$protect"
syn match gamsSpecial "\$purge"
syn match gamsSpecial "\$remark"
syn match gamsSpecial "\$setcomps"
syn match gamsSpecial "\$setddlist"
syn match gamsSpecial "\$shift"
syn match gamsSpecial "\$show"

" Version compatibility
syn match gamsSpecial "\$use205"
syn match gamsSpecial "\$use225"
syn match gamsSpecial "\$use999"

" Title commands
syn match gamsSpecial "\$title"
syn match gamsSpecial "\$stitle"

" Evaluation commands
syn match gamsSpecial "\$option"
syn match gamsSpecial "\$call"
syn match gamsSpecial "\$eval"
syn match gamsSpecial "\$evalglobal"
syn match gamsSpecial "\$evallocal"

" Generic dollar command matcher
syn match gamsSpecial           "^\$\<[^ ]\+\>"

" ============================================================================
" NUMBERS AND CONSTANTS
" ============================================================================

" Integer numbers
syn match  gamsNumber           "\<\d\+\>"
syn match  gamsNumber           "\<[-+]\d\+\>"

" Floating point numbers
syn match  gamsNumber           "\<\d\+\.\d*\>"
syn match  gamsNumber           "\<[-+]\d\+\.\d*\>"
syn match  gamsNumber           "\<\.\d\+\>"
syn match  gamsNumber           "\<[-+]\.\d\+\>"

" Scientific notation
syn match gamsNumber '\<[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+\>'
syn match gamsNumber '\<\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+\>'

" Special numbers
syn keyword gamsNumber          eps na undf
syn match   gamsNumber          "[-+]inf"

" ============================================================================
" GAMS SUFFIXES AND ATTRIBUTES
" ============================================================================

" GAMS suffixes - Enhanced highlighting
syn keyword gamsSuffix          bm case cc cr data errors fx hdcc hdcr hdll ifile infeas
syn keyword gamsSuffix          l lj ll lo lp lw m nd nj nr nw nz ofile page pc prior ps pw
syn keyword gamsSuffix          range rdate rfile rtime scale sfile sj slack slackup slacklo sw
syn keyword gamsSuffix          te tf time title tj tl tlcc tlcr tlll tm ts tw
syn keyword gamsSuffix          up val ws

" GAMS suffixes with dot notation - Enhanced highlighting
syn match gamsSuffixDot         "\.[a-zA-Z][a-zA-Z0-9]*" contained

" ============================================================================
" EQUATION TYPES AND COMPONENTS
" ============================================================================

" Equation types (e.g. =e= or =G=) - Simple approach
syn match gamsEquationType      "=[cegln]="

" Enhanced equation component highlighting
if exists('g:gams_highlight_equation_components') && g:gams_highlight_equation_components
  " Highlight sets, parameters, variables within equations
  syn match gamsEquationComponent "\<[[:alpha:]][_[:alnum:]]*\>" contained
  syn match gamsEquationComponent "([^)]*)" contained
  " Highlight mathematical operators within equations
  syn match gamsEquationOperator "[-+*/^=<>]" contained
  syn match gamsEquationOperator "==" contained
  syn match gamsEquationOperator "<>" contained
  syn match gamsEquationOperator ">=" contained
  syn match gamsEquationOperator "<=" contained
endif

" String highlighting within equations - more specific and higher priority
syn match gamsString "'[^']*'" containedin=gamsEqn contained

" Additional aggressive string highlighting for single quotes
syn match gamsString "'[^']*'" contained

" Force string highlighting with higher priority
syn match gamsString "'[^']*'" containedin=gamsEqn

" New highlighting group for quoted strings in equations
syn match gamsQuotedString "'[^']*'" containedin=gamsEqn

" ============================================================================
" INCLUDES AND GLOBAL VARIABLES
" ============================================================================

" CSV file inclusion
syn region gamsInclude matchgroup=gamsDollarCommandName start="^\$ondelim" end="^\$offdelim"

" GAMS global variables e.g. %myglobal%
syn region gamsGlobalVar start="%" end="%\|\$"

" Command line parameters %1, %2, etc.
syn match  gamsInclude           "%\d\+"

" ============================================================================
" COMMENTS AND TODOS
" ============================================================================

" TODO and FIXME keywords in comments
syn keyword gamsTodo contained    TODO FIXME XXX NOTE JDM ASKJDM WHY ASK

" GAMS comments - FIXED: Proper comment highlighting
syn match  gamsComment           "^[[:space:]]*\*.*" contains=gamsTodo,@Spell
syn match  gamsComment           "#.*" contains=gamsTodo,@Spell
syn region gamsComment matchgroup=gamsDollarCommandName start="^\$ontext" end="^\$offtext" keepend contains=gamsTodo,@Spell

" ============================================================================
" GAMS DECLARATIONS AND STRUCTURES
" ============================================================================

" Item definitions with enhanced highlighting
syn region gamsItem matchgroup=gamsItemName start="\<[[:alpha:]][_[:alnum:]]*" skip="/[^/]*/" matchgroup=None end="\s*\(,\|;\|$\)" contained transparent contains=gamsItemComment,gamsItemDimension,gamsItemValues
syn region gamsItemDimension start="(" end=")" contained transparent keepend
syn region gamsItemComment start="\s[^/]" end=".\($\|/\|,\)\@=" contained contains=@Spell
syn region gamsItemValues matchgroup=Delimiter start=+/+ skip=+".*"+ end=+/+ transparent keepend contained contains=gamsComment,gamsString,gamsNumber

" Scalar declarations
syn region gamsScalar matchgroup=gamsDeclaration start=/^\s*scalars\{0,1\}\_s/ end=/;/ transparent keepend fold contains=gamsItemName,gamsNumber

" Equation declarations and definitions
syn region gamsEqn    matchgroup=Delimiter start=/\.\.\(\s\|\n\)/ end=/;/ fold transparent contains=gamsComment,gamsNumber,gamsConditional,gamsRepeat,gamsSuffix,gamsString,gamsFunction,gamsEquationType,gamsStatement,gamsQuotedString
syn region gamsEqDecl matchgroup=gamsDeclaration start=/^\s*equations\{0,1\}/ end=/;/ fold transparent keepend contains=gamsItem

" Variable declarations
syn region gamsVar matchgroup=gamsDeclaration start=/^\s*variables\{0,1\}/ end=/;/ fold transparent keepend contains=gamsItem

" Set declarations
syn region gamsSet matchgroup=gamsDeclaration start=/^\s*sets\{0,1\}/ end=/;/ fold transparent keepend contains=gamsItem

" Parameter declarations
syn region gamsParam matchgroup=gamsDeclaration start=/^\s*parameters\{0,1\}/ end=/;/ fold transparent keepend contains=gamsItem

" Table declarations
syn region gamsTable matchgroup=gamsDeclaration start=/^\s*tables\{0,1\}/ end=/;/ fold transparent contains=gamsNumber,gamsComment,gamsString

" Model declarations
syn region gamsModel matchgroup=gamsDeclaration start=/^\s*models\{0,1\}/ end=/;/ fold transparent keepend contains=gamsItem

" ============================================================================
" HIGHLIGHTING LINKS
" ============================================================================

" Link item comments to regular comments
hi def link gamsItemComment        gamsComment

" Standard highlighting groups
hi def link gamsLabel              Label
hi def link gamsConditional        Conditional
hi def link gamsRepeat             Repeat
hi def link gamsLineNumber         Comment
hi def link gamsNumber             Number
hi def link gamsError              Error
hi def link gamsStatement          Statement
hi def link gamsString             String
hi def link gamsComment            Comment
hi def link gamsSpecial            Special
hi def link gamsTodo               Todo
hi def link gamsFunction           Keyword
hi def link gamsDeclaration        Type
hi def link gamsInclude            Special
hi def link gamsSuffix             Operator
hi def link gamsSuffixDot          Special
hi def link gamsEquationType       Operator
hi def link gamsItemName           Function
hi def link gamsDollarCommandName  Include
hi def link gamsGlobalVar          Special
hi def link gamsYesNo              Constant
hi def link gamsMathsOperators     Operator
hi def link gamsComparison         Operator
hi def link gamsSpecialFunction    Function

" Enhanced equation component highlighting
if exists('g:gams_highlight_equation_components') && g:gams_highlight_equation_components
  hi def link gamsEquationComponent Identifier
  hi def link gamsEquationOperator  Operator
endif

" Link quoted strings to String highlighting
hi def link gamsQuotedString String

" Set current syntax
let b:current_syntax = "gams"

" vim: ts=4 expandtab
