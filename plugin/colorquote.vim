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
call s:InitVariable('g:colorquote_symbols', "['{}', '[]', '()', '<>', '!!', '++']", 0)
call s:InitVariable('g:colorquote_conceal', "0", 0)
"call s:InitVariable('g:colorquote_ignore_comments', "0", 0)
call s:InitVariable('g:colorquote_boldness_style_addon', "['bold', 'underline']", 0)

" INFO: Keep this aligned with 'after/syntax/colorquote.vim'.
let s:max_styles = 10

if len(g:colorquote_symbols) > s:max_styles
    let s:num_of_symbols = s:max_styles
    echoerr "Colorquote config issue: Only up to " . s:max_styles . " symbols are supported. See 'g:colorquote_symbols'."
else
    let s:num_of_symbols = len(g:colorquote_symbols)
endif

" ----------------------------------------------------------------------------------------------------
" ----- highlight styling ----------------------------------------------------------------------------
" ----------------------------------------------------------------------------------------------------
func! ColorquoteApplyStyling(event)
    "echo "ColorquoteApplyStyling: event: " . a:event
    " colorquote syntax highlighting (on top of filetype specific highlighting)

    "if exists("b:current_syntax_colorquote")
        "finish
    "endif
    "let b:current_syntax_colorquote = 1

    "echo &filetype
    if index(g:colorquote_filetypes, &filetype) == -1
        return
    endif


    let s:num_of_symbols = ((len(g:colorquote_symbols) > s:max_styles) ? s:max_styles : len(g:colorquote_symbols))

    " 'syntax match' rules

    "execute 'syntax match colorquote_boldness_symbol' . ' "\*" contained transparent conceal'

    "for i in range(1, s:num_of_symbols)
        "let s:containsStr = ''

        "" Add boldness support (i.e. *text*)
        "execute 'syntax region colorquote_boldness_region_style_' . i . ' start=/\*/ end=/\*/ contained keepend concealends oneline contains=colorquote_boldness_symbol'
        "let s:containsStr = ' contains=colorquote_boldness_region_style_' . i

        "if g:colorquote_conceal == 1
            "execute 'syntax match colorquote_syntax_symbol_match_' . i . ' "\V' . g:colorquote_symbols[i - 1] . ' " contained transparent conceal'
            "let s:containsStr = s:containsStr . ',colorquote_syntax_symbol_match_' . i
        "endif

        "if !exists("g:colorquote_ignore_comments") || (g:colorquote_ignore_comments == 0)
            "execute 'syntax match colorquote_syntax_match_' . i . ' "\V\^\s\*\zs' . g:colorquote_symbols[i - 1] . '\.\*\$"' . s:containsStr
        "else
            "" INFO: Commented lines are assumed to start with '%%'.
            "execute 'syntax match colorquote_syntax_match_' . i . ' "\V\s\*%\*\zs' . g:colorquote_symbols[i - 1] . '\.\*\$"' . s:containsStr
        "endif
    "endfor



    let s:colorquote_highlight_dict_default = {
        \ 'dark': {
            \ '1':  {'guifg': '#bf9469', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '2':  {'guifg': '#F4AD41', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '3':  {'guifg': '#63a9bb', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '4':  {'guifg': '#41e9f4', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '5':  {'guifg': '#eb5b5b', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '6':  {'guifg': '#67e57b', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '7':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '8':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '9':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '10': {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ },
        \ 'light': {
            \ '1':  {'guifg': '#966b42', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '2':  {'guifg': '#d5a23e', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '3':  {'guifg': '#489fb5', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '4':  {'guifg': '#35cfd9', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '5':  {'guifg': '#d24b4b', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '6':  {'guifg': '#48c95c', 'guibg': 'NONE', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '7':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '8':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '9':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
            \ '10': {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'NONE', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ }
    \ }

    let s:colorquote_highlight_dict_wc = deepcopy(s:colorquote_highlight_dict_default)


    " Merge two dictionaries, also recursively merging nested keys.
    function! s:merge_dict_recursive(target, override)
        let l:new = copy(a:target)
        for [l:k, l:v] in items(a:override)
            let l:new[l:k] = (type(l:v) is v:t_dict && type(get(l:new, l:k)) is v:t_dict)
                        \ ? s:merge_dict_recursive(l:new[l:k], l:v)
                        \ : l:v
        endfor
        return l:new
    endfunc


    " Merge potential user defined custom styles.
    if exists('g:colorquote_highlight_dict_custom')
        let s:colorquote_highlight_dict_wc = s:merge_dict_recursive(s:colorquote_highlight_dict_wc, g:colorquote_highlight_dict_custom)
        "echo s:colorquote_highlight_dict_wc['dark']['1']
    endif


    " 'highlight' rules
    " FIXME: switching background won't trigger this again
    "        - only e.g. ':e' will make it refresh
    "        - or running ':syn off | syn on'
    "        (guess it might be about 'after' mechanism)
    if(&background == 'dark')
        for i in range(1, s:num_of_symbols)
            execute 'highlight colorquote_boldness_region_style_' . i .
                        \ ' guifg='      .. s:colorquote_highlight_dict_wc['dark'][i]['guifg'] .
                        \ ' guibg='      .. s:colorquote_highlight_dict_wc['dark'][i]['guibg'] .
                        \ ' gui='        .. s:colorquote_highlight_dict_wc['dark'][i]['gui'] . ',' . join(g:colorquote_boldness_style_addon, ',')
                        \ ' ctermfg='    .. s:colorquote_highlight_dict_wc['dark'][i]['ctermfg'] .
                        \ ' ctermbg='    .. s:colorquote_highlight_dict_wc['dark'][i]['ctermbg'] .
                        \ ' cterm='      .. s:colorquote_highlight_dict_wc['dark'][i]['cterm']

            execute 'highlight colorquote_syntax_match_' . i .
                        \ ' guifg='      .. s:colorquote_highlight_dict_wc['dark'][i]['guifg'] .
                        \ ' guibg='      .. s:colorquote_highlight_dict_wc['dark'][i]['guibg'] .
                        \ ' gui='        .. s:colorquote_highlight_dict_wc['dark'][i]['gui'] .
                        \ ' ctermfg='    .. s:colorquote_highlight_dict_wc['dark'][i]['ctermfg'] .
                        \ ' ctermbg='    .. s:colorquote_highlight_dict_wc['dark'][i]['ctermbg'] .
                        \ ' cterm='      .. s:colorquote_highlight_dict_wc['dark'][i]['cterm']
        endfor
    else
        for i in range(1, s:num_of_symbols)
            execute 'highlight colorquote_boldness_region_style_' . i .
                        \ ' guifg='      .. s:colorquote_highlight_dict_wc['light'][i]['guifg'] .
                        \ ' guibg='      .. s:colorquote_highlight_dict_wc['light'][i]['guibg'] .
                        \ ' gui='        .. s:colorquote_highlight_dict_wc['light'][i]['gui'] . ',' . join(g:colorquote_boldness_style_addon, ',')
                        \ ' ctermfg='    .. s:colorquote_highlight_dict_wc['light'][i]['ctermfg'] .
                        \ ' ctermbg='    .. s:colorquote_highlight_dict_wc['light'][i]['ctermbg'] .
                        \ ' cterm='      .. s:colorquote_highlight_dict_wc['light'][i]['cterm']

            execute 'highlight colorquote_syntax_match_' . i .
                        \ ' guifg='      .. s:colorquote_highlight_dict_wc['light'][i]['guifg'] .
                        \ ' guibg='      .. s:colorquote_highlight_dict_wc['light'][i]['guibg'] .
                        \ ' gui='        .. s:colorquote_highlight_dict_wc['light'][i]['gui'] .
                        \ ' ctermfg='    .. s:colorquote_highlight_dict_wc['light'][i]['ctermfg'] .
                        \ ' ctermbg='    .. s:colorquote_highlight_dict_wc['light'][i]['ctermbg'] .
                        \ ' cterm='      .. s:colorquote_highlight_dict_wc['light'][i]['cterm']
        endfor
    endif
endfunc

" ----------------------------------------------------------------------------------------------------
" ----------------------------------------------------------------------------------------------------
" ----------------------------------------------------------------------------------------------------


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
    call s:SetupQuoteMapping('nv', 'r', '-1')

    for i in range(1, s:max_styles)
        call s:SetupQuoteMapping('nv', ((i == s:max_styles) ? 0: i), i - 1)
    endfor
endfunc


function! colorquote#checkFiletype(extension)
    if index(g:colorquote_filetypes, &filetype) == -1
        echo "finish"
        finish
    endif

    augroup colorquote
        autocmd!

        " INFO: 'BufWinEnter' fires whenever a buffer is viewed in a window.
        "       Only happens upon initial 'load', not upon switching between windows.
        if a:extension == "wiki"
            "echo "CQ: is 'wiki'"
            autocmd BufWinEnter *.wiki call ColorquoteApplyStyling("BufWinEnter")
        elseif a:extension == "markdown"
            "echo "CQ: is 'md'"
            autocmd BufWinEnter *.md call ColorquoteApplyStyling("BufWinEnter")
        elseif a:extension == "txt"
            "echo "CQ: is 'txt'"
            autocmd BufWinEnter *.txt call ColorquoteApplyStyling("BufWinEnter")
        endif

        " INFO: 'ColorScheme' fires upon a change in colorscheme.
        "       Also triggered when leaving 'Goyo'.
        autocmd ColorScheme * call ColorquoteApplyStyling("ColorScheme")
    augroup END

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
