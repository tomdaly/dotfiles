if !exists('g:test#rego#conftest#file_pattern')
  let g:test#rego#conftest#file_pattern = '\v_test\.rego$'
endif

function! test#rego#conftest#test_file(file) abort
  return a:file =~# g:test#rego#conftest#file_pattern
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#rego#conftest#build_position(type, position) abort
  if a:type ==# 'file'
    return ['--strict']
  else
    return []
  endif
endfunction

" Returns processed args (if you need to do any processing)
function! test#rego#conftest#build_args(args) abort
  return a:args
endfunction

" Returns the executable of your test runner
function! test#rego#conftest#executable() abort
  return 'conftest verify'
endfunction
