local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruvbox-material")
      --
      -- vim.g.gruvbox_material_foreground = "original"
      -- vim.g.gruvbox_material_background = "hard"
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = "*",
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
        },
      })
    end,
  },
  {

    "nvim-lualine/lualine.nvim",
    config = function()
      local lualine = require("lualine")

      lualine.setup({
        options = {
          theme = "gruvbox",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "lsp_progress" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
  {

    "stevearc/dressing.nvim",
    opts = {},
    config = function()
      local dressing = require("dressing")
      dressing.setup({
        input = {
          insert_only = false,
        },
      })
    end,
  },
  {

    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
    config = function()
      local flash = require("flash")
      flash.setup({
        modes = {
          search = {
            enabled = false,
          },
          char = {
            enabled = false,
          },
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local comment = require("Comment")
      comment.setup({})
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },
  {

    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,

            lookahead = true,

            keymaps = {
              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

              ["am"] = {
                query = "@function.outer",
                desc = "Select outer part of a method/function definition",
              },
              ["im"] = {
                query = "@function.inner",
                desc = "Select inner part of a method/function definition",
              },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            },
            goto_next_end = {
              ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
              ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap

      local opts = { noremap = true, silent = true }
      local on_attach = function(client, bufnr)
        opts.buffer = bufnr

        opts.desc = "Show LSP references"
        keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gd", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- opts.desc = "Show buffer diagnostics"
        -- keymap.set("n", "<leader>a", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

      lspconfig["gopls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      lspconfig["helm_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["protols"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- lspconfig["tsserver"].setup({
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      -- })

      -- lspconfig["clangd"].setup({
      -- 	capabilities = capabilities,
      -- 	on_attach = on_attach,
      -- })

      lspconfig["rust_analyzer"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["dartls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["bashls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["solargraph"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      treesitter.setup({
        -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        autotag = {
          enable = true,
        },
        ensure_installed = {
          -- "typescript",
          -- "tsx",
          -- "yaml",
          -- "graphql",
          -- "bash",
          -- "lua",
          -- "vim",
          "go",
          -- "dockerfile",
          -- "gitignore",
          -- "markdown",
          -- "markdown_inline",
          -- "dart",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
  {

    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      local snippet_from_nodes = luasnip.sn

      local s = luasnip.s
      local i = luasnip.insert_node
      local t = luasnip.text_node
      local d = luasnip.dynamic_node
      local c = luasnip.choice_node
      local fmta = require("luasnip.extras.fmt").fmta
      local rep = require("luasnip.extras").rep

      local ts_locals = require("nvim-treesitter.locals")
      local ts_utils = require("nvim-treesitter.ts_utils")

      local get_node_text = vim.treesitter.get_node_text

      local transforms = {
        int = function(_, _)
          return t("0")
        end,

        bool = function(_, _)
          return t("false")
        end,

        string = function(_, _)
          return t([[""]])
        end,

        error = function(_, info)
          if info then
            info.index = info.index + 1

            return c(info.index, {
              t(info.err_name),
              t(string.format('fmt.Wrap(%s, "%s")', info.err_name, info.func_name)),
            })
          else
            return t("err")
          end
        end,

        -- Types with a "*" mean they are pointers, so return nil
        [function(text)
          return string.find(text, "*", 1, true) ~= nil
        end] = function(_, _)
          return t("nil")
        end,
      }

      local transform = function(text, info)
        local condition_matches = function(condition, ...)
          if type(condition) == "string" then
            return condition == text
          else
            return condition(...)
          end
        end

        for condition, result in pairs(transforms) do
          if condition_matches(condition, text, info) then
            return result(text, info)
          end
        end

        return t(text .. "{}")
      end

      local handlers = {
        parameter_list = function(node, info)
          local result = {}

          local count = node:named_child_count()
          for idx = 0, count - 1 do
            local matching_node = node:named_child(idx)
            local type_node = matching_node:field("type")[1]
            table.insert(result, transform(get_node_text(type_node, 0), info))
            if idx ~= count - 1 then
              table.insert(result, t({ ", " }))
            end
          end

          return result
        end,

        type_identifier = function(node, info)
          local text = get_node_text(node, 0)
          return { transform(text, info) }
        end,
      }

      local function_node_types = {
        function_declaration = true,
        method_declaration = true,
        func_literal = true,
      }

      local function go_result_type(info)
        local cursor_node = ts_utils.get_node_at_cursor()
        local scope = ts_locals.get_scope_tree(cursor_node, 0)

        local function_node
        for _, v in ipairs(scope) do
          if function_node_types[v:type()] then
            function_node = v
            break
          end
        end

        if not function_node then
          print("Not inside of a function")
          return t("")
        end

        local query = vim.treesitter.query.parse(
          "go",
          [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
        )
        for _, node in query:iter_captures(function_node, 0) do
          if handlers[node:type()] then
            return handlers[node:type()](node, info)
          end
        end
      end

      local go_ret_vals = function(args)
        return snippet_from_nodes(
          nil,
          go_result_type({
            index = 0,
            err_name = args[1][1],
            func_name = args[2][1],
          })
        )
      end

      luasnip.add_snippets("go", {
        s(
          "efi",
          fmta(
            [[
<val>, <err> := <f>(<args>)
if <err_same> != nil {
	return <result>
}
<finish>
]],
            {
              val = i(1),
              err = i(2, "err"),
              f = i(3),
              args = i(4),
              err_same = rep(2),
              result = d(5, go_ret_vals, { 2, 3 }),
              finish = i(0),
            }
          )
        ),
      })

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-j>"] = cmp.mapping(function()
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function()
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer",  keyword_length = 5 },
        }),
        experimental = {
          native_menu = false,
          ghost_text = true,
        },
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },

  {

    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        -- go = { "golangcilint", "codespell" },
        markdown = { "codespell" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {

    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          go = { "gofumpt" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "helm_ls",
          "rust_analyzer",
          "bashls",
          "lua_ls",
          "gopls",
          "clangd",
          -- "tsserver",
          "terraformls",
          "yamlls",
        },
        automatic_installation = true, -- not the same as ensure_installed
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "stylua", -- lua formatter
        },
      })
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = { hint_prefix = "" },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
})

-- require("davex98.lazy")

vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>a", "<cmd>Telescope diagnostics<cr>")

-- keymap.set("n", "<leader>ff", require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true })
-- telescope
local builtin = require("telescope.builtin")

keymap.set("n", "<C-u>", "<cmd>Telescope find_files<cr>")
-- keymap.set("n", "<leader>ff", telescope.extensions.live_grep_args.live_grep_args, { noremap = true })
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<C-b>', builtin.find_files, {})
vim.keymap.set("n", "<C-g>", builtin.lsp_document_symbols, {})
-- vim.keymap.set('n', '<leader>td', builtin.diagnostics, {})
-- vim.keymap.set('n', '<leader>gs', builtin.grep_string, {})
-- vim.keymap.set('n', '<leader>gg', builtin.live_grep, {})

keymap.set("n", "<leader>e", vim.diagnostic.open_float)
keymap.set("n", "<leader>n", ":nohl<CR>")

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set({ "n", "v" }, "H", "^")
keymap.set({ "n", "v" }, "L", "$")

keymap.set("n", "<leader>w", ":up<CR>")
keymap.set("n", "<leader>q", ":q<CR>")

keymap.set("n", "<leader>co", ":copen<CR>")
keymap.set("n", "<leader>cl", ":cclose<CR>")
keymap.set("n", "<leader>j", ":cnext<CR>zz")
keymap.set("n", "<leader>k", ":cprev<CR>zz")

keymap.set("n", "<leader>v", "<C-w>v")
keymap.set("n", "<leader>s", "<C-w>s")

keymap.set({ "n", "v" }, "<leader>y", '"+y')
keymap.set("n", "<leader>p", '"+p')

keymap.set("n", "<C-h>", ":wincmd h<CR>")
keymap.set("n", "<C-j>", ":wincmd j<CR>")
keymap.set("n", "<C-k>", ":wincmd k<CR>")
keymap.set("n", "<C-l>", ":wincmd l<CR>")

keymap.set("v", '"', '<esc>`>a"<esc>`<i"<esc>')
keymap.set("v", "'", "<esc>`>a'<esc>`<i'<esc>")
keymap.set("v", ")", "<esc>`>a)<esc>`<i(<esc>")
keymap.set("v", "(", "<esc>`>a)<esc>`<i(<esc>")
keymap.set("v", "}", "<esc>`>a}<esc>`<i{<esc>")
keymap.set("v", "{", "<esc>`>a}<esc>`<i{<esc>")
keymap.set("v", "<", "<esc>`>a><esc>`<i<<esc>")
keymap.set("v", ">", "<esc>`>a><esc>`<i<<esc>")

vim.keymap.set("n", "<leader><leader>", "<c-^>")

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.guicursor = ""

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.scrolloff = 8

vim.opt.backspace = "indent,eol,start"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
