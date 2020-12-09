if exists('g:fenc_jp_simple')
	finish
endif
let g:fenc_jp_simple = 1

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

function! fenc_jp_simple#setup()
	" Set internal encoding. Recommended to use 'utf-8'.
	if !exists('g:fenc_jp_skip_encoding')
		set encoding=utf-8
	endif

	" g:fenc_jp_default is used to set default encoding for files.
	if !exists('g:fenc_jp_default')
		let g:fenc_jp_default = &encoding
	endif
	execute 'set fileencoding=' . g:fenc_jp_default

	" First item can be 'ucs-bom', since it can be identified by BOM.
	let s:fencs = ['ucs-bom']
	" 2nd item in fileencodings should be default file-encoding.
	let s:fencs += s:get_uniq_item(s:fencs, g:fenc_jp_default)
	" Other items.
	let s:fencs += s:get_uniq_item(s:fencs, 'iso-2022-jp')
	let s:fencs += s:get_uniq_item(s:fencs, 'euc-jp')
	let s:fencs += s:get_uniq_item(s:fencs, 'cp932')
	let s:fencs += s:get_uniq_item(s:fencs, 'utf-8')
	let s:fencs += s:get_uniq_item(s:fencs, 'utf-16')
	let s:fencs += s:get_uniq_item(s:fencs, 'default')
	let s:fencs += s:get_uniq_item(s:fencs, 'latin1')
	execute 'set fileencodings=' . join(s:fencs, ',')

	" Configuration for Ambiguous Width Character in UTF-8.
	if &encoding == 'utf-8' && exists('&ambiwidth')
		set ambiwidth=double
	endif

	" Configuration for menu language.
	if !exists('g:fenc_jp_use_en_menu')
		let g:fenc_jp_use_en_menu = 1
	endif
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
	if exists('g:did_install_default_menus')
		source $VIMRUNTIME/delmenu.vim
		source $VIMRUNTIME/menu.vim
	endif
endfunction

" Restore user-configuration.
let &cpo = s:cpo_save
unlet s:cpo_save
