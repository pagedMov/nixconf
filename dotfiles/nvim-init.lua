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

	require("lazy").setup({
		{
			"m4xshen/autoclose.nvim",
			config = function()
				require("autoclose").setup({
					options = {
						disable_when_touch = true,
						auto_indent = true,
						disable_command_mode = true,
					},
				})
			end,
		},
		{
			"xeluxee/competitest.nvim",
			dependencies = { 'MunifTanjim/nui.nvim' },
			config = function()
				require("competitest").setup({
					runner_ui = {
						interface = "split",
					}
				})
			end,
		},
		{
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup({
					hide_cursor = false,
				})
			end,
		},
		{
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup({
					indent_guides = true,
				})
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			dependencies = { 'nvim-lua/plenary.nvim' }, -- Ensure this dependency is loaded
			config = function()
				require("gitsigns").setup()
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",  -- Ensure Treesitter is updated
			config = function()
				require('nvim-treesitter.configs').setup {
					highlight = {
						enable = true,
					},
				}
			end,
		},
		{
			"kylechui/nvim-surround",
			config = function()
				require("nvim-surround").setup()
			end,
		},
		{
			"cappyzawa/trim.nvim",
			config = function()
				require("trim").setup()
			end,
		},
		{
			"IogaMaster/neocord",
			config = function()
				require("neocord").setup()
			end,
		},
		{
			"chentoast/marks.nvim",
			config = function()
				require("marks").setup()
			end,
		},
		{
			"romgrk/barbar.nvim",
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				require('bufferline').setup {
					-- Your bufferline configuration here
				}
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("ibl").setup()
			end,
		},
		{
			"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
			lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
			dependencies = {
				-- main one
				{ "ms-jpq/coq_nvim", branch = "coq" },

				-- 9000+ Snippets
				{ "ms-jpq/coq.artifacts", branch = "artifacts" },

				{ 'ms-jpq/coq.thirdparty', branch = "3p" }
			},
			init = function()
				vim.g.coq_settings = {
					auto_start = true, -- if you want to start COQ at startup
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
		"mbbill/undotree",
		"nvim-tree/nvim-web-devicons",
		"hrsh7th/nvim-cmp",
		"voldikss/vim-floaterm",
		"tpope/vim-endwise",
		"dgox16/oldworld.nvim",
		"rktjmp/lush.nvim",
		"justinmk/vim-sneak",
		"junegunn/vim-slash",
		"tpope/vim-fugitive",
	})

-- OPTIONS --------------------------------------------------

	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.hlsearch = true
	vim.opt.incsearch = true
	vim.opt.shiftwidth = 4
	vim.opt.tabstop = 4
	vim.opt.termguicolors = true
	vim.opt.ruler = true

	vim.g.mapleader = "\\"

	vim.diagnostic.config({ signs = false })

	vim.cmd.colorscheme("oldworld")

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
	vim.api.nvim_set_keymap('n', '<leader>rc', ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true, silent = true })

	-- AUTOCMD --------------------------------------------------

	vim.api.nvim_create_autocmd('InsertEnter', {
		pattern = '*',
		command = 'setlocal nocursorline nocursorcolumn',
	})

	vim.api.nvim_create_autocmd({'VimEnter', 'InsertLeave'}, {
		pattern = '*',
		command = 'setlocal cursorline cursorcolumn',
	})

	vim.api.nvim_create_autocmd('VimEnter', {
		pattern = '*',
		command = "set statusline=%{get(b:,'gitsigns_status','')}\\ %f\\ %h%m%r%=%-14.(%l,%c%V%)\\ %P",
	})

	vim.api.nvim_create_autocmd('VimEnter', {
		pattern = '*',
		command = 'wincmd p',
	})

	vim.api.nvim_create_autocmd('VimEnter', {
		pattern = '*',
		command = 'FloatermNew --wintype=float --name=shadeterm --position=topright --autoclose=0 --silent --cwd=<buffer> --titleposition=left',
	})

	vim.api.nvim_create_autocmd('VimEnter', {
		pattern = '*',
		command = 'set foldmethod=indent',
	})

	vim.api.nvim_create_autocmd('VimEnter', {
		pattern = '*',
		command = 'set undofile',
	})

-- CUSTOMS --------------------------------------------------

	--add some custom commands here later maybe?
