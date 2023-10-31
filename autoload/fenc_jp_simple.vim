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
	if exists('g:fenc_jp_encoding')
		unlet g:fenc_jp_encoding
	endif
	"set encoding=
	set fileencoding=
	set fileencodings=
	set langmenu=
endfunction

function! fenc_jp_simple#setup(...)
	" Set internal encoding. Recommended to use 'utf-8'.
	if !exists('g:fenc_jp_skip_encoding')
		set encoding=utf-8
	endif

	" identify primary encoding.
	if a:0 == 0
		let l:primary = &encoding
	else
		let l:primary = a:1
	end
	if exists('g:fenc_jp_encoding') && g:fenc_jp_encoding == l:primary
		" avoid duplicated setting.
		return
	endif
	let g:fenc_jp_encoding = l:primary

	" Set fileencoding. 
	execute 'set fileencoding=' . l:primary

	" First item can be 'ucs-bom', since it can be identified by BOM.
	let l:fencs = ['ucs-bom']
	" 2nd item in fileencodings should be primary file-encoding.
	let l:fencs += s:get_uniq_item(l:fencs, l:primary)
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

	" Avoid character width problem with emoji like ☺.
	" Reference: https://en.wikipedia.org/wiki/Unicode_block
	" Reference: https://en.wikipedia.org/wiki/Emoji#Unicode_blocks
	" Note: Emoticons are automatically recognized.
	if (&encoding == 'utf-8') && exists('*setcellwidths')
		let cwdb = []
		let cwdb = add(cwdb, [0xb2, 0xb3, 1])	" Superscript 2 & 3
		let cwdb = add(cwdb, [0xb9, 0xb9, 1])	" Superscript 1
		"let cwdb = add(cwdb, [0x00a9, 0x00a9, 2])	" Copyright Sign
		"let cwdb = add(cwdb, [0x00ae, 0x00ae, 2])	" Registered Sign
		"let cwdb = add(cwdb, [0x203c, 0x203c, 2])	" Double Exclamation Mark
		"let cwdb = add(cwdb, [0x2049, 0x2049, 2])	" Exclamation Question Mark
		"let cwdb = add(cwdb, [0x2122, 0x2122, 2])	" Trade Mark Sign
		let cwdb = add(cwdb, [0x2139, 0x2139, 2])	" Information Source
		let cwdb = add(cwdb, [0x2328, 0x2328, 2])	" Keyboard
		let cwdb = add(cwdb, [0x23cf, 0x23cf, 2])	" Eject Symbol
		let cwdb = add(cwdb, [0x25fb, 0x25fc, 2])	" White/Black Medium Square
		let cwdb = add(cwdb, [0x2600, 0x26ff, 2])	" Block: Miscellaneous Symbols
		let cwdb = add(cwdb, [0x2700, 0x27bf, 2])	" Block: Dingbats
		let cwdb = add(cwdb, [0x2b00, 0x2bff, 2])	" Block: Miscellaneous Symbol and Arrows
		"let cwdb = add(cwdb, [0x1f600, 0x1f64f, 2])	" Block: Emoticons (Face Marks)
		call setcellwidths(cwdb)
		unlet cwdb
	endif

	" Configuration for menu language.
	if exists('g:fenc_jp_use_en_menu')
		let l:fenc_jp_use_en_menu = g:fenc_jp_use_en_menu
	else
		let l:fenc_jp_use_en_menu = 0
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
