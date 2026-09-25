
-----------------------------------------------------------
-- ✨ Leader keys (MÅ stå øverst)
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-----------------------------------------------------------
-- ✨ Generelle innstillinger
-----------------------------------------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 10

local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Clipboard etter UI er lastet
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.o.clipboard = "unnamedplus"
  end,
})

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- ESC fjerner søk
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true })

-- Leader + d → vis diagnoser på linja
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Auto fix error
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code action" })

-----------------------------------------------------------
-- 🚀 Installer lazy.nvim hvis nødvendig
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-----------------------------------------------------------
-- 📦 Plugins
-----------------------------------------------------------
require("lazy").setup({

  -- 🎨 Tema & UI
  { "folke/tokyonight.nvim", name = "tokyonight" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  -- 🌳 Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- 🔍 Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- 🧠 LSP
  { "neovim/nvim-lspconfig" },

  -- ✨ Autocomplete
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- 🔗 Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- 📝 Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
  },
  { "ellisonleao/glow.nvim", cmd = "Glow" },

  -- ↹ Tabout
  {
    "kawre/neotab.nvim",
    config = function()
      require("neotab").setup()
    end,
  },

  -- File explorer
  {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
  end,
},
})


-----------------------------------------------------------
-- 🌳 Treesitter Config
-----------------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "python",
    "java",
    "kotlin",
    "c",
    "cpp",
    "sql",
  },

  highlight = { enable = true },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>v",
      node_incremental = "<leader>v",
      node_decremental = "<leader>c",
      scope_incremental = "<leader>V",
    },
  },

  indent = {
    enable = true,
    disable = { "python" },
  },
})


-----------------------------------------------------------
-- 🔧 Autocomplete (nvim-cmp)
-----------------------------------------------------------
local cmp = require("cmp")

cmp.setup({
  enabled = function()
    local ctx = require("cmp.config.context")
    if vim.api.nvim_get_mode().mode == "c" then
      return true
    else
      return not ctx.in_treesitter_capture("string")
        and not ctx.in_syntax_group("String")
    end
  end,

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end,

    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end,

    ["<C-Space>"] = cmp.mapping.complete(),
  },

  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  },
})

-- Autopairs + cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


-----------------------------------------------------------
-- 🧠 LSP-konfigurasjon
-----------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 🐍 Python
vim.lsp.config.pyright = { capabilities = capabilities }
vim.lsp.enable("pyright")

-- 🧠 C / C++
vim.lsp.config.clangd = { capabilities = capabilities }
vim.lsp.enable("clangd")

-- ☕ Java
vim.lsp.config.jdtls = { capabilities = capabilities }
vim.lsp.enable("jdtls")

-- 🧡 Kotlin
vim.lsp.config.kotlin_language_server = {
  capabilities = capabilities,
}
vim.lsp.enable("kotlin_language_server")

-- (SQL og Gradle LSP er fjernet for nå, siden binærfilene ikke finnes)


-----------------------------------------------------------
-- 🔥 Penere diagnostikk
-----------------------------------------------------------
local signs = {
  Error = " ",
  Warn  = " ",
  Hint  = " ",
  Info  = " ",
}

for type, icon in pairs(signs) do
  vim.fn.sign_define("DiagnosticSign" .. type, {
    text = icon,
    texthl = "DiagnosticSign" .. type,
    numhl = "",
  })
end

vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 2 },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = "always" },
})


-----------------------------------------------------------
-- 🎨 Tema + Lualine
-----------------------------------------------------------
vim.opt.termguicolors = true
vim.o.background = "dark"
vim.cmd("colorscheme tokyonight")

require("lualine").setup({
  options = {
    theme = "tokyonight",
    icons_enabled = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
})


-----------------------------------------------------------
-- 🎨 UI-farger
-----------------------------------------------------------
vim.api.nvim_set_hl(0, "MsgArea", { fg = "#c0caf5" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#565f89" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#565f89" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#bb9af7", bold = true })
