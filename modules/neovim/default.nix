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

  cosmos-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "cosmos-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "fedepujol";
      repo = "cosmos.nvim";
      rev = "2f68ef50bda517e45f9207f26b1a2911cea02cf9";
      sha256 = "1kf01b8399rc09rvl7rnixfqia0q4l39izpk0hw48rrjyb3qgnic";
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

  nerdicons-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "nerdicons";
    src = pkgs.fetchFromGitHub {
      owner = "nvimdev";
      repo = "nerdicons.nvim";
      rev = "6dfb8abaf278f6075605902f5e79b8fef9403b3b";
      sha256 = "11gbf28x2f4cywxgqdmdn6r4m050crj43mzvymaadrsbfy863hyc";
    };
  };

in
{
  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        cosmos-nvim

        # Dev Specific
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
        fidget-nvim

        # Formatter
        {
          plugin = formatter-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/formatter.lua);
        }

        # Linter
        {
          plugin = nvim-lint;
          type = "lua";
          config = builtins.readFile (./lua/plugins/lint.lua);
        }

        # Icons
        nvim-web-devicons
        {
          plugin = nerdicons-nvim;
          type = "lua";
          config = builtins.readFile (./lua/plugins/nerdicons.lua);
        }

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
          plugin = nvim-treesitter.withAllGrammars;
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

        # Motions
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
      extraLuaConfig = builtins.readFile (./init.lua);
      extraPackages = with pkgs; [
        tree-sitter

        # Lsp's
        marksman
        nil
        nodePackages.bash-language-server
        nodePackages.typescript-language-server
        nodePackages.vim-language-server
        nodePackages.vscode-langservers-extracted
        nodePackages.yaml-language-server
        python310Packages.python-lsp-server
        rust-analyzer
        sumneko-lua-language-server

        # Formatter's
        nixpkgs-fmt
        nodePackages.prettier
        rustfmt
        stylua

        # Linter's
        nodePackages.markdownlint-cli
        shellcheck
        yamllint
      ];
    };
  };
}
