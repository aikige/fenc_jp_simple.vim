# fenc_jp_simple.vim

Vim plugin to configure encoding related variables.

This scripts will absorb complicated encoding related configuration of Vim,
which are usually needed for Japanese language uses.

## Getting Started

If you are using [vim-plug](https://github.com/junegunn/vim-plug),
please simply add this repository in plug-in list in your `.vimrc`.

```
call plug#begin('~/.vim/plugged')
".. Other plugins
Plug 'aikige/fenc_jp_simple.vim'
call plug#end()
```

And execute command `:PlugInstall` or `:PlugUpdate`.

## Detailed Behavior

Following options are set via this script.

|Option|Note|
|:--|:--|
|`encoding`|Internal encoding used by Vim. If `g:fenc_jp_skip_encoding` is not set, `utf-8` is set for this value.|
|`fileencoding`|Encoding for empty file. If `g:fenc_jp_default` is not set, same value as `encoding` is used for this value.|
|`fileencodings`|List of encoding used to guess encoding of existing file.|
|`ambiwidth`|Expected width of ambiguous width character in UTF-8.|
|`langmenu`|Language used to show GUI menu.|

Following global variable affects to behavior of the script.

|Variable|Note|
|:--|:--|
|`g:fenc_jp_default`|Specify default `fileencoding` value.|
|`g:fenc_jp_use_en_menu`|When this value is 1, menu will be shown in English.|
|`g:fenc_jp_skip_encoding`|When this variable is set, script dose not change existing `encoding`.|

