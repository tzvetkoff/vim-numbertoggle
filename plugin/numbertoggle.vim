" Prevent the script from loading multiple times
if exists("g:nubertoggle_loaded") || &cp || v:version < 703
  finish
endif
let g:numbertoggle_loaded = 1

function! NumberToggle()
  let g:previousmode = &relativenumber

  if &relativenumber == 1
    set number
  else
    set relativenumber
  endif
endfunc

function! UpdateMode()
  let &numberwidth = max([4, 2 + len(line('$'))])

  if g:insertmode == 0
    if g:previousmode == 1
      set relativenumber
    else
      set number
    endif
  else
    set number
  endif
endfunc

function! InsertEnter()
  let g:previousmode = &relativenumber
  let g:insertmode = 1
  call UpdateMode()
endfunc

function! InsertLeave()
  let g:insertmode = 0
  call UpdateMode()
endfunc

autocmd InsertEnter * :call InsertEnter()
autocmd InsertLeave * :call InsertLeave()
autocmd BufReadPost * :let &numberwidth = max([4, 2 + len(line('$'))])

if exists('g:NumberToggleTrigger')
  exec "nnoremap <silent> " . g:NumberToggleTrigger . " :call NumberToggle()<cr>"
else
  nnoremap <silent> <C-l> :call NumberToggle()<cr>
endif
