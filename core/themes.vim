let s:theme_setup_dict = {}

function! s:theme_setup_dict.catppuccin() dict abort
  let g:catppuccin_flavour = "frappe" " latte, frappe, macchiato, mocha

  lua require("catppuccin").setup()
  colorscheme catppuccin
endfunction

" Theme to directory name mapping, because theme repo name is not necessarily
" the same as the theme name itself.
let s:theme2dir = {
      \ 'catppuccin': 'catppuccin'
      \ }

let s:theme = utils#RandElement(keys(s:theme2dir))
let s:colorscheme_func = printf('s:theme_setup_dict.%s()', s:theme)

if !has_key(s:theme_setup_dict, s:theme)
  let s:msg = "Invalid colorscheme function: " . s:colorscheme_func
  call v:lua.vim.notify(s:msg, 'error', {'title': 'nvim-config'})
  finish
endif

let s:status = utils#add_pack(s:theme2dir[s:theme])
if !s:status
  echomsg printf("Theme %s not installed. Run PackerSync to install.", s:theme)
  finish
endif

execute 'call ' . s:colorscheme_func
if g:logging_level == 'debug'
  let s:msg1 = "Colorscheme: " . s:theme
  call v:lua.vim.notify(s:msg1, 'info', {'title': 'nvim-config'})
endif
