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
  use {
    "OurCodeBase/everforest-nvim",
    config = function()
    require("everforest").setup({
      background = "hard",
      ui_contrast = "low",
      dim_inactive_windows = false,
      better_performance = true,
    })
  end
  }
  -- Plugin for lualine for ui.
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
    require("lualine").setup({
      options = { 
        theme = 'auto',
        icons_enabled = false
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename'},
        lualine_y = {'filetype'},
        lualine_z = {'location'}
      }
    })
    end
  }
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup {}
    end
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
