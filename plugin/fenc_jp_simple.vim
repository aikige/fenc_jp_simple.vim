if exists('g:fenc_jp_simple')
	finish
endif
let g:fenc_jp_simple = 1

" Save user-configuration.
let s:cpo_save = &cpo
set cpo&vim

function! SetFenc(code, cond)
	if !&readonly && &buftype != 'quickfix' && a:cond == 0
		execute 'setlocal fileencoding=' . a:code
	endif
endfunction

function! AddFenc(coding)
	if &fileencodings !~ a:coding
		execute 'set fileencodings+=' . a:coding
	endif
endfunction

set encoding=utf-8

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

if &encoding == 'utf-8' && exists('&ambiwidth')
	set ambiwidth=double
endif

if exists('&langmenu')
	if exists('g:fenc_jp_use_en_menu') && g:fenc_jp_use_en_menu
		set langmenu=none
	elseif &encoding == 'utf-8'
		set langmenu=ja_JP.utf-8
	endif
endif

if exists('did_install_default_menus')
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

" Restore user-configuration.
let &cpo = s:cpo_save
unlet s:cpo_save
