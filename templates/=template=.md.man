% %CAMELCLASS%(1) | %CAMELCLASS% Manual
% %USER%  %MAIL%
% %DATE%

NAME
===
**%CLASS%** - A man page written in Markdown
**ls(1)**, **cp(1)**

SYNOPSIS
===
`%CLASS%` [*options*] [*arguments*]

DESCRIPTION
===
This is an %CLASS% of a man page written in Markdown.

You can include **bold text**, *italic text*, or `code snippets`.

OPTIONS
---
`-h, --help`
:   Display help information.

`-v, --version`
:   Show the version number.

`-o, --output file`
:   Specify the output file.

EXAMPLES
===
To do something useful:

```bash
	#!/bin/bash
	### - Please note that the `man` only recognize the file-name, 
	### - Please build/reload man-database by  `mandb` after `pandoc` transfered
	pandoc -t man -s %CLASS% -t %CLASS%.1
```

SEE ALSO
===
**ls(1)**, **cp(1)**

For more information, see [Man pages with Markdown and Pandoc]
(https://gabmus.org/posts/man_pages_with_markdown_and_pandoc/).

