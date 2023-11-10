-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.signcolumn = 'yes'

vim.g.nobackup = true
vim.g.nowritebackup = true
vim.g.noswapfile = true

-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^')
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'cp', '"+y')
vim.keymap.set({'n', 'x'}, 'cv', '"+p')

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>')

-- Move around windows
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})


-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  -- You can "" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  -- Theming
  {'folke/tokyonight.nvim'},
  {'joshdick/onedark.vim'},
  {'tanvirtin/monokai.nvim'},
  {'lunarvim/darkplus.nvim'},
  {'nvim-lualine/lualine.nvim'},
  {'akinsho/bufferline.nvim'},
  {'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
  {'croaker/mustang-vim'},
  {'towolf/vim-helm'},
  {'fatih/vim-go'},

  -- File explorer
  {'nvim-tree/nvim-tree.lua'},
  {'nvim-tree/nvim-web-devicons'},

  -- Fuzzy finder
  {'nvim-telescope/telescope.nvim', branch = '0.1.x'},
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},

  -- Git
  {'lewis6991/gitsigns.nvim'},
  {'tpope/vim-fugitive'},

  -- Code manipulation
  {'nvim-treesitter/nvim-treesitter'},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'numToStr/Comment.nvim'},
  {'tpope/vim-surround'},
  {'wellle/targets.vim'},
  {'tpope/vim-repeat'},

	-- Code Completion
	{'neoclide/coc.nvim', branch = 'release'},

  -- Utilities
  {'moll/vim-bbye'},
  {'nvim-lua/plenary.nvim'},
  {'editorconfig/editorconfig-vim'},
  {'akinsho/toggleterm.nvim'},
	{'ntpeters/vim-better-whitespace'},
})


-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')


---
-- vim-bbye
---
vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<CR>')


---
-- lualine.nvim (statusline)
---
vim.opt.showmode = false

-- See :help lualine.txt
require('lualine').setup({
  options = {
    theme = 'tokyonight',
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
      statusline = {'NvimTree'}
    }
  },
})


---
-- bufferline
---
-- See :help bufferline-settings
require('bufferline').setup({
  options = {
    mode = 'buffers',
    offsets = {
      {filetype = 'NvimTree'}
    },
  },
  -- :help bufferline-highlights
  highlights = {
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      fg = {attribute = 'fg', highlight = 'Function'},
      italic = false
    }
  }
})


---
-- Treesitter
---
-- See :help nvim-treesitter-modules
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  -- :help nvim-treesitter-textobjects-modules
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  },
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'lua',
    'css',
    'json'
  },
})


---
-- Comment.nvim
---
require('Comment').setup({})


---
-- Indent-blankline
---
-- See :help indent-blankline-setup
require('ibl').setup()


---
-- Gitsigns
---
-- See :help gitsigns-usage
require('gitsigns').setup({
  signs = {
    add = {text = '▎'},
    change = {text = '▎'},
    delete = {text = '➤'},
    topdelete = {text = '➤'},
    changedelete = {text = '▎'},
  }
})


---
-- Telescope
---
-- See :help telescope.builtin
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

require('telescope').load_extension('fzf')


---
-- nvim-tree (File explorer)
---
-- See :help nvim-tree-setup
require('nvim-tree').setup()
--
--  hijack_cursor = false,
--  on_attach = function(bufnr)
--    local bufmap = function(lhs, rhs, desc)
--      vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
--    end
--
--    -- :help nvim-tree.api
--    local api = require('nvim-tree.api')
--    bufmap('L', api.node.open.edit, 'Expand folder or go to file')
--    bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
--    bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
--    bufmap('g?', api.tree.toggle_help, 'Help')
--    bufmap('<CR>', api.node.open.edit, 'Edit')
--  end
--})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')


---
-- toggleterm
---
-- See :help toggleterm-roadmap
require('toggleterm').setup({
  open_mapping = '<C-g>',
  direction = 'horizontal',
  shade_terminals = true
})

---
-- Conquerer of Completion (coc)
---
-- just import from a vimscript file

vim.g.update = 300
vim.opt.signcolumn = 'yes'
vim.cmd('source ~/Repos/dotFiles/coc.vim')

vim.g.coc_global_extensions = {
	'coc-css',
	'coc-docker',
	'coc-lua',
	'coc-git',
	'coc-json',
	'coc-prettier',
	'coc-sh',
	'coc-sql',
	'coc-tsserver',
	'coc-xml',
	'coc-yaml',
	'coc-go',
	'coc-html',
	'coc-vimlsp'
}
