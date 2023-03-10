{ pkgs, ... }:

let
  move-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "move-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "fedepujol";
      repo = "move.nvim";
      rev = "4f72d2d86f4392cec1aa4e0a8c20314022a806ad";
      sha256 = "16vz4x2s34ym3rrsjzzqfrk9d17p7d9ql0s10qbkhlak47d4clcd";
    };
  };

  nv-themes = pkgs.vimUtils.buildVimPlugin {
    name = "nv-themes";
    src = pkgs.fetchFromGitHub {
      owner = "fedepujol";
      repo = "nv-themes";
      rev = "54ea65615605024409d094bfa64eabff9c30f2b1";
      sha256 = "1vz3lg5zdhd8bkqcpmr07xz5paz7ckmfvgsbpklj6rr40zclsvb7";
    };
  };

  shipwright = pkgs.vimUtils.buildVimPlugin {
    name = "shipwright";
    src = pkgs.fetchFromGitHub {
      owner = "rktjmp";
      repo = "shipwright.nvim";
      rev = "ab70e80bb67b7ed3350bec89dd73473539893932";
      sha256 = "0ysada38r6slbyypm00fg25ig4xadg1m3ssbf5h6cxpml4i2sb8v";
    };
  };

  heirline-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "heirline-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "rebelot";
      repo = "heirline.nvim";
      rev = "00f7e271775362792116e252d931590a9344d6a9";
      sha256 = "1cf9av6h5xdzkvzrmwscld65257syx0mk1czi5gkwg10apyyhfzw";
    };
  };

in
{
  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        nv-themes

        # Neodev
        {
          plugin = neodev-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/neodev.lua);
        }

        # Lsp
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = builtins.readFile (./lua/plugins/lspconfig.lua);
        }
        emmet-vim
        nvim-code-action-menu
        fidget-nvim

        # Icons
        nvim-web-devicons

        # Colors
        {
          plugin = nvim-colorizer-lua;
          type = "lua";
          config = builtins.readFile (./lua/plugins/colorizer.lua);
        }
        lush-nvim
        shipwright

        # Completion
        {
          plugin = nvim-cmp;
          type = "lua";
          config = builtins.readFile (./lua/plugins/completion.lua);
        }
        cmp-buffer
        cmp-nvim-lua
        cmp-nvim-lsp
        cmp-path
        cmp-nvim-lsp-document-symbol
        cmp-cmdline
        cmp-vsnip
        vim-vsnip

        # UI
        {
          plugin = barbar-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/barbar.lua);
        }
        {
          plugin = toggleterm-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/toggleterm.lua);
        }
        {
          plugin = neo-tree-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/neo-tree.lua);
        }

        {
          plugin = heirline-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/heirline.lua);
        }

        # FZF
        plenary-nvim
        popup-nvim
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/telescope.lua);
        }
        telescope-fzf-native-nvim

        # Git
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/gitsigns.lua);
        }

        # Treesitter
        {
          plugin = nvim-treesitter.withPlugins (
            plugins: with plugins; [
              tree-sitter-bash
              tree-sitter-cpp
              tree-sitter-css
              tree-sitter-haskell
              tree-sitter-html
              tree-sitter-java
              tree-sitter-json
              tree-sitter-lua
              tree-sitter-nix
              tree-sitter-python
              tree-sitter-rust
              tree-sitter-typescript
              tree-sitter-vim
              tree-sitter-yaml
            ]
          );
          type = "lua";
          config = builtins.readFile (./lua/plugins/tree-sitter.lua);
        }

        nvim-ts-rainbow

        # Editor Features
        {
          plugin = comment-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/comment.lua);
        }

        {
          plugin = nvim-autopairs;
          type = "lua";
          config = builtins.readFile (./lua/plugins/autopairs.lua);
        }

        # Keys
        move-nvim
        {
          plugin = which-key-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/whichkey.lua);
        }
        {
          plugin = better-escape-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/betterescape.lua);
        }
      ];
      extraConfig = builtins.readFile (./init.vim);
      extraPackages = with pkgs; [
        tree-sitter

        # Lsp
        nodePackages.bash-language-server
        nodePackages.typescript-language-server
        nodePackages.vim-language-server
        nodePackages.vscode-langservers-extracted
        nodePackages.yaml-language-server
        python310Packages.python-lsp-server
        nil
        sumneko-lua-language-server
        rust-analyzer

        # Formatters
        nixpkgs-fmt
        rustfmt
      ];
    };
  };
}
