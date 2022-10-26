scriptencoding utf-8

" Plugin specification and lua stuff
lua require('lua-init')

" Use short names for common plugin manager commands to simplify typing.
" To use these shortcuts: first activate command line with `:`, then input the
" short alias, e.g., `pi`, then press <space>, the alias will be expanded to
" the full command automatically.
call utils#Cabbrev('pi', 'PackerInstall')
call utils#Cabbrev('pud', 'PackerUpdate')
call utils#Cabbrev('pc', 'PackerClean')
call utils#Cabbrev('ps', 'PackerSync')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      configurations for vim script plugin                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-n> :bnext<CR>:redraw<CR>:ls<CR>

""""""""""""""""""""""""""""ale linter settings"""""""""""""""""""""""""""""""
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9 ctermbg=Black guifg=#C30500 guibg=Black
highlight ALEWarningSign ctermfg=11 ctermbg=Black guifg=#ED6237 guibg=Black
highlight ALEError ctermfg=Black ctermbg=DarkGrey guifg=#C30500 guibg=Black
highlight ALEWarning ctermfg=Black ctermbg=DarkGrey guifg=#ED6237 guibg=Black
let g:ale_linters = {'python': ['flake8','mypy'],
      \ 'lua': ['luacheck'],
      \ 'sh': ['shellcheck'],
      \ 'markdown': ['vale', 'markdownlint'],
      \ 'text': ['vale'],
      \ 'yaml': ['yamllint'],
      \ 'terraform': ['terraform', 'tflint']}

let g:ale_fixers = {'python': ['black'],
      \ 'terraform': ['terraform'],
      \ '*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_python_flake8_options = '--max-line-length=90'
let g:ale_python_mypy_options = '--strict'
let g:ale_fix_on_save = 1


""""""""""""""""""""""""""""vim-matchup settings"""""""""""""""""""""""""""""
" Improve performance
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_timeout = 100
let g:matchup_matchparen_insert_timeout = 30

" Enhanced matching with matchup plugin
let g:matchup_override_vimtex = 1

" Whether to enable matching inside comment or string
let g:matchup_delim_noskips = 0

" Show offscreen match pair in popup window
let g:matchup_matchparen_offscreen = {'method': 'popup'}


"""""""""""""""""""""""""""""LeaderF settings"""""""""""""""""""""
" Do not use cache file
" let g:Lf_UseCache = 1
" " Refresh each time we call leaderf
" let g:Lf_UseMemoryCache = 1

" Ignore certain files and directories when searching files
" let g:Lf_WildIgnore = {
"   \ 'dir': ['__pycache__', '.DS_Store'],
"   \ 'file': ['*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png',
"   \ '*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz',
"   \ '*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp',
"   \ '*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf',
"   \ '*.mp3', '*.aac']
"   \}

" Only fuzzy-search files names
let g:Lf_DefaultMode = 'FullPath'

" Popup window settings
let w = float2nr(&columns * 0.8)
if w > 140
  let g:Lf_PopupWidth = 140
else
  let g:Lf_PopupWidth = w
endif

let g:Lf_PopupPosition = [0, float2nr((&columns - g:Lf_PopupWidth)/2)]

" Do not use version control tool to list files under a directory since
" submodules are not searched by default.
let g:Lf_UseVersionControlTool = 1

" Use rg as the default search tool
let g:Lf_DefaultExternalTool = "rg"

" show dot files
let g:Lf_ShowHidden = 0

" " Disable default mapping
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

" set up working directory for git repository
let g:Lf_WorkingDirectoryMode = 'a'

" remember where you stopped
" let g:Lf_RememberLastSearch = 1
" Search files in popup window
nnoremap <silent> <leader>ff :<C-U>Leaderf file --popup<CR>

" Grep project files in popup window
nnoremap <silent> <leader>fg :<C-U>Leaderf rg --no-messages --popup<CR>

" Search vim help files
nnoremap <silent> <leader>fh :<C-U>Leaderf help --popup<CR>

" Search tags in current buffer
nnoremap <silent> <leader>ft :<C-U>Leaderf bufTag --popup<CR>

" Switch buffers
nnoremap <silent> <leader>fb :<C-U>Leaderf buffer --popup<CR>

" Search recent files
nnoremap <silent> <leader>fr :<C-U>Leaderf mru --popup --absolute-path<CR>

let g:Lf_PopupColorscheme = 'gruvbox_material'

" Change keybinding in LeaderF prompt mode, use ctrl-n and ctrl-p to navigate
" items.
let g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}


""""""""""""""""""""""""""""vim-yoink settings"""""""""""""""""""""""""
if g:is_win || g:is_mac
  " ctrl-n and ctrl-p will not work if you add the TextChanged event to vim-auto-save events.
  " nmap <c-n> <plug>(YoinkPostPasteSwapBack)
  " nmap <c-p> <plug>(YoinkPostPasteSwapForward)

  " The following p/P mappings are also needed for ctrl-n and ctrl-p to work
  " nmap p <plug>(YoinkPaste_p)
  " nmap P <plug>(YoinkPaste_P)

  " Cycle the yank stack with the following mappings
  nmap [y <plug>(YoinkRotateBack)
  nmap ]y <plug>(YoinkRotateForward)

  " Do not change the cursor position
  nmap y <plug>(YoinkYankPreserveCursorPosition)
  xmap y <plug>(YoinkYankPreserveCursorPosition)

  " Move cursor to end of paste after multiline paste
  let g:yoinkMoveCursorToEndOfPaste = 0

  " Record yanks in system clipboard
  let g:yoinkSyncSystemClipboardOnFocus = 1
endif

""""""""""""""""""""""""""""better-escape.vim settings"""""""""""""""""""""""""
let g:better_escape_interval = 200

"""""""""""""""""""""""""vim-signify settings""""""""""""""""""""""""""""""
" The VCS to use
let g:signify_vcs_list = [ 'git' ]

" Change the sign for certain operations
let g:signify_sign_change = '~'

"""""""""""""""""""""""""vim-fugitive settings""""""""""""""""""""""""""""""
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gc :Git commit<CR>
nnoremap <silent> <leader>gd :Gdiffsplit<CR>
nnoremap <silent> <leader>gpl :Git pull<CR>
" Note that to use bar literally, we need backslash it, see also `:h :bar`.
nnoremap <silent> <leader>gpu :15split \| term git push<CR>

"""""""""""""""""""""""""plasticboy/vim-markdown settings"""""""""""""""""""
" Disable header folding
let g:vim_markdown_folding_disabled = 1

" Whether to use conceal feature in markdown
let g:vim_markdown_conceal = 1

" Disable math tex conceal and syntax highlight
let g:tex_conceal = ''
let g:vim_markdown_math = 0

" Support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Let the TOC window autofit so that it doesn't take too much space
let g:vim_markdown_toc_autofit = 1




""""""""""""""""""""""""""""vim-startify settings""""""""""""""""""""""""""""
" Do not change working directory when opening files.
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1



""""""""""""""""""""""""""""""vim-auto-save settings""""""""""""""""""""""""""""""
let g:auto_save = 1  " enable AutoSave on Vim startup
