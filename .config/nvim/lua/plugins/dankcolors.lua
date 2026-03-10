return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1a1b26',
				base01 = '#1a1b26',
				base02 = '#d3d4d8',
				base03 = '#d3d4d8',
				base04 = '#444547',
				base05 = '#f9fbff',
				base06 = '#f9fbff',
				base07 = '#f9fbff',
				base08 = '#ff7fa2',
				base09 = '#ff7fa2',
				base0A = '#75a1ff',
				base0B = '#72ff87',
				base0C = '#c0d4ff',
				base0D = '#75a1ff',
				base0E = '#d7e3ff',
				base0F = '#d7e3ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#d3d4d8',
				fg = '#f9fbff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#75a1ff',
				fg = '#1a1b26',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#d3d4d8' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#c0d4ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#d7e3ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#75a1ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#75a1ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#c0d4ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#72ff87',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#444547' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#444547' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#d3d4d8',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
