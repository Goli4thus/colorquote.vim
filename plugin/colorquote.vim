if exists('loaded_colorquote')
    finish
endif
if v:version < 700
    echoerr "colorquote: this plugin requires vim >= 7."
    finish
endif
let loaded_colorquote = 1


function s:InitVariable(var, value, isString)
    if !exists(a:var)
        execute 'let ' . a:var . ' = ' . ((a:isString) ? string(a:value) : a:value)
    endif
endfunc

call s:InitVariable('g:colorquote_subleader', "j", 1)
call s:InitVariable('g:colorquote_filetypes', "['vimwiki', 'markdown', 'text']", 0)
call s:InitVariable('g:colorquote_symbols', "['{}', '[]', '()', '<>', '++', '!!']", 0)
call s:InitVariable('g:colorquote_conceal', "0", 0)
"call s:InitVariable('g:colorquote_ignore_comments', "0", 0)



if len(g:colorquote_symbols) > 10
    let s:num_of_symbols = 10
    echoerr "Colorquote config issue: Only up to 10 symbols are supported. See 'g:colorquote_symbols'."
else
    let s:num_of_symbols = len(g:colorquote_symbols)
endif


" Creates a mapping like this: ('n', '1', '0')
"   nnoremap <leader>j1 <Esc>:call ColorQuoteChangeStyle(0)<CR>

" TODO: These checks re 'vim-repeat' being present aren't working yet.
"       Maybe just make support for 'vim-repeat' configurable (default:
"       disabled).
let s:vim_repeat_present = 1
"let s:vim_repeat_present = exists("g:loaded_repeat") ? 1 : 0
"let s:vim_repeat_present = exists("*repeat#set()") ? 1 : 0
"echo s:vim_repeat_present

function! s:SetupQuoteMapping(modes, key, idx)
    for mode in split(a:modes, '\zs')
        if (a:idx + 1) > s:num_of_symbols
            execute mode . 'noremap <buffer> <silent> <leader>' . g:colorquote_subleader . a:key . ' ' .
                        \ ':call colorquote#NoStyleConfigured(' . a:key . ')<CR>'
        elseif s:vim_repeat_present == 0
            execute mode . 'noremap <buffer> <silent> <leader>' . g:colorquote_subleader . a:key . ' ' .
                        \ ':call colorquote#Changestyle(' . a:idx . ')<CR>'
        else
            execute mode . 'noremap <silent> <Plug>ColorquoteStyle_' . a:key . ' ' .
                        \ ':call colorquote#Changestyle(' . a:idx . ')<CR>' .
                        \ ':call repeat#set("\<Plug>ColorquoteStyle_' . a:key . '", -1)<CR>'
            execute mode . 'noremap <buffer> <silent> <leader>' . g:colorquote_subleader . a:key . ' ' .
                        \ '<Plug>ColorquoteStyle_' . a:key
        endif
    endfor
endfunc


function! s:ColorquoteCreateAllMappings()
    call s:SetupQuoteMapping('nv', 'w', '-1')

    for i in range(1, 10)
        call s:SetupQuoteMapping('nv', ((i == 10) ? 0: i), i - 1)
    endfor
endfunc


function! colorquote#checkFiletype()
    if index(g:colorquote_filetypes, &filetype) == -1
        finish
    endif

    call s:ColorquoteCreateAllMappings()
endfunc

let g:colorquote_prev_showed_error = 0
function! colorquote#NoStyleConfigured(key)
    "echoerr "Colorquote: Key '" . a:key . "' has no configured symbol. See 'g:colorquote_symbols'."
    echohl ErrorMsg | echo "Colorquote: Key '" . a:key . "' has no configured style symbol. See 'g:colorquote_symbols'." | echohl None
    let g:colorquote_prev_showed_error = 1
endfunc


function! ColorquoteToggleConceal()
    if g:colorquote_conceal == 1
        let g:colorquote_conceal = 0
    else
        let g:colorquote_conceal = 1
    endif

    syn off
    syn on
endfunc

command ColorquoteToggleConceal call ColorquoteToggleConceal()


function! ColorquoteToggleIgnoreComments(ignore)
    "if g:colorquote_ignore_comments == 1
    if a:ignore == 0
        let g:colorquote_ignore_comments = 0
    else
        let g:colorquote_ignore_comments = 1
    endif

    syn off
    syn on
endfunc
