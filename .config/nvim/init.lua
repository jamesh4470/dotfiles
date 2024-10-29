vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.bo.softtabstop = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.o.pumheight = 12;
vim.opt.showmode = false;
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "navarasu/onedark.nvim",
        -- config = function()
        --     require("onedark").setup({style = "cool"})
        --     require("onedark").load()
        -- end
    },

    {
        "ellisonleao/gruvbox.nvim",
        -- priority = 1000,
        -- config = true,
        -- opts = {},
        -- config = function()
        --     vim.o.background = "dark" -- or "light" for light mode
        --     vim.cmd([[colorscheme gruvbox]])
        -- end
    },

    {
        "sainnhe/everforest",
        priority = 1000,
        opts = {},
        config = function()
            vim.g.everforest_enable_italic = true
            vim.g.everforest_background = 'medium'
            vim.cmd.colorscheme('everforest')
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "everforest"
            }
        }
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = {
                enable = true
            }
        }
    },

    {
        "williamboman/mason.nvim",
        opts = {}
    },

    {
        "windwp/nvim-autopairs",
        opts = {}
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },

    {
        "akinsho/bufferline.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        opts = {
            options = {
                separator_style = "slant",
            }
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            vim.keymap.set('n', '<C-w>', '<Cmd>bd<CR>', {})
            vim.keymap.set('n', '<C-h>', '<Cmd>BufferLineCyclePrev<CR>', {})
            vim.keymap.set('n', '<C-l>', '<Cmd>BufferLineCycleNext<CR>', {})
            vim.keymap.set('n', '<C-j>', '<Cmd>BufferLineMovePrev<CR>', {})
            vim.keymap.set('n', '<C-k>', '<Cmd>BufferLineMoveNext<CR>', {})
        end
    },

    {
        "numToStr/Comment.nvim",
        opts = {
            toggler = {
                line = [[<C-_>]]
            },
            opleader = {
                line = [[<C-_>]]
            }
        }
    },

    {"andweeb/presence.nvim"},

    {"nvim-tree/nvim-web-devicons"},
    {"lewis6991/gitsigns.nvim"},

    {"neovim/nvim-lspconfig"},
    {"hrsh7th/cmp-nvim-lsp"},
    {'hrsh7th/cmp-buffer'},
    {"L3MON4D3/LuaSnip"},
    {"saadparwaiz1/cmp_luasnip"},

    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true })
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, { {name = "buffer" } })
            })
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            require("lspconfig")["clangd"].setup {
                capabilities = capabilities
            }
        end
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep"
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<C-t>', builtin.find_files, {desc = 'Telescope find files'})
            vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find, {desc = 'Telescope search buffer'})
        end
    }

})
