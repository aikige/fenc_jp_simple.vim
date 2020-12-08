# fenc_jp_simple.vim

Vim plugin to configure encoding related variables.

This scripts sets following parameters suitable for Japanese user who uses UTF-8 as internal encoding.

Following options are set via this script.

|Option|Note|
|:--|:--|
|`encoding`|Internal encoding used by Vim.|
|`fileencoding`|Encoding for empty file.|
|`fileencodings`|Encoding list used to guess encoding of existing file.|
|`ambiwidth`|Expected width of ambiguous width character in UTF-8.|
|`langmenu`|Language used to show GUI menu.|

Following global variable affects to behavior of the script.

|Variable|Note|
|:--|:--|
|`g:fenc_jp_default`|Specify default file-encoding to be used for (new) files.|
|`g:fenc_jp_use_en_menu`|When this value is 1, menu will be shown in English.|
|`g:fenc_jp_skip_encoding`|When this variable is set, script dose not change existing `encoding`.|

