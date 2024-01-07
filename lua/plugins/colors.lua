return {
	'rose-pine/neovim', name = 'rose-pine',
	config = function() 
		function ColorMyPencils(color)
			color = color or "rose-pine"
			vim.cmd.colorscheme(color)
		end


		ColorMyPencils()
	end
}

