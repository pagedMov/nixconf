-- PLUGINS --------------------------------------------------

	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

	require('agtp')
	require("lazy").setup({
		{ -- LSP configuration
			"neovim/nvim-lspconfig",
			lazy = false,
			dependencies = {
				-- main one
				{ "ms-jpq/coq_nvim", branch = "coq" },

				-- 9000+ Snippets
				{ "ms-jpq/coq.artifacts", branch = "artifacts" },

				{ 'ms-jpq/coq.thirdparty', branch = "3p" }
			},
			init = function()
				vim.g.coq_settings = {
					auto_start = true,
				}
			end,
			config = function()
				local nvim_lsp = require('lspconfig')
				local servers = { 'pyright', 'clangd' }
				for _, lsp in ipairs(servers) do
					nvim_lsp[lsp].setup {
						flags = {
							debounce_text_changes = 150,
						}
					}
				end

				nvim_lsp.lua_ls.setup {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
								path = vim.split(package.path, ';'),
							},
							diagnostics = {
								globals = { 'vim' },
							},
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
							telemetry = {
								enable = false,
							},
						},
					},
				}
			end,
		},
		-- color schemes --
		"miikanissi/modus-themes.nvim",
		"EdenEast/nightfox.nvim",

		-- quality of life --
		'MunifTanjim/nui.nvim', -- Dependency for competitest
		"m4xshen/autoclose.nvim", -- Automatically close brackets and quotes
		"nvim-treesitter/nvim-treesitter", -- Syntax highlighting
		"cappyzawa/trim.nvim", -- Remove trailing whitespace on file write
		"rktjmp/lush.nvim", -- Tool for creating color schemes
		"mbbill/undotree", -- Visualize vim undo tree
		"mateuszwieloch/automkdir.nvim", -- Automatically create missing parent directories when writing file
		"kylechui/nvim-surround", -- Create a close character when you type an open character
		"lukas-reineke/indent-blankline.nvim", -- Automatically indent new lines
		"lewis6991/gitsigns.nvim", -- Show changes compared to repository
		"tpope/vim-endwise", -- Automatically generate close statements
		"tris203/precognition.nvim", -- Render key combinations for vim motions in buffer
		"nvim-lualine/lualine.nvim", -- Customizable status bar
		"doctorfree/cheatsheet.nvim", -- A cheatsheet for common commands
		"chentoast/marks.nvim", -- Show marks in the vert bar
		"Xuyuanp/scrollbar.nvim", -- A scrollbar
		"ethanholz/nvim-lastplace", -- Re-open files at last edit position
		-- extra functionality --
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		'xeluxee/competitest.nvim', -- UI for competitive programming
		"IogaMaster/neocord", -- Discord rich presence integration
		"folke/trouble.nvim", -- Window for LSP errors/warnings
		"nvim-tree/nvim-web-devicons", -- Icons for LSP server
		"hrsh7th/nvim-cmp", -- Autocompletion
		"voldikss/vim-floaterm", -- Floating terminal windows
		"justinmk/vim-sneak", -- New motion lets you search for two-character patterns
		"junegunn/vim-slash", -- Better search functionality
		"tpope/vim-fugitive", -- Better git integration
	})

	-- plugin setup --

	require('marks').setup()
	require('gitsigns').setup()
	require('nvim-surround').setup()
	require('nvim-lastplace').setup()
	require('trouble').setup()
	require('competitest').setup()
	require('nvim-web-devicons').setup()
	require('cmp').setup()
	require('ibl').setup()
	require("neocord").setup()

	require("autoclose").setup({
		options = {
			disable_when_touch = true,
			auto_indent = true,
			disable_command_mode = true,
		},
	})
	require('nvim-treesitter.configs').setup {
		highlight = {
			enable = true,
		},
	}
	require('lualine').setup {
		options = {
			icons_enabled = true,
			theme = 'auto',
			component_separators = { left = '', right = ''},
			section_separators = { left = '', right = ''},
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'buffers'},
			lualine_c = {''},
			lualine_x = {'searchcount', 'fileformat', 'filetype'},
			lualine_y = {'branch', 'diff', 'diagnostics'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {'location'},
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}

	require("modus-themes").setup({
		style = "auto",
		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			functions = { bold = true },
			variables = {},
		}
	})

-- OPTIONS --------------------------------------------------

	if vim.g.neovide then
		vim.g.neovide_refresh_rate = 144
		vim.g.neovide_cursor_vfx_mode = "sonicboom"
		vim.g.neovide_cursor_animate_in_insert_mode = false
	end

	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.hlsearch = true
	vim.opt.incsearch = true
	vim.opt.shiftwidth = 4
	vim.opt.tabstop = 4
	vim.opt.termguicolors = true
	vim.opt.ruler = true
	vim.opt.scrolloff = 6
	vim.opt.undofile = true
	vim.opt.foldmethod = "indent"

	vim.g.mapleader = "\\"

	vim.diagnostic.config({ signs = false })

	vim.o.background = "dark"
	-- vim.cmd.colorscheme("modus")
	vim.cmd.colorscheme("carbonfox")

-- KEYMAPS --------------------------------------------------

	vim.api.nvim_set_keymap('n', '<A-]>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<A-[>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<C-[>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<C-]>', '<Cmd>BufferMoveNext<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<space>', 'zA', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<F2>', ':FloatermToggle shadeterm<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<F3>', ':FloatermNew --wintype=float --name=rangerterm --position=topleft --autoclose=2 --opener=edit --cwd=<buffer> --titleposition=left ranger<CR><CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('t', '<F2>', '<C-\\><C-n>:FloatermToggle shadeterm<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('t', '<F3>', '<C-\\><C-n>:FloatermKill rangerterm<CR>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<Esc>', '<Esc>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('v', '<Esc>', '<Esc>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('c', '<Esc>', '<Esc>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>rp', ":lua require('refactoring').debug.printf({below = false})<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap('x', '<leader>rv', ":lua require('refactoring').debug.print_var()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>rv', ":lua require('refactoring').debug.print_var()<CR>", { noremap = true, silent = true })

-- AUTOCMD --------------------------------------------------

	vim.api.nvim_create_autocmd({'BufReadPost', 'BufWinEnter'}, {
		pattern = '*',
		command = 'normal! zR',
	})

	vim.api.nvim_create_autocmd('VimEnter', { -- terminal window
		pattern = '*',
		command = 'FloatermNew --wintype=float --name=shadeterm --position=topright --autoclose=0 --silent --cwd=<buffer> --titleposition=left',
	})

	-- scrollbar
	vim.api.nvim_create_augroup("ScrollbarCMDs", { clear = true })
	vim.api.nvim_create_autocmd({ "WinScrolled", "VimResized", "QuitPre", "WinEnter", "FocusGained", }, {
		pattern = '*',
		command = 'lua require("scrollbar").show()',
		group = "ScrollbarCMDs",
	})
	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "BufWinLeave", "FocusLost", }, {
		pattern = '*',
		command = 'lua require("scrollbar").clear()',
		group = "ScrollbarCMDs",
	})
