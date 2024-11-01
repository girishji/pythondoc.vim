" Only do this when not yet done for this buffer
if exists("b:did_pythondoc_ftplugin")
    finish
endif
let b:did_pythondoc_ftplugin = 1

command! -buffer -nargs=1 -complete=customlist,s:getHelpTags Help help <args>

silent! fun s:shortestFirst(x, y)
    let pat = '\v.+\ze\.\.\S+(\.\w{3})?(\@py)?'
    let xstr = a:x->matchstr(pat)
    let ystr = a:y->matchstr(pat)
    if xstr->len() < ystr->len()
        return -1
    elseif xstr->len() == ystr->len()
        return xstr < ystr ? -1 : 1
    else
        return 1
    endif
endfun

silent! fun s:getHelpTags(argLead, line, cursorPos)
    let words = a:argLead->getcompletion('help')
    let filtered = words->copy()->filter({_, v -> v =~# '@py$'})
    if filtered->empty()
        return words
    endif
    let matching = l:filtered->copy()->filter({_, v -> v->slice(0, a:argLead->len()) ==# a:argLead})
    let nonmatch = l:filtered->copy()->filter({_, v -> v->slice(0, a:argLead->len()) !=# a:argLead})
    call sort(matching, {x, y -> s:shortestFirst(x, y)})
    return matching->extend(nonmatch)
endfun

if get(g:, 'pythondoc_h_expand')
    silent! fun s:canExpandH()
        if getcmdtype() == ':'
            let context = getcmdline()->strpart(0, getcmdpos() - 1)
            if context == 'h'
                return 1
            endif
        endif
        return 0
    endfun

    cabbr <buffer> <expr> h     <SID>canExpandH() ? 'Help' : 'h'
endif

" Load the docs only for python filetype
silent! fun s:docDir()
    let script = getscriptinfo({'name': 'pythondoc\.vim.*python_doc\.vim'})
    return script == [] ? '' : $'{script[0].name->fnamemodify(":p:h:h")}/_doc'
endfun
exec $'set rtp+={s:docDir()}'
" XXX: b:undo_ftplugin gets overwritten by global (Vim's) python ftplugin
" let b:undo_ftplugin .= $' | set rtp-={s:docDir()}'
