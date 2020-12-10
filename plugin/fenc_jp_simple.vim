if exists('g:fenc_jp_simple')
	finish
endif
let g:fenc_jp_simple= 1
echom "fenc_jp_simple:plugin"

" Save user-configuration.
let s:cpo_save = &cpo
set cpo&vim

call fenc_jp_simple#setup()

" Restore user-configuration.
let &cpo = s:cpo_save
unlet s:cpo_save
