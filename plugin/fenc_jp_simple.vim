if exists('g:fenc_jp_simple')
	finish
endif
let g:fenc_jp_simple = 1

if !exists('g:fenc_jp_use_en_menu')
	let g:fenc_jp_use_en_menu = 1
endif

" Save user-configuration.
let s:cpo_save = &cpo
set cpo&vim

function! AddFenc(coding)
	if &fileencodings !~ a:coding
		execute 'set fileencodings+=' . a:coding
	endif
endfunction

" Set internal encoding. Recommended to use 'utf-8'.
if !exists('g:fenc_jp_skip_encoding')
	set encoding=utf-8
endif

" &fileencodings is the list of encodings.
set fileencodings=
call AddFenc('ucs-bom')

" 2nd item in fileencodings should be default file-encoding.
if exists('g:fenc_jp_default')
	execute 'set fileencoding=' . g:fenc_jp_default
	call AddFenc(g:fenc_jp_default)
else
	execute 'set fileencoding=' . &encoding
	call AddFenc(&encoding)
endif

call AddFenc('iso-2022-jp')
call AddFenc('utf-8')
call AddFenc('euc-jp')
call AddFenc('cp932')
call AddFenc('default')
call AddFenc('latin1')

" Configuration for Ambiguous Width Character in UTF-8.
if &encoding == 'utf-8' && exists('&ambiwidth')
	set ambiwidth=double
endif

" Configuration for menu language.
if exists('&langmenu')
	if g:fenc_jp_use_en_menu
		set langmenu=none
	elseif &encoding == 'utf-8'
		set langmenu=ja_JP.utf-8
	elseif &encoding == 'cp932'
		set langmenu=ja_JP.cp932
	endif
endif

" Reload menu.vim if it's already loaded.
if exists('did_install_default_menus')
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

" Restore user-configuration.
let &cpo = s:cpo_save
unlet s:cpo_save
