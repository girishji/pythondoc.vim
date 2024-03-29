if !has('vim9script') ||  v:version < 900
    " Needs Vim version 9.0 and above
    finish
endif

vim9script

g:loaded_pythondoc = true

:command -nargs=1 -complete=customlist,GetHelpTags Help help <args>

def GetHelpTags(argLead: string, line: string, cursorPos: number): list<string>
    var words = argLead->getcompletion('help')
    var filtered = words->copy()->filter((_, v) => v =~# '@py$')
    if filtered->empty()
        return words
    endif
    var matching = filtered->copy()->filter((_, v) => v->slice(0, argLead->len()) ==# argLead)
    var nonmatch = filtered->copy()->filter((_, v) => v->slice(0, argLead->len()) !=# argLead)
    var pat = '\v.+\ze\.\.\S+(\.\w{3})?(\@py)?'
    matching->sort((x, y) => {
        var xstr = x->matchstr(pat)
        var ystr = y->matchstr(pat)
        if xstr->len() < ystr->len()
            return -1
        elseif xstr->len() == ystr->len()
            return xstr < ystr ? -1 : 1
        else
            return 1
        endif
    })
    return matching->extend(nonmatch)
enddef

if get(g:, 'pythondoc_hh_expand')
    pythondoc_abbrev.ExpandHH()
endif
