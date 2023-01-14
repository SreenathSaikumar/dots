local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer() -- boolean to check if packer was installed

-- vim cmd to autoreload nvim on file save for plugins-setup.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
  ]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim") -- adds lua util functions for nvim plugins

  use("folke/tokyonight.nvim") -- colorscheme

  use("christoomey/vim-tmux-navigator") -- navigation for split windows and tmux(use same plugin)

  use("szw/vim-maximizer") --maximize and restore current window

  use("tpope/vim-surround") --surrounding parenthesis and tag manipulation
  use("vim-scripts/ReplaceWithRegister") --essential
  
  use("numToStr/Comment.nvim") --commenting with gc

  use("nvim-tree/nvim-tree.lua") --nvim file explorer/tree

  use("kyazdani42/nvim-web-devicons") --icons

  use("nvim-lualine/lualine.nvim") --statusline

  --fuzzy find
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) --dependency for telescope
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  --autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")

  --snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  --managing and installing lsp servers
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  --config lsp servers
  use("neovim/nvim-lspconfig")



  if packer_bootstrap then
    require("packer").sync()
  end
end)
