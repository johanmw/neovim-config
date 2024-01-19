return {
	'nvim-telescope/telescope.nvim', tag = '0.1.5',
	--    -- or                              , branch = '0.1.x',
	dependencies = { { 'nvim-lua/plenary.nvim' } },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>gf', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		-- Setup the keymap for Telescope
		-- Find string under cursor
		vim.keymap.set('n', '<leader>ps', '<cmd> Telescope grep_string <cr>')
		-- Find files in project
		vim.keymap.set('n', '<leader>pf', '<cmd> Telescope find_files<cr>')
		-- Find git files
		vim.keymap.set('n', '<leader>pg', '<cmd> Telescope git_files<cr>')
		-- Live grep
		vim.keymap.set('n', '<leader>pl', '<cmd> Telescope live_grep<cr>')
	end
}
