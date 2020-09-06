fu! ListAction(...)
  if a:0 < 1
     echo "command usage: List [file directory]"
     return
  endif
  if a:1 ==? 'file'
     let l:file = a:2
     execute '!ls -a' l:file
  elseif a:1 ==? 'directory'
     let l:directory = a:2
     execute '!ls' l:directory
  endif
endfunction

command! -nargs=* List call ListAction(<f-args>)
