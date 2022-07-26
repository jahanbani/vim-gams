" set the filetype of gams overrulling other previously defined ones
au BufNewFile,BufRead *.gms set filetype=gams
au Filetype gms set filetype=gams
