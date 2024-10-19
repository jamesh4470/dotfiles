im.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.bo.softtabstop = 4
vim.wo.number = true

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
    -- {
    --     "navarasu/onedark.nvim",
    --     config = function()
    --         require("onedark").setup({style = "cool"})
    --         require("onedark").load()
    --     end
    -- },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        opts = {},
        config = function()
            vim.o.background = "dark" -- or "light" for light mode
            vim.cmd([[colorscheme gruvbox]])
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {}
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

    -- {
    --     "romgrk/barbar.nvim",
    --     opts = {
    --         animations = true
    --     }
    -- },

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
    -- {"nvim-tree/nvim-web-devicons"},
    -- {"lewis6991/gitsigns.nvim"},

    {"neovim/nvim-lspconfig"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"SirVer/ultisnips"},
    {"quangnguyen30192/cmp-nvim-ultisnips"},

    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body)
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
                    { name = 'ultisnips' },
                    { name = 'buffer'}
                })
            })
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            require("lspconfig")["clangd"].setup {
                capabilities = capabilities
            }
            -- require("lspconfig")["lua_ls"].setup {
            --     capabilities = capabilities
            -- }
            -- require("lspconfig")["pyright"].setup {
            --     capabilities = capabilities
            -- }
        end
    }

})
