
" Single mappings
let g:which_key_map['k'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['v'] = [ ':vs<cr>'                     , 'split right']
let g:which_key_map['h'] = [ ':sp<cr>'                     , 'split right']
let g:which_key_map['x'] = [ ':close<cr>'      , 'close buffer']
let g:which_key_map[','] = [ ':wa<cr>'      , 'save all buffers']
let g:which_key_map['K'] = [ ':call <SID>show_documentation()<cr>'      , 'show docs']

" Double key mappings
let g:which_key_map['ut'] = [ ':UndotreeToggle<cr> :UndotreeFocus<cr>'      , 'undotree']
let g:which_key_map['ev'] = [ ':tabnew ~/dotfiles/.config/nvim/init.vim<cr>'      , 'open vimrc']
let g:which_key_map['sv'] = [ ':source ~/dotfiles/.config/nvim/init.vim<cr>'      , 'source vimrc']
let g:which_key_map['<space>a'] = [ 'nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>'      , 'list all diagnostics']



let g:which_key_map.d = {
      \ 'name' : '+debugger' ,
      \ 'm' : [':MaximizerToggle!<cr>'     , 'maximize pane'],
      \ 'd' : [':call vimspector#Launch()'     , 'launch debugger'],
      \ 'c' : [':call GotoWindow(g:vimspector_session_windows.code)<CR>'     , 'code window'],
      \ 't' : [':call GotoWindow(g:vimspector_session_windows.tabpage)<CR>'     , 'tab window'],
      \ 'v' : [':call GotoWindow(g:vimspector_session_windows.variables)<CR>'     , 'variables window'],
      \ 'w' : [':call GotoWindow(g:vimspector_session_windows.watches)<CR>'     , 'watches window'],
      \ 's' : [':call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>'     , 'stack trace window'],
      \ 'o' : [':call GotoWindow(g:vimspector_session_windows.output)<CR>'     , 'output window'],
      \ 'b' : [':<plug>VimspectorToggleBreakpoint<cr>'     , 'toggle breakpoint'],
      \ 'rc' : [':<plug>VimspectorRunToCursor<cr>'     , 'Run to cursor'],
      \ 'B' : [':<plug>VimspectorToggleConditionalBreakpoint<cr>'     , 'conditional breakpoint'],
      \ 'l' : [':<plug>VimspectorStepInto<cr>'     , 'stepinto'],
      \ 'j' : [':<plug>VimspectorStepOver<cr>'     , 'stepover'],
      \ 'k' : [':<plug>VimspectorStepOut<cr>'     , 'stepout'],
      \ 'C' : [':call vimspector#Continue()<cr>'     , 'continue'],
      \ }

let g:which_key_map.C = {
      \ 'name' : '+control' ,
      \ 't' : [':tabnew<cr>'     , 'new tab'],
      \ 'h' : ['<C-w>h'     , 'left vim-pane'],
      \ 'j' : ['<C-w>j'     , 'down vim-pane'],
      \ 'k' : ['<C-w>k'     , 'up vim-pane'],
      \ 'l' : ['<C-w>l'     , 'right vim-pane'],
      \ 'right' : [':tabnext'     , 'next tab'],
      \ 'left' : ['<C-w>l'     , 'prev tab'],
      \ '/' : ['<plug>NERDCommenterToggle'     , 'comment'],
      \ 'p' : [':GFiles'     , 'search files'],
      \ }

let g:which_key_map.c = {
      \ 'name' : '+coc' ,
      \ 'dp' : ['<plug>(coc-diagnostic-prev)'     , 'prev diag'],
      \ 'dn' : ['<plug>(coc-diagnostic-next)'     , 'next diag'],
      \ 'D' : [':<C-u>CocList diagnostics<cr>'     , 'list diag'],
      \ 'a' : ['<plug>(coc-codeaction)'     , 'action'],
      \ 'd' : ['<plug>(coc-definition)'     , 'definition'],
      \ 't' : ['<plug>(coc-type-definition)'     , 'type definition'],
      \ 'i' : ['<plug>(coc-implementation)'     , 'implementation'],
      \ 'r' : ['<plug>(coc-references)'     , 'references'],
      \ 'R' : ['<plug>(coc-rename)'     , 'rename'],
      \ 'f' : [':CocSearch'     , 'search'],
      \ 'w' : [':CocSearch <C-R>=expand("<cword>")<CR><CR>'     , 'search under cursor'],
      \ }


let g:which_key_map.f = {
      \ 'name' : '+fzf' ,
      \ 's' : [':Snippet<cr>'     , 'snippets'],
      \ 'm' : [':Maps<cr>'     , 'mappings'],
      \ 'c' : [':Commands<cr>'     , 'commands'],
      \ 'l' : [':Locate '     , 'locate patterns'],
      \ 'f' : [':FZF<cr>'     , 'search all files'],
      \ 'b' : [':Buffers<cr>'     , 'Buffers'],
      \ 'r' : [':Rg<cr>'     , 'Find inside files'],
      \ }


" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                        , 'add all'],
      \ 'b' : [':Git blame'                        , 'blame'],
      \ 'c' : [':Git commit'                       , 'commit'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 's' : [':Gstatus'                          , 'status'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'p' : [':Git push'                         , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'v' : [':GV<cr>'                         , 'project history'],
      \ 'V' : [':GV!<cr>'                         , 'file history'],
      \ 'B' : [':Gbrowse<cr>'                         , 'open browser'],
      \ }
