vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.pumheight = 12;
vim.opt.showmode = false;
vim.keymap.set('n', '<Esc>', [[<cmd>nohlsearch<CR>]])
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('n', '<C-w><Left>', [[<cmd>vertical resize -5<CR>]])
vim.keymap.set('n', '<C-w><Right>', [[<cmd>vertical resize +5<CR>]])
vim.keymap.set('n', '<C-w><Up>', [[<cmd>resize +5<CR>]])
vim.keymap.set('n', '<C-w><Down>', [[<cmd>resize -5<CR>]])

vim.diagnostic.config({
    virtual_text = true
})

vim.pack.add({
    "https://github.com/navarasu/onedark.nvim",

    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/lewis6991/gitsigns.nvim",

    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/HiPhish/rainbow-delimiters.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/williamboman/mason.nvim",

    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/hrsh7th/nvim-cmp",

    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/BurntSushi/ripgrep",
    "https://github.com/nvim-telescope/telescope.nvim",
})

require("onedark").setup({style = "darker"})
require("onedark").load()

require("lualine").setup({})

-- install tree-sitter-cli via package manager
local languages = {"python", "rust", "c", "cpp"}
require("nvim-treesitter").install(languages)
vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function() vim.treesitter.start() end,
})

require("mason").setup({})

require("nvim-autopairs").setup({})

require("rainbow-delimiters.setup").setup({
    highlight = {
        "RainbowDelimiterViolet", "RainbowDelimiterBlue",
        "RainbowDelimiterCyan",   "RainbowDelimiterGreen",
        "RainbowDelimiterYellow", "RainbowDelimiterOrange",
        "RainbowDelimiterRed",
    }
})

local ibl_hl = {
    "RainbowDelimiterViolet", "RainbowDelimiterBlue",
    "RainbowDelimiterCyan",   "RainbowDelimiterGreen",
    "RainbowDelimiterYellow", "RainbowDelimiterOrange",
    "RainbowDelimiterRed",
}
require("ibl").setup({
    indent = {char = "▏", highlight = ibl_hl}
})

require("bufferline").setup({
    options = {
        separator_style = "slant",
    }
})
vim.keymap.set('n', '<M-w>', '<Cmd>bd<CR>', {})
vim.keymap.set('n', '<M-h>', '<Cmd>BufferLineCyclePrev<CR>', {})
vim.keymap.set('n', '<M-l>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<M-j>', '<Cmd>BufferLineMovePrev<CR>', {})
vim.keymap.set('n', '<M-k>', '<Cmd>BufferLineMoveNext<CR>', {})

require("Comment").setup({
    toggler  = {line = "<C-_>"},
    opleader = {line = "<C-_>"},
})

require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    direction = "vertical",
    size = 75,
})

require("which-key").setup({})

require("gitsigns").setup({})

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<M-[>'] = cmp.mapping.scroll_docs(-4),
        ['<M-]>'] = cmp.mapping.scroll_docs(4),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources(
        { { name = 'nvim_lsp' }, { name = 'luasnip' } },
        { { name = 'buffer' } }
    )
})

vim.lsp.config.clangd = {}
vim.lsp.config.lua_ls = {}
vim.lsp.config.rust_analyzer = {}
vim.lsp.config.pyright = {}
vim.lsp.config.jdtls = {}
vim.lsp.enable({"clangd", "rust_analyzer", "jdtls", "pyright"})

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-t>', builtin.find_files, {desc = 'Telescope find files'})
vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find, {desc = 'Telescope search buffer'})
