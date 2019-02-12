let s:unique_id = ''
let s:cache_reg_key_value = ''
let s:reg_key = 'a'

function! ggcommit#buffer#cache_reg_key_value() abort
    let s:cache_reg_key_value = getreg(s:reg_key)
endfunction

function! ggcommit#buffer#reset_reg() abort
    call setreg(s:reg_key, s:cache_reg_key_value)
endfunction

function! ggcommit#buffer#add_placeholders() abort
    call ggcommit#buffer#cache_reg_key_value()
    call setreg(s:reg_key, '')
    call append(0, [
        \ '<++>',
        \ '',
        \ '<++>',
        \ '',
        \ '<++>'])
endfunction

function! ggcommit#buffer#has_no_content() abort
    return getline(1) !~ '[^\s]'
endfunction

function! ggcommit#buffer#match_unique_id_from_branch_name() abort
    let match_str = printf(
        \ '^# On branch.*%s(.*)%s/\=setreg(%s, submatch(1))',
        \ g:ggcommit_pre_wrapper,
        \ g:ggcommit_post_wrapper,
        \ "'" . s:reg_key . "'")

    silent! execute '%s/\v'. match_str .'/ne'
endfunction

function! ggcommit#buffer#has_unique_id() abort
    return len(getreg(s:reg_key)) ? 1 : 0
endfunction

function! ggcommit#buffer#get_unique_id() abort
    call ggcommit#buffer#match_unique_id_from_branch_name()
    if ggcommit#buffer#has_unique_id()
        return getreg(s:reg_key)
    endif

    return ''
endfunction

function! ggcommit#buffer#try_swap_placeholder_with_id() abort
    let s:unique_id = ggcommit#buffer#get_unique_id()
    5s/<++>/\=len(s:unique_id) ? s:unique_id : "<++>"
endfunction
