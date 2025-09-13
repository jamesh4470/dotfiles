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

-- opts = {x} is equivalent to require(plugin).setup({x})
-- if vimscript is required for config, add a config function.
-- opts will not call require() if config function is defined.
-- pass in opts as config's second argument to use opts alongside config: config(_, opts)

require("lazy").setup({
    {
        "navarasu/onedark.nvim",
        opts = {
            style = "dark"
        },
        config = function(_, opts)
            require("onedark").setup(opts)
            require("onedark").load()
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "onedark",
                section_separators = {left = "", right = ""}
            }
        }
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = {
                enable = true
            }
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
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
            vim.keymap.set('n', '<M-w>', '<Cmd>bd<CR>', {})
            vim.keymap.set('n', '<M-h>', '<Cmd>BufferLineCyclePrev<CR>', {})
            vim.keymap.set('n', '<M-l>', '<Cmd>BufferLineCycleNext<CR>', {})
            vim.keymap.set('n', '<M-j>', '<Cmd>BufferLineMovePrev<CR>', {})
            vim.keymap.set('n', '<M-k>', '<Cmd>BufferLineMoveNext<CR>', {})
        end
    },

    {
        "numToStr/Comment.nvim",
        opts = {
            toggler = {
                line = "<C-_>"
            },
            opleader = {
                line = "<C-_>"
            }
        }
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require("rainbow-delimiters.setup").setup()
        end
    },

    {
        "akinsho/toggleterm.nvim",
        opts = {
            open_mapping = [[<c-\>]],
            direction = "vertical",
            size = 75,
        },
    },

    {
        "folke/which-key.nvim",
        opts = {},
    },

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
                    ['<M-[>'] = cmp.mapping.scroll_docs(-4),
                    ['<M-]>'] = cmp.mapping.scroll_docs(4),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<Tab>'] = cmp.mapping.confirm({select = true})
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {{name = "buffer"}})
            })
            local default_capabilities = require('cmp_nvim_lsp').default_capabilities()
            require("lspconfig")["clangd"].setup({
                capabilities = default_capabilities,
            })
            -- require("lspconfig")["lua_ls"].setup({
                -- capabilities = default_capabilities
            -- })
            require("lspconfig")["rust_analyzer"].setup({
                capabilities = default_capabilities,
                settings = {["rust-analyzer"] = {}},
            })
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
    },

})
