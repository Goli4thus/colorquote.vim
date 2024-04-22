" colorquote syntax highlighting (on top of filetype specific highlighting)

"if exists("b:current_syntax_colorquote")
    "finish
"endif
"let b:current_syntax_colorquote = 1

"echo &filetype
if index(g:colorquote_filetypes, &filetype) == -1
    finish
endif

" INFO: Keep this aligned with 'plugin/colorquote.vim'.
let s:max_styles = 10

let s:num_of_symbols = ((len(g:colorquote_symbols) > s:max_styles) ? s:max_styles : len(g:colorquote_symbols))

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


" INFO: 'highlight' configuration happens 'plugin/colorquote.vim'
