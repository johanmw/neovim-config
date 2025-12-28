return {
	'williamboman/mason-lspconfig.nvim',
	dependencies = {
		'williamboman/mason.nvim',
		'neovim/nvim-lspconfig',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip'
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup {
			ensure_installed = {
				'lua_ls',
				'clangd',
				'bashls',
			},
			handlers = {
				function(server_name)
          vim.lsp.config("lspconfig")[server_name].setup{}
				end,
				['lua_ls'] = function()
					-- No keymapping for lua for now needs fixing.
          vim.lsp.config('lspconfig').lua_ls.setup{

						on_init = function(client)
							local path = client.workspace_folders[1].name
							print (path)
							if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
								client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
									Lua = {
										runtime = {
											-- Tell the language server which version of Lua you're using
											-- (most likely LuaJIT in the case of Neovim)
											version = 'LuaJIT'
										},
										-- Make the server aware of Neovim runtime files
										workspace = {
											checkThirdParty = false,
											library = {
												vim.env.VIMRUNTIME
												-- "${3rd}/luv/library"
												-- "${3rd}/busted/library",
											}
											-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
											-- library = vim.api.nvim_get_runtime_file("", true)
										}
									}
								})

								client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
							end
							return true
						end
				  }
				end
			}
		}

		local cmp = require'cmp'

		cmp.setup({
			snippet = {
				expand = function(args)
					 require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' }, -- For luasnip users.
			}, {
				{ name = 'buffer' },
			})
		})

		-- Set configuration for specific filetype.
		cmp.setup.filetype('gitcommit', {
			sources = cmp.config.sources({
				{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
			}, {
				{ name = 'buffer' },
			})
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		})

		-- Set up lspconfig.
		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    --vim.lsp.config('lspconfig')['clangd'].setup {
    --0vim.lsp.config['clangd'].setup {
    vim.lsp.config('clangd', {
			capabilities = capabilities
		})
--	require('lspconfig')['lua_ls'].setup {
--		capabilities = capabilities
--	}

	end,

}
