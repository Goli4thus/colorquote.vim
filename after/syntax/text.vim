let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
"echo s:path
exec 'source ' . s:path . '/colorquote.vim'
