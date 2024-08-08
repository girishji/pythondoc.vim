if exists("g:loaded_pythondoc") || &cp || v:version < 700
  finish
endif

let g:loaded_pythondoc = 1

:command -nargs=1 -complete=customlist,s:getHelpTags Help help <args>

fun! s:shortestFirst(x, y)
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

fun! s:getHelpTags(argLead, line, cursorPos)
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

fun! s:canExpandHH()
    if getcmdtype() == ':'
        let context = getcmdline()->strpart(0, getcmdpos() - 1)
        if context == 'hh'
            return 1
        endif
    endif
    return 0
endfun

fun! PythondocExpandHH()
    cabbr <expr> hh     <SID>canExpandHH() ? 'Help' : 'hh'
endfun

if get(g:, 'pythondoc_hh_expand')
    call PythondocExpandHH()
endif
