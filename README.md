# fenc_jp_simple.vim

Vim plugin to configure encoding related options.

This scripts will absorb complicated encoding related configuration of Vim,
which are usually needed for Japanese language uses.

## Getting Started

### Install Plugin

#### Using vim-plug

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

#### Manual installation

Please copy `autoload` and `plugin` directory to your plugin folder.

### (Optional) call function in `.vimrc`

If you want to control timing to set `encoding`, `fileencoding` and `fileencodings`,
please call following function at the suitable location in your `.vimrc` or something equivalent.

```vim
try | call fenc_jp_simple#setup() | endtry
```

## Behavior of Script

### Options configured by this script

Following options are set via this script.

|Option|Note|
|:--|:--|
|`encoding`|Internal encoding used by Vim. If no encoding specified by argument of `fenc_jp_simple#setup()`, `utf-8` is set for this value.|
|`fileencoding`|Encoding for empty file. If `g:fenc_jp_default` is not set, same value as `encoding` is used for this value.|
|`fileencodings`|List of encoding used to guess encoding of existing file.|
|`ambiwidth`|Expected width of ambiguous width character in UTF-8.|
|`langmenu`|Language used to show GUI menu.|

### Global variables that affect behavior of this script

Following global variable affects to behavior of the script.

|Variable|Note|
|:--|:--|
|`g:fenc_jp_use_en_menu`|When this value is 1, menu is shown in English. Default value is `0`.|
|`g:fenc_jp_skip_encoding`|When this variable is set, script dose not change existing `encoding`.|

### How to change default file-encoding

If you want to change default encoding of files, please execute following sequence.

```vim
call fenc_jp_simple#setup('some-encoding')
```

### Setup for ambiguous width characters

In UNICODE, there is category of characters called [Ambiguous Characters](https://unicode.org/reports/tr11/#Ambiguous) that has variation of width of glyph, and this script performs `set ambiwidth=double` to set double-byte as default width for these.

But this is not enough for some characters, and this script is trying to perform additional width configurations for characters, especially related to Emoji.
Here, the width of the Emoji has a strong dependency on the selected fonts, and this script uses the following fonts to determine the width of the characters:

- [MS Gothic](https://learn.microsoft.com/typography/font-list/ms-gothic)
- [UDEV Gothic](https://github.com/yuru7/udev-gothic)

If there is a glyph width conflict between these fonts, MS Gothic is prioritized.

Please be noted that when selected GUI font does not include glyph for Emoji, vim uses system font (in the case of Windows 10, "Segoe UI Emoji" is used).
For detail, please refer [renderoptions](https://vimhelp.org/options.txt.html#%27renderoptions%27) in Vim help.
