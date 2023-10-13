" ------------------------------------------------ 
"  init.vim
"  Created:  2023-05-18
"  Modified: 2023-10-04
" ------------------------------------------------


" Commands
" -----------------------
command! -nargs=1 -complete=file
        \ RequireSource
        \ execute 'source ' . fnameescape(stdpath('config') . '/<args>')


" Load configurations
" -----------------------
if exists('g:vscode')
        RequireSource vscode/init.vim
        finish
end

RequireSource init.start.vim
augroup init#
        autocmd VimEnter * PaqPackAdd * !copilot.lua
        autocmd InsertEnter * 
                \ packadd copilot.lua
                \ | runtime after/plugin/copilot.lua
augroup END
