" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_colorquote")
    finish
endif
let b:did_ftplugin_colorquote = 1


call colorquote#checkFiletype("markdown")
