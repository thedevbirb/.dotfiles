-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- plugins are stored at ~/.local/share/nvim.
-- plugins are just github repositories

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local fn = vim.fn

---- See neovim from scratch
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("ERROR: packer not loaded properly")
  return
end


-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}



return packer.startup(function(use)
  -- My plugins here --

  -- have packer manage itself
  use { "wbthomason/packer.nvim" }
  -- useful lua function used by lots of plugins
  use { "nvim-lua/plenary.nvim" }

  -- completion with "cmp"
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "hrsh7th/cmp-cmdline" } -- cmdline completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" } -- cmp and lsp integration

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/nvim-lsp-installer" } -- simple to use installer

  -- Git 
  use { "lewis6991/gitsigns.nvim" }

  -- icons and nvim-tree
  use { "kyazdani42/nvim-web-devicons" }
  use { "kyazdani42/nvim-tree.lua" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } -- snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- Telescope
  use { "nvim-telescope/telescope.nvim" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }

  -- Parenthesis configuration
  use { "windwp/nvim-autopairs" } -- autoclose brackets etc
  use { "p00f/nvim-ts-rainbow" } -- rainbow brackets

  -- Comments
  use { "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup()
    end} -- shortcuts to comment code
  use { "JoosepAlviste/nvim-ts-context-commentstring" } -- jsx context comment


  -- colorschemes
  use { "gruvbox-community/gruvbox" }






  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
