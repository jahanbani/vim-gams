" File type detection for GAMS files
" Author: vim-gams contributors
" License: MIT

" GAMS model files
au BufNewFile,BufRead *.gms set filetype=gams

" GAMS listing files (optional, controlled by g:gams_enable_lst_highlighting)
au BufNewFile,BufRead *.lst call s:CheckLstFiletype()

" GAMS include files (optional)
au BufNewFile,BufRead *.inc set filetype=gams

" GAMS data files (optional)
au BufNewFile,BufRead *.dat set filetype=gams

" Function to check if LST highlighting should be enabled
function! s:CheckLstFiletype()
  " Default to enabled if not set
  if !exists('g:gams_enable_lst_highlighting')
    let g:gams_enable_lst_highlighting = 1
  endif
  
  if g:gams_enable_lst_highlighting
    set filetype=gams
  endif
endfunction
