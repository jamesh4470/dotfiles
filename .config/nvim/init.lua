vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.bo.softtabstop = 4
vim.wo.number = true

return require('packer').startup(function(use)

    use {"wbthomason/packer.nvim"}
    use {"navarasu/onedark.nvim"}
    use {'nvim-lualine/lualine.nvim'}
    use {"nvim-treesitter/nvim-treesitter"}
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}
    use {"williamboman/mason.nvim"}
    use {"windwp/nvim-autopairs"}
    use {"nvim-tree/nvim-tree.lua"}
    use {"andweeb/presence.nvim"}
    use {"nvim-tree/nvim-web-devicons"}
    use {"lukas-reineke/indent-blankline.nvim"}
    use {"lewis6991/gitsigns.nvim"}
    use {"romgrk/barbar.nvim"}
    use {"numToStr/Comment.nvim"}

    use {"neovim/nvim-lspconfig"}
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"SirVer/ultisnips"}
    use {"quangnguyen30192/cmp-nvim-ultisnips"}

    require("onedark").setup({style = "darker"})
    require("onedark").load()

    require("lualine").setup()

    require "nvim-treesitter.configs".setup({
        highlight = {
            enable = true
        }
    })

    require("toggleterm").setup ({
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
            border = "curved"
        }
    })

    require("mason").setup()

    require("nvim-autopairs").setup()

    require("nvim-tree").setup({
         vim.keymap.set("n", "<C-t>", require("nvim-tree.api").tree.toggle)
    })

    require("indent_blankline").setup({
        show_current_context = true
    })

    require("barbar").setup({
        animations = true
    })

    require("Comment").setup({
        toggler = {
            line = [[<C-_>]]
        },
        opleader = {
            line = [[<C-_>]]
        }
    })

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
            { name = 'ultisnips' }
        }, {
            { name = 'buffer' }
	})
    })
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    require("lspconfig")["pyright"].setup {
        capabilities = capabilities
    }
    require("lspconfig")["clangd"].setup {
        capabilities = capabilities
    }
    require("lspconfig")["lua_ls"].setup {
        capabilities = capabilities
    }

end)
