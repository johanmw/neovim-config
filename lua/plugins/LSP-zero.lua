return {
	'VonHeikemen/lsp-zero.nvim', branch='v3.x',
	config = function ()
		local lsp_zero = require('lsp-zero')
		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({buffer = bufnr})
		end)
	
		-- see :help lsp-zero-guide:integrate-with-mason-nvim
		-- to learn how to use mason.nvim with lsp-zero
		require('mason').setup({})
		require('mason-lspconfig').setup({
			handlers = {
				lsp_zero.default_setup,
			}
		})
	end
}

