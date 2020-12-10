" Save user-configuration.
let s:cpo_save = &cpo
set cpo&vim

function! s:get_uniq_item(list, value)
	for n in a:list
		if n == a:value 
			return []
		endif
	endfor
	return [a:value]
endfunction

function! fenc_jp_simple#cleanup()
	if exists('g:fenc_jp_simple_setup')
		unlet g:fenc_jp_simple_setup
	endif
	"set encoding=
	set fileencoding=
	set fileencodings=
	set langmenu=
endfunction

function! fenc_jp_simple#setup()
	if exists('g:fenc_jp_simple_setup')
		return
	endif
	let g:fenc_jp_simple_setup = 1

	" Set internal encoding. Recommended to use 'utf-8'.
	if !exists('g:fenc_jp_skip_encoding')
		set encoding=utf-8
	endif

	" g:fenc_jp_default is used to set default encoding for files.
	if exists('g:fenc_jp_default')
		let l:fenc_jp_default = g:fenc_jp_default
	else
		let l:fenc_jp_default = &encoding
	endif
	execute 'set fileencoding=' . l:fenc_jp_default

	" First item can be 'ucs-bom', since it can be identified by BOM.
	let l:fencs = ['ucs-bom']
	" 2nd item in fileencodings should be default file-encoding.
	let l:fencs += s:get_uniq_item(l:fencs, l:fenc_jp_default)
	" Other items.
	let l:fencs += s:get_uniq_item(l:fencs, 'iso-2022-jp')
	let l:fencs += s:get_uniq_item(l:fencs, 'euc-jp')
	let l:fencs += s:get_uniq_item(l:fencs, 'cp932')
	let l:fencs += s:get_uniq_item(l:fencs, 'utf-8')
	let l:fencs += s:get_uniq_item(l:fencs, 'utf-16')
	let l:fencs += s:get_uniq_item(l:fencs, 'default')
	let l:fencs += s:get_uniq_item(l:fencs, 'latin1')
	execute 'set fileencodings=' . join(l:fencs, ',')

	" Configuration for Ambiguous Width Character in UTF-8.
	if &encoding == 'utf-8' && exists('&ambiwidth')
		set ambiwidth=double
	endif

	" Configuration for menu language.
	if exists('g:fenc_jp_use_en_menu')
		let l:fenc_jp_use_en_menu = g:fenc_jp_use_en_menu
	else
		let l:fenc_jp_use_en_menu = 1
	endif
	if exists('&langmenu')
		if l:fenc_jp_use_en_menu
			set langmenu=none
		elseif &encoding == 'utf-8'
			set langmenu=ja_JP.utf-8
		elseif &encoding == 'cp932'
			set langmenu=ja_JP.cp932
		endif
	endif

	" Reload menu.vim if it's already loaded.
	if exists('g:did_install_default_menus')
		source $VIMRUNTIME/delmenu.vim
		source $VIMRUNTIME/menu.vim
	endif
endfunction

" Restore user-configuration.
let &cpo = s:cpo_save
unlet s:cpo_save
