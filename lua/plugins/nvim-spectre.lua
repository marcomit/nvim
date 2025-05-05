return {
	"nvim-pack/nvim-spectre",
	event = "VeryLazy",
	config = function()
		local map = vim.keymap.set
		map("n", "<leader>sr", require("spectre").open, { desc = "Replace in project (Spectre)" })
		map("n", "<leader>sw", function()
			require("spectre").open_visual({ select_word = true })
		end, { desc = "Search current word in project" })
	end,
}
