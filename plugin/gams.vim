" vim-gams plugin configuration
" Author: vim-gams contributors
" License: MIT

" Prevent loading twice
if exists('g:loaded_vim_gams')
  finish
endif
let g:loaded_vim_gams = 1

" Default configuration
if !exists('g:gams_enable_lst_highlighting')
  let g:gams_enable_lst_highlighting = 1
endif

if !exists('g:gams_highlight_equation_components')
  let g:gams_highlight_equation_components = 1
endif

if !exists('g:gams_comment_char')
  let g:gams_comment_char = '*'
endif

if !exists('g:gams_smart_indent')
  let g:gams_smart_indent = 1
endif

" Enhanced indentation settings
if g:gams_smart_indent
  setlocal smartindent
  setlocal autoindent
  setlocal cinwords+=set,sets,parameter,parameters,equation,equations,variable,variables,table,SET,SETS,PARAMETER,PARAMETERS,EQUATION,EQUATIONS,VARIABLE,VARIABLES,TABLE,scalar,scalars,SCALAR,SCALARS,model,models,MODEL,MODELS
endif

" Configure comment character
if g:gams_comment_char == '*'
  setlocal commentstring=*\ %s
else
  execute 'setlocal commentstring=' . g:gams_comment_char . '\ %s'
endif

" Set tab settings for GAMS
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

" Enable syntax folding
if has('folding')
  setlocal foldmethod=syntax
  setlocal foldlevel=1
endif

" Set text width for GAMS (common practice)
setlocal textwidth=80

" Enable spell checking in comments only
if has('spell')
  setlocal spell
  setlocal spelllang=en
endif

" Fix syntax highlighting for long lines
setlocal synmaxcol=0

" Auto-commands for GAMS files
augroup GamsAutoCommands
  autocmd!
  " Auto-format on save (optional)
  if exists('g:gams_auto_format') && g:gams_auto_format
    autocmd BufWritePre *.gms call s:FormatGamsFile()
  endif
  
  " Highlight TODO comments
  autocmd BufEnter *.gms,*.lst,*.inc,*.dat call s:HighlightTodos()
augroup END

" Function to format GAMS file
function! s:FormatGamsFile()
  " Basic formatting - remove trailing whitespace
  silent! %s/\s\+$//e
  " Ensure proper line endings
  silent! %s/\r$//e
endfunction

" Function to highlight TODO comments
function! s:HighlightTodos()
  " This is handled by syntax highlighting, but could be enhanced
  " with additional highlighting if needed
endfunction

" Command to toggle GAMS-specific features
command! -buffer GamsToggleLstHighlighting call s:ToggleLstHighlighting()
command! -buffer GamsToggleEquationHighlighting call s:ToggleEquationHighlighting()

function! s:ToggleLstHighlighting()
  let g:gams_enable_lst_highlighting = !g:gams_enable_lst_highlighting
  echo "LST highlighting: " . (g:gams_enable_lst_highlighting ? "enabled" : "disabled")
endfunction

function! s:ToggleEquationHighlighting()
  let g:gams_highlight_equation_components = !g:gams_highlight_equation_components
  echo "Equation component highlighting: " . (g:gams_highlight_equation_components ? "enabled" : "disabled")
  " Reapply syntax highlighting
  syntax sync fromstart
endfunction
