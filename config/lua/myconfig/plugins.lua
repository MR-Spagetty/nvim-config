return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Tree sitter my beloved
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			-- Tiny setup, so it stays here.
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
				auto_install = true,
				highlight = { enable = true },
			})
		end,
	})

	-- Neat very dark theme
	use({
		"dasupradyumna/midnight.nvim",
		-- Autoload
		config = function()
			vim.cmd.colorscheme("midnight")
		end,
	})
end)
