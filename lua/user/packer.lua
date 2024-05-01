-- check and install packer if unavailable.
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

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Plugin for packer starter.
  use 'wbthomason/packer.nvim'
  -- Plugin for everforest colorscheme.
  use 'OurCodeBase/everforest-nvim'
  -- Plugin for lualine for ui.
  use 'nvim-lualine/lualine.nvim'
  -- Plugin for auto pairs.
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }
  -- Plugin for wilder.nvim.
  use 'gelguy/wilder.nvim'
  if packer_bootstrap then
    require('packer').sync()
  end
end)
