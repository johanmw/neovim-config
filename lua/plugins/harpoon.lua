return {
	'ThePrimeagen/harpoon',
	requires = {"nvim-lua/plenary.nvim"},
	config = function() 
		require("telescope").load_extension('harpoon')

		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")


		-- C-H may be mapped to another command in this shell. It does not seem to work.
		vim.keymap.set("n", "<leader>a", function() mark.add_file() end)
		vim.keymap.set("n", "<C-e>", function() ui.toggle_quick_menu() end)
		vim.keymap.set('n', "<C-j>", function() require("harpoon.ui").nav_file(1) end) 
		vim.keymap.set('n', "<C-t>", function() require("harpoon.ui").nav_file(2) end) 
		vim.keymap.set('n', "<C-n>", function() require("harpoon.ui").nav_file(3) end) 
		vim.keymap.set('n', "<C-s>", function() require("harpoon.ui").nav_file(4) end) 
	end
}
