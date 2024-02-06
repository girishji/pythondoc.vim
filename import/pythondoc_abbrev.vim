vim9script

def CanExpandHH(): bool
    if getcmdtype() == ':'
        var context = getcmdline()->strpart(0, getcmdpos() - 1)
        if context == 'hh'
            return true
        endif
    endif
    return false
enddef

export def ExpandHH()
    cabbr <expr> hh     <SID>CanExpandHH() ? 'Help' : 'hh'
enddef

# XXX: Mapping 'hh' has a side effect that it pauses when you type first 'h' of 'hh'
#      Use an abbreviation instead.
# def g:ExpandHH(): string
#     if getcmdtype() == ':'
#         var context = getcmdline()->strpart(0, getcmdpos() - 1)
#         if context->empty()
#             return 'Help '
#         endif
#     endif
#     return 'hh'
# enddef
# cnoremap <expr> hh <SID>ExpandHH()

