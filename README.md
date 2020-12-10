# fenc_jp_simple.vim

Vim plugin to configure encoding related options.

This scripts will absorb complicated encoding related configuration of Vim,
which are usually needed for Japanese language uses.

## Getting Started

If you are using [vim-plug](https://github.com/junegunn/vim-plug),
please simply add this repository in plug-in list in your `.vimrc`.

```vim
call plug#begin('~/.vim/plugged')
Plug 'aikige/fenc_jp_simple.vim'
".. Other plugins
call plug#end()
```

Then, please execute command `:PlugInstall` or `:PlugUpdate`.
This plugin configures encoding related options in startup sequence.

If you want to control timing to set `encoding`, `fileencoding` and `fileencodings`,
please call following function at the suitable location in your `.vimrc` or something equivalent.

```vim
try | call fenc_jp_simple#setup() | endtry
```

## Detailed Behavior

### Options configured by this script

Following options are set via this script.

|Option|Note|
|:--|:--|
|`encoding`|Internal encoding used by Vim. If `g:fenc_jp_skip_encoding` is not set, `utf-8` is set for this value.|
|`fileencoding`|Encoding for empty file. If `g:fenc_jp_default` is not set, same value as `encoding` is used for this value.|
|`fileencodings`|List of encoding used to guess encoding of existing file.|
|`ambiwidth`|Expected width of ambiguous width character in UTF-8.|
|`langmenu`|Language used to show GUI menu.|

### Global variables that affect behavior of this script

Following global variable affects to behavior of the script.

|Variable|Note|
|:--|:--|
|`g:fenc_jp_default`|Specify default `fileencoding` value.|
|`g:fenc_jp_use_en_menu`|When this value is 1, menu will be shown in English.|
|`g:fenc_jp_skip_encoding`|When this variable is set, script dose not change existing `encoding`.|

### How to change default file-encoding

If you want to change default encoding of files, please execute following sequence.

```vim
call fenc_jp_simple#cleanup()
let g:fenc_jp_default = 'some-encoding'
call fenc_jp_simple#setup()
```

