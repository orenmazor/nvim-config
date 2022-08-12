local utils = require("utils")
local fn = vim.fn

vim.g.package_home = fn.stdpath("data") .. "/site/pack/packer/"
local packer_install_dir = vim.g.package_home .. "/opt/packer.nvim"

local packer_repo = "https://github.com/wbthomason/packer.nvim"
local install_cmd = string.format("10split |term git clone --depth=1 %s %s", packer_repo, packer_install_dir)

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_install_dir) == "" then
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require('packer.util')

packer.startup({
  function(use)
    -- it is recommened to put impatient.nvim before any other plugins
    -- impatient.nvim automatically speeds up neovim bootup time
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

    -- package management for neovim
    use({"wbthomason/packer.nvim", opt = true})

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use({ "neovim/nvim-lspconfig", config = [[require('config.lsp')]] })

    -- Python indent (follows the PEP8 style)
    use({ "psf/black", ft = { "python" } })

    -- Super fast buffer jump
    use {
      'phaazon/hop.nvim',
      event = "VimEnter",
      config = function()
        vim.defer_fn(function() require('config.nvim_hop') end, 2000)
      end
    }

    -- Clear highlight search automatically for you
    -- use({"romainl/vim-cool", event = "VimEnter"})

    -- Show match number and index for searching
    use {
      'kevinhwang91/nvim-hlslens',
      branch = 'main',
      keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
      config = [[require('config.hlslens')]]
    }

    -- A list of colorscheme plugin you may want to try. Find what suits you.
    use({"catppuccin/nvim", as = "catppuccin", opt = true})

    -- Show git change (change, delete, add) signs in vim sign column
    use({"mhinz/vim-signify", event = 'BufEnter'})

    use {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      config = [[require('config.statusline')]]
    }

    use({
      "lukas-reineke/indent-blankline.nvim",
      event = 'VimEnter',
      config = [[require('config.indent-blankline')]]
    })

    -- Highlight URLs inside vim
    use({"itchyny/vim-highlighturl", event = "VimEnter"})

    -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
    -- not be possible since we maybe in a server which disables GUI.
    if vim.g.is_win or vim.g.is_mac then
      -- open URL in browser
      use({"tyru/open-browser.vim", event = "VimEnter"})
    end

    -- Comment plugin
    use({"tpope/vim-commentary", event = "VimEnter"})

    -- Autosave files on certain events
    use({"907th/vim-auto-save", event = "InsertEnter"})

    -- Show undo history visually
    use({"simnalamburt/vim-mundo", cmd = {"MundoToggle", "MundoShow"}})

    -- Manage your yank history
    if vim.g.is_win or vim.g.is_mac then
      use({"svermeulen/vim-yoink", event = "VimEnter"})
    end

    -- Show the content of register in preview window
    -- Plug 'junegunn/vim-peekaboo'
    use({ "jdhao/better-escape.vim", event = { "InsertEnter" } })

    if vim.g.is_mac then
      use({ "lyokha/vim-xkbswitch", event = { "InsertEnter" } })
    elseif vim.g.is_win then
      use({ "Neur1n/neuims", event = { "InsertEnter" } })
    end


    use({ "sbdchd/neoformat", cmd = { "Neoformat" } })
    -- use 'Chiel92/vim-autoformat'

    -- Git command inside vim
    use({ "tpope/vim-fugitive", event = "User InGitRepo" })

    -- Better git log display
    use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })

    -- Another markdown plugin
    use({ "plasticboy/vim-markdown", ft = { "markdown" } })

    use({'folke/zen-mode.nvim', cmd = 'ZenMode', config = [[require('config.zen-mode')]]})

    if vim.g.is_mac then
      use({ "rhysd/vim-grammarous", ft = { "markdown" } })
    end

    -- Add indent object for vim (useful for languages like Python)
    use({"michaeljsmith/vim-indent-object", event = "VimEnter"})

    -- Smoothie motions
    -- use 'psliwka/vim-smoothie'
    use({
      "karb94/neoscroll.nvim",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function() require('config.neoscroll') end, 2000)
      end
    })

    use({"tpope/vim-scriptease", cmd = {"Scriptnames", "Message", "Verbose"}})

    -- showing keybindings
    use {"folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function() require('config.which-key') end, 2000)
    end
    }

  end,
  config = {
    max_jobs = 16,
    compile_path = packer_util.join_paths(fn.stdpath('data'), 'site', 'lua', 'packer_compiled.lua'),
  },
})

local status, _ = pcall(require, 'packer_compiled')
if not status then
  vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
end
