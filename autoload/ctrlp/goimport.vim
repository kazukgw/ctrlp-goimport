if exists('g:loaded_ctrlp_goimport') && g:loaded_ctrlp_goimport
  finish
endif
let g:loaded_ctrlp_goimport = 1

let s:goimport_var = {
\  'init':   'ctrlp#goimport#init()',
\  'exit':   'ctrlp#goimport#exit()',
\  'accept': 'ctrlp#goimport#accept',
\  'lname':  'goimport',
\  'sname':  'goimport',
\  'type':   'goimport',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:goimport_var)
else
  let g:ctrlp_ext_vars = [s:goimport_var]
endif

function! ctrlp#goimport#init()
  let s = system('find $GOPATH/src -maxdepth 3 -type d | sed -e "s/$(echo $GOPATH | sed -E "s/([\/])/\\\\\1/g" )\/src\///g"')
  return split(s, "\n")
endfunc

function! ctrlp#goimport#accept(mode, str)
  call ctrlp#exit()
	exe "GoImport ". a:str
endfunction

function! ctrlp#goimport#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#goimport#id()
  return s:id
endfunction

" vim:ft=vim
