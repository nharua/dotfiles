return {
	{ -- Install/Manage LSP servers, DAP servers, linters and formatters.
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{ -- mason-lspconfig briges mason.vim with the lspconfig
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "verible" },
			})
		end,
	},
	{ -- Install formatter in Mason
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = { "stylua", "isort", "black", "verible" },
			})
		end,
	},
	{ -- Useful status updates for LSP
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		-- help communicate between nvim and language servers
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			-- local verible_cofig_path = vim.fn.expand("/home/$USER/.config/nvim")
			lspconfig.lua_ls.setup({
				-- cmd = {...},
				-- filetypes { ...},
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							-- Tells lua_ls where to find all the Lua files that you have loaded
							-- for your neovim configuration.
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
							-- If lua_ls is really slow on your computer, you can try this instead:
							-- library = { vim.env.VIMRUNTIME },
						},
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "requirements.txt", "Pipfile"),
			})
			lspconfig.verible.setup({
				capabilities = capabilities,
				-- cmd = { 'verible-verilog-ls', '--rules_config_search' },
				-- cmd = { "verible-verilog-ls", "--rules_config", "/home/rua/.config/nvim/.rules.verible_lint" },
				cmd = {
					"verible-verilog-ls",
					"--rules_config",
					vim.fn.expand("/home/$USER/.config/nvim/.rules.verible_lint"),
				},
				root_dir = function()
					return vim.loop.cwd()
				end,
			})
			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					-- map("<leader>gf", vim.lsp.buf.format, "[G]oto [F]ormatation")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				end,
			})
		end,
	},
}
