if exists('g:loaded_ggcommit')
    finish
endif
let g:loaded_ggcommit = 1

if !exists('g:ggcommit_pre_wrapper')
    let g:ggcommit_pre_wrapper = '##'
endif

if !exists('g:ggcommit_post_wrapper')
    let g:ggcommit_post_wrapper = '##'
endif

command! GGcommit call ggcommit#run()

augroup ggcommit
    autocmd!
    autocmd FileType gitcommit GGcommit
augroup end
