{
  inputs,
  pkgs,
  astronvim,
  ...
}:
###############################################################################
#
#  AstroNvim's configuration and all its dependencies(lsp, formatter, etc.)
#
#e#############################################################################
{
  xdg.configFile = {
    # astronvim's config
    "nvim".source = inputs.astronvim;

    # https://docs.astronvim.com/configuration/manage_user_config/ and https://github.com/AstroNvim/user_example
    "astronvim/lua/user/mappings.lua".text = ''
      return {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map

          ["Y"] = { "yy", desc = "Yank line the right way"},
          -- quick save
          ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
        t = {
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
      }
    '';

    "astronvim/lua/user/plugins/community.lua".text = ''
      return {
        "AstroNvim/astrocommunity",
        { import = "astrocommunity.colorscheme.catppuccin", enabled = true},
        { import = "astrocommunity.completion.copilot-lua-cmp" },
        { import = "astrocommunity.comment.mini-comment" },
        { import = "astrocommunity.syntax.vim-cool" },
        { import = "astrocommunity.scrolling.vim-smoothie" },
      }
    '';
  };
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = false;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;
      extraPackages = with pkgs; [];
    };
  };
  home = {
    packages = with pkgs; [
      #-- c/c++
      cmake
      cmake-language-server
      gnumake
      checkmake
      gcc # c/c++ compiler, required by nvim-treesitter!
      llvmPackages.clang-unwrapped # c/c++ tools with clang-tools such as clangd
      gdb
      lldb

      #-- python
      nodePackages.pyright # python language server
      python311Packages.black # python formatter
      python311Packages.ruff-lsp

      #-- rust
      rust-analyzer
      cargo # rust package manager
      rustfmt

      #-- nix
      nil
      rnix-lsp
      # nixd
      statix # Lints and suggestions for the nix programming language
      deadnix # Find and remove unused code in .nix source files
      alejandra # Nix Code Formatter

      #-- lua
      stylua
      lua-language-server
      lua

      #-- bash
      nodePackages.bash-language-server
      shellcheck
      shfmt

      #-- javascript/typescript --#
      nodePackages.typescript
      nodePackages.typescript-language-server
      # HTML/CSS/JSON/ESLint language servers extracted from vscode
      nodePackages.vscode-langservers-extracted
      nodePackages."@tailwindcss/language-server"

      #-- Others
      taplo # TOML language server / formatter / validator
      nodePackages.yaml-language-server
      sqlfluff # SQL linter
      actionlint # GitHub Actions linter
      buf # protoc plugin for linting and formatting
      proselint # English prose linter

      #-- Misc
      tree-sitter # common language parser/highlighter
      nodePackages.prettier # common code formatter
      marksman # language server for markdown
      glow # markdown previewer

      #-- Optional Requirements:
      gdu # disk usage analyzer, required by AstroNvim
      ripgrep # fast search tool, required by AstroNvim's '<leader>fw'(<leader> is space key)
    ];
  };
}
