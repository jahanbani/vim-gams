" vim-gams autoload functions
" Author: vim-gams contributors
" License: MIT

" ============================================================================
" UTILITY FUNCTIONS
" ============================================================================

" Check if current buffer is a GAMS file
function! gams#IsGamsFile()
  return &filetype == 'gams' || expand('%:e') == 'gms' || expand('%:e') == 'lst'
endfunction

" Get GAMS file type
function! gams#GetFileType()
  let ext = expand('%:e')
  if ext == 'gms'
    return 'model'
  elseif ext == 'lst'
    return 'listing'
  elseif ext == 'inc'
    return 'include'
  elseif ext == 'dat'
    return 'data'
  else
    return 'unknown'
  endif
endfunction

" ============================================================================
" FORMATTING FUNCTIONS
" ============================================================================

" Format GAMS file
function! gams#FormatFile()
  if !gams#IsGamsFile()
    echo "Not a GAMS file"
    return
  endif
  
  " Save cursor position
  let save_cursor = getpos(".")
  
  " Remove trailing whitespace
  silent! %s/\s\+$//e
  
  " Ensure proper line endings
  silent! %s/\r$//e
  
  " Fix comment alignment (optional)
  if exists('g:gams_align_comments') && g:gams_align_comments
    call gams#AlignComments()
  endif
  
  " Restore cursor position
  call setpos(".", save_cursor)
  
  echo "GAMS file formatted"
endfunction

" Align comments in GAMS file
function! gams#AlignComments()
  let lines = getline(1, '$')
  let max_code_length = 0
  
  " Find maximum code length before comments
  for line in lines
    let comment_pos = stridx(line, '*')
    if comment_pos > 0
      let code_length = len(substitute(line[:comment_pos-1], '\s*$', '', ''))
      if code_length > max_code_length
        let max_code_length = code_length
      endif
    endif
  endfor
  
  " Align comments
  for i in range(1, len(lines))
    let line = lines[i-1]
    let comment_pos = stridx(line, '*')
    if comment_pos > 0
      let code_part = substitute(line[:comment_pos-1], '\s*$', '', '')
      let comment_part = line[comment_pos:]
      let padding = repeat(' ', max(1, max_code_length - len(code_part)))
      let lines[i-1] = code_part . padding . comment_part
    endif
  endfor
  
  call setline(1, lines)
endfunction

" ============================================================================
" TEMPLATE FUNCTIONS
" ============================================================================

" Insert GAMS template
function! gams#InsertTemplate(template_type)
  let templates = {
    \ 'basic': [
    \   '$title Basic GAMS Model',
    \   '',
    \   'sets',
    \   '    i / 1*10 /',
    \   '    j / 1*5  /',
    \   ';',
    \   '',
    \   'parameters',
    \   '    c(i,j) /',
    \   '    /;',
    \   '',
    \   'variables',
    \   '    x(i,j)',
    \   '    obj',
    \   ';',
    \   '',
    \   'equations',
    \   '    objective',
    \   '    constraint(i)',
    \   ';',
    \   '',
    \   'objective.. obj =e= sum((i,j), c(i,j) * x(i,j));',
    \   '',
    \   'constraint(i).. sum(j, x(i,j)) =l= 1;',
    \   '',
    \   'model example / all /;',
    \   'solve example using lp minimizing obj;',
    \ ],
    \ 'transport': [
    \   '$title Transportation Problem',
    \   '',
    \   'sets',
    \   '    i "sources" / 1*3 /',
    \   '    j "destinations" / 1*4 /',
    \   ';',
    \   '',
    \   'parameters',
    \   '    supply(i) "supply at source i"',
    \   '    demand(j) "demand at destination j"',
    \   '    cost(i,j) "unit cost of transport"',
    \   ';',
    \   '',
    \   'variables',
    \   '    x(i,j) "shipment quantities"',
    \   '    z "total cost"',
    \   ';',
    \   '',
    \   'equations',
    \   '    supply_balance(i) "supply limit"',
    \   '    demand_balance(j) "demand requirement"',
    \   '    objective "total cost"',
    \   ';',
    \   '',
    \   'supply_balance(i).. sum(j, x(i,j)) =l= supply(i);',
    \   '',
    \   'demand_balance(j).. sum(i, x(i,j)) =g= demand(j);',
    \   '',
    \   'objective.. z =e= sum((i,j), cost(i,j) * x(i,j));',
    \   '',
    \   'model transport / all /;',
    \   'solve transport using lp minimizing z;',
    \ ],
    \ 'include': [
    \   '$title Include File',
    \   '',
    \   '* This is an include file for GAMS',
    \   '* Add your common definitions here',
    \   '',
    \   'sets',
    \   '    common_set / 1*10 /',
    \   ';',
    \   '',
    \   'parameters',
    \   '    common_parameter',
    \   ';',
    \ ]
    \ }
  
  if !has_key(templates, a:template_type)
    echo "Unknown template type: " . a:template_type
    echo "Available templates: " . join(keys(templates), ', ')
    return
  endif
  
  " Insert template at cursor position
  call append(line('.'), templates[a:template_type])
  echo "Inserted " . a:template_type . " template"
