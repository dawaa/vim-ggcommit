function! ggcommit#run() abort
    if ggcommit#buffer#has_no_content()
        call ggcommit#buffer#add_placeholders()
        call ggcommit#buffer#try_swap_placeholder_with_id()
        call ggcommit#buffer#reset_reg()
        call cursor(1, 0)
    endif
endfunction
