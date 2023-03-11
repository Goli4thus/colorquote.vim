colorquote.vim
==============

![colorquote_showcase](https://github.com/Goli4thus/images/blob/master/images_colorquote/colorquote_showcase.png)


On-demand highlighting for entire lines in markdown like file types.


Why you might find it interesting
---------------------------------

When reading PDFs via a PDF viewer / editor, adding some text highlighting to
specific text passages is rather easy.
When taking notes or going through lots of text pasted into Vim, there's no
easy way to do that though.

So if you've ever desired a way to add some on-demand text highlighting of
entire lines in your text based notes (`text`, `markdown`, `vimwiki`), just
like you would be doing when reading a PDF file, `colorquote` might add some
value to your workflow.


The basic idea
--------------

`colorquote` adds up to 10 highlighting styles.

To enable specific highlighting for a given line, it will be prefixed with an
associated style symbol (e.g. `<>`). Dedicated mappings exist for quick addition
of such style symbols.

The additional highlighting rules are added via Vim's `after-directory`
mechanism.


Installation
------------

Simply use one of the many plugin managers there are.
E.g. `vim-plug`:

    `Plug 'goli4thus/colorquote.vim'`


Mappings
--------

| mapping                | purpose                   |
| ---                    | ---                       |
| \<Leader>\<subleader>1 | change to style 1         |
| \<Leader>\<subleader>2 | change to style 2         |
| \<Leader>\<subleader>3 | change to style 3         |
| \<Leader>\<subleader>4 | change to style 4         |
| \<Leader>\<subleader>5 | change to style 5         |
| \<Leader>\<subleader>6 | change to style 6         |
| \<Leader>\<subleader>7 | change to style 7         |
| \<Leader>\<subleader>8 | change to style 8         |
| \<Leader>\<subleader>9 | change to style 9         |
| \<Leader>\<subleader>0 | change to style 10        |
| \<Leader>\<subleader>w | change to without styling |


Where `<subleader>` is a `colorquote` specific second level leader key.
Default is 'j'.

Works both on current line or visual selection (entire lines).


Configuration
-------------

Various things can be configured:

- the `<subleader>` key
- the actual file types `colorquote` will be enabled for (supported: `text`,
  `markdown`, `vimwiki`)
- the actual style symbols
- the associated style symbol highlighting
- additional styling for `*bold*` syntax contained within

Furthermore, style symbols can be hidden via Vim's conceal feature (i.e. style
symbols will only show while lines are selected; requires `conceallevel=2`).
This can be momentarily toggled via command `:ColorquoteToggleConceal`, or
made persistent via the associated configuration option.


For details on how to configure all the above, please have a look at: `:help colorquote`


License
-------

MIT
