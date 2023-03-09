





" Don't load plugin if filetype isn't configured.
" (could have been be overwritten by user)
"if index(g:colorquote_filetypes, &filetype) == -1
    "echo 'Skipping due to not enabled filetype.'
    "echo '&filetype ' . &filetype
    "echo 'g:colorquote_filetypes: ' . string(g:colorquote_filetypes)
    "finish
"endif


" vimwiki: changing text line-start style
function! colorquote#Changestyle(idxSymbol) range
"function! Changestyle(idxSymbol) range
    "echo '&filetype ' . &filetype
    "if index(g:colorquote_filetypes, &filetype) == -1
        "return
    "endif

    if g:colorquote_prev_showed_error == 1
        echo ""
        let g:colorquote_prev_showed_error = 0
    endif

    "echo 'getting here'
    let lineHasStyle = 0
    " INFO: Supported styles:
    let styles = ['{}', '[]', '()', '<>', '++', '!!']
    let newStyle = ''
    let newLine = ''

    if a:idxSymbol != -1
        let l:newStyle = g:colorquote_symbols[a:idxSymbol]
    endif

    "echo newStyle

    " done: depending on visual selection or not, for current / every selected line
    " INFO: Much easier with 'range' function
    let idxLineNow = a:firstline
    let idxLineEnd = a:lastline
    "let idxLineNow = 0
    "let idxLineEnd = 0
    "if mode() == 'n'
        "" INFO: Due to this function only being mapped to normal and visual
        "" mode bindings, it's assume that if it's not normal that's active,
        "" visual mode selection is desired.
        "let l:idxLineNow = line(".")
        "let l:idxLineEnd = line(".")
    "else
        "let idxLineNow = line('v')
        "let idxLineEnd = line('.')
        ""let l:idxLineNow = line("'<")
        ""let l:idxLineEnd = line("'>")
    "endif
    "echo 'idxLineNow: ' . idxLineNow
    "echo 'idxLineEnd: ' . idxLineEnd

    while idxLineNow <= idxLineEnd
        let lineStr = getline(idxLineNow)
        "echo lineStr

        "   done: check if line already has any one of the possible line-start styles prepended
        let iterCnt = -1
        let l:lineHasStyle = 0
        let existingStyle = ''
        for s in g:colorquote_symbols
            let l:iterCnt += 1
            "echo iterCnt
            let mat = '^\s*\zs\V' . s
            "echo mat
            "echo stridx(lineStr, mat)
            "let res = matchstr(lineStr, mat)
            "echo res
            "if res != ''
            if lineStr =~ l:mat
                "echo '-->> match found'
                let l:lineHasStyle = 1
                let existingStyle = s
                break
            endif

            "echo '------------'
        endfor

        if newStyle != existingStyle
            if l:lineHasStyle == 1
                "   done: if so, replace that line-start style (possibly empty style to get normal text)
                "echo 'lineHasStyle == 1'
                "echo g:colorquote_symbols[iterCnt]
                let addedSpaceRemoval = ''
                if a:idxSymbol == -1
                    let l:addedSpaceRemoval = ' '
                endif
                let l:newLine = substitute(lineStr, '^\s*\zs' . g:colorquote_symbols[iterCnt] . l:addedSpaceRemoval, newStyle, '')
            else
                "   done: if not, prepend new line-start style (with added space)
                "echo 'lineHasStyle == 0'

                "let res = matchstr(lineStr,  '^\s*%%')
                "if res != ''
                if lineStr =~ '^\s*%%'
                    let l:idxLineNow += 1
                    continue " ignore commented lines (assuming vimwiki comments)
                else
                    let l:newLine = substitute(lineStr, '\v^\s*\zs(\S{1})', newStyle . ((newStyle == '') ? '' : ' ') . '\1', '')
                endif
            endif

            call setline(l:idxLineNow, l:newLine)
        endif

        let l:idxLineNow += 1
    endwhile
endfunc
