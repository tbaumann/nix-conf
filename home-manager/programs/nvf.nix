{...}: {
  stylix.targets.nvf.enable = false;
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        options = {
          # Line numbers
          relativenumber = true; # Relative line numbers
          number = true; # Display the absolute line number of the current line
          /*
          hidden = true; # Keep closed buffer open in the background
          mouse = "a"; # Enable mouse control
          mousemodel = "extend"; # Mouse right-click extends the current selection
          splitbelow = true; # A new window is put below the current one
          splitright = true; # A new window is put right of the current one

          modeline = true; # Tags such as 'vim:ft=sh'
          modelines = 100; # Sets the type of modelines
          undofile = true; # Automatically save and restore undo history
          incsearch = true; # Incremental search: show match for partly typed search command
          inccommand = "split"; # Search and replace: preview changes in quickfix list
          ignorecase = true; # When the search query is lower-case, match both lower and upper-case
          #   patterns
          smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
          #   case characters
          scrolloff = 8; # Number of screen lines to show around the cursor
          cursorline = false; # Highlight the screen line of the cursor
          cursorcolumn = false; # Highlight the screen column of the cursor
          signcolumn = "yes"; # Whether to show the signcolumn
          colorcolumn = "100"; # Columns to highlight
          laststatus = 3; # When to use a status line for the last window
          fileencoding = "utf-8"; # File-content encoding for the current buffer
          termguicolors = true; # Enables 24-bit RGB color in the |TUI|
          spell = false; # Highlight spelling mistakes (local to window)
          wrap = false; # Prevent text from wrapping
          */

          # Tab options
          tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
          shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
          softtabstop = 0; # If non-zero, number of spaces to insert for a <Tab> (local to buffer)
          expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
          autoindent = true; # Do clever autoindenting
          smartindent = true;
        };
        viAlias = false;
        vimAlias = true;
        spellcheck = {
          enable = false;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = false;
          nvim-docs-view.enable = false;
        };

        # This section does not include a comprehensive list of available language modules.
        # To list all available language module options, please visit the nvf manual.
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          # Languages that will be supported in default and maximal configurations.
          nix.enable = true;
          markdown.enable = true;

          # Languages that are enabled in the maximal configuration.
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          sql.enable = true;
          java.enable = false;
          kotlin.enable = false;
          ts.enable = false;
          go.enable = true;
          lua.enable = false;
          zig.enable = false;
          python.enable = true;
          typst.enable = false;
          rust = {
            enable = true;
            crates.enable = true;
          };

          # Language modules that are not as common.
          assembly.enable = false;
          astro.enable = false;
          nu.enable = false;
          csharp.enable = false;
          julia.enable = false;
          vala.enable = false;
          scala.enable = false;
          r.enable = false;
          gleam.enable = false;
          dart.enable = false;
          ocaml.enable = false;
          elixir.enable = false;
          haskell.enable = false;
          ruby.enable = false;

          tailwind.enable = false;
          svelte.enable = false;

          # Nim LSP is broken on Darwin and therefore
          # should be disabled by default. Users may still enable
          # `vim.languages.vim` to enable it, this does not restrict
          # that.
          # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
          nim.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = true; # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = false;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          icon-picker.enable = false;
          surround.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;
          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = false;
          };

          images = {
            image-nvim.enable = false;
          };
        };

        notes = {
          obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = false;
            cmp.enable = true;
          };
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };
      };
    };
  };
}
