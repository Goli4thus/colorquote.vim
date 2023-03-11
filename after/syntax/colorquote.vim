" colorquote syntax highlighting (on top of filetype specific highlighting)

"if exists("b:current_syntax_colorquote")
    "finish
"endif
"let b:current_syntax_colorquote = 1

"echo &filetype
if index(g:colorquote_filetypes, &filetype) == -1
    finish
endif


let s:num_of_symbols = ((len(g:colorquote_symbols) > 10) ? 10 : len(g:colorquote_symbols))

" 'syntax match' rules

execute 'syntax match colorquote_boldness_symbol' . ' "\*" contained transparent conceal'

for i in range(1, s:num_of_symbols)
    let s:containsStr = ''

    " Add boldness support (i.e. *text*)
    execute 'syntax region colorquote_boldness_region_style_' . i . ' start=/\*/ end=/\*/ contained keepend concealends oneline contains=colorquote_boldness_symbol'
    let s:containsStr = ' contains=colorquote_boldness_region_style_' . i

    if g:colorquote_conceal == 1
        execute 'syntax match colorquote_syntax_symbol_match_' . i . ' "\V' . g:colorquote_symbols[i - 1] . ' " contained transparent conceal'
        let s:containsStr = s:containsStr . ',colorquote_syntax_symbol_match_' . i
    endif

    if !exists("g:colorquote_ignore_comments") || (g:colorquote_ignore_comments == 0)
        execute 'syntax match colorquote_syntax_match_' . i . ' "\V\^\s\*\zs' . g:colorquote_symbols[i - 1] . '\.\*\$"' . s:containsStr
    else
        " INFO: Commented lines are assumed to start with '%%'.
        execute 'syntax match colorquote_syntax_match_' . i . ' "\V\s\*%\*\zs' . g:colorquote_symbols[i - 1] . '\.\*\$"' . s:containsStr
    endif
endfor



let s:colorquote_highlight_dict_default = {
    \ 'dark': {
        \ '1':  {'guifg': '#bf9469', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '2':  {'guifg': '#F4AD41', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '3':  {'guifg': '#63a9bb', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '4':  {'guifg': '#41e9f4', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '5':  {'guifg': '#67e57b', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '6':  {'guifg': '#eb5b5b', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '7':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '8':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '9':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '10': {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ },
    \ 'light': {
        \ '1':  {'guifg': '#966b42', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '2':  {'guifg': '#d5a23e', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '3':  {'guifg': '#489fb5', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '4':  {'guifg': '#35cfd9', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '5':  {'guifg': '#48c95c', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '6':  {'guifg': '#d24b4b', 'guibg': 'NONE', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '7':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '8':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '9':  {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
        \ '10': {'guifg': '#ffffff', 'guibg': 'blue', 'gui': 'italic', 'ctermfg': 'blue', 'ctermbg': 'NONE', 'cterm': 'NONE'},
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