endfunction

" ============================================================================
" ANALYSIS FUNCTIONS
" ============================================================================

" Analyze GAMS file structure
function! gams#AnalyzeFile()
  if !gams#IsGamsFile()
    echo "Not a GAMS file"
    return
  endif
  
  let lines = getline(1, '$')
  let analysis = {
    \ 'sets': [],
    \ 'parameters': [],
    \ 'variables': [],
    \ 'equations': [],
    \ 'models': [],
    \ 'dollar_commands': [],
    \ 'includes': []
    \ }
  
  for line in lines
    let line = tolower(line)
    
    " Find sets
    if line =~ '^\s*sets\?'
      let set_match = matchstr(line, 'sets\?\s\+\([^;]*\)')
      if set_match != ''
        call add(analysis.sets, substitute(set_match, '^\s*sets\?\s\+', '', ''))
      endif
    endif
    
    " Find parameters
    if line =~ '^\s*parameters\?'
      let param_match = matchstr(line, 'parameters\?\s\+\([^;]*\)')
      if param_match != ''
        call add(analysis.parameters, substitute(param_match, '^\s*parameters\?\s\+', '', ''))
      endif
    endif
    
    " Find variables
    if line =~ '^\s*variables\?'
      let var_match = matchstr(line, 'variables\?\s\+\([^;]*\)')
      if var_match != ''
        call add(analysis.variables, substitute(var_match, '^\s*variables\?\s\+', '', ''))
      endif
    endif
    
    " Find equations
    if line =~ '^\s*equations\?'
      let eq_match = matchstr(line, 'equations\?\s\+\([^;]*\)')
      if eq_match != ''
        call add(analysis.equations, substitute(eq_match, '^\s*equations\?\s\+', '', ''))
      endif
    endif
    
    " Find models
    if line =~ '^\s*models\?'
      let model_match = matchstr(line, 'models\?\s\+\([^;]*\)')
      if model_match != ''
        call add(analysis.models, substitute(model_match, '^\s*models\?\s\+', '', ''))
      endif
    endif
    
    " Find dollar commands
    if line =~ '^\s*\$'
      let dollar_match = matchstr(line, '^\s*\(\$[a-zA-Z]\+\)')
      if dollar_match != ''
        call add(analysis.dollar_commands, dollar_match)
      endif
    endif
    
    " Find includes
    if line =~ '\$include'
      let include_match = matchstr(line, '\$include\s\+\([^$]*\)')
      if include_match != ''
        call add(analysis.includes, substitute(include_match, '^\s*\$include\s\+', '', ''))
      endif
    endif
  endfor
  
  " Display analysis
  echo "GAMS File Analysis:"
  echo "=================="
  echo "Sets: " . len(analysis.sets)
  echo "Parameters: " . len(analysis.parameters)
  echo "Variables: " . len(analysis.variables)
  echo "Equations: " . len(analysis.equations)
  echo "Models: " . len(analysis.models)
  echo "Dollar Commands: " . len(analysis.dollar_commands)
  echo "Includes: " . len(analysis.includes)
  
  return analysis
endfunction

" ============================================================================
" COMMAND FUNCTIONS
" ============================================================================

" Run GAMS on current file
function! gams#RunGams()
  if !gams#IsGamsFile()
    echo "Not a GAMS file"
    return
  endif
  
  let filename = expand('%:p')
  let gams_exe = exists('g:gams_executable') ? g:gams_executable : 'gams'
  
  " Check if GAMS is available
  if !executable(gams_exe)
    echo "GAMS executable not found. Set g:gams_executable to your GAMS path"
    return
  endif
  
  " Run GAMS
  let cmd = gams_exe . ' "' . filename . '"'
  echo "Running: " . cmd
  
  if has('job')
    " Use job for async execution
    call job_start(cmd, {'callback': 'gams#JobCallback'})
  else
    " Fallback to synchronous execution
    let output = system(cmd)
    echo output
  endif
endfunction

" Job callback for async GAMS execution
function! gams#JobCallback(channel, message)
  echo "GAMS: " . a:message
endfunction

" ============================================================================
" INITIALIZATION
" ============================================================================

" Initialize plugin
function! gams#Init()
  " Set default values if not already set
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
  
  if !exists('g:gams_align_comments')
    let g:gams_align_comments = 0
  endif
  
  if !exists('g:gams_auto_format')
    let g:gams_auto_format = 0
  endif
  
  echo "vim-gams initialized"
endfunction 