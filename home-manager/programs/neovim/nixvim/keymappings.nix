{
  config,
  lib,
  nixvimLib,
  ...
}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = let
      normal =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          "<C-b>" = ":Neotree toggle<cr>";

          # fix Y behaviour
          "Y" = "yy";

          # back and fourth between the two most recent files
          "<C-c>" = ":b#<CR>";

          # close by Ctrl+x
          "<C-x>" = ":close<CR>";

          "<C-s>" = ":w<CR>";

          # navigate to left/right window
          "<leader>h" = "<C-w>h";
          "<leader>l" = "<C-w>l";

          # resize with arrows
          "<C-Up>" = ":resize -2<CR>";
          "<C-Down>" = ":resize +2<CR>";
          "<C-Left>" = ":vertical resize +2<CR>";
          "<C-Right>" = ":vertical resize -2<CR>";

          # move current line up/down
          # M = Alt key
          "<M-k>" = ":move-2<CR>";
          "<M-j>" = ":move+<CR>";

          "<leader>rp" = ":!remi push<CR>";
        };
      visual =
        lib.mapAttrsToList
        (key: action: {
          mode = "v";
          inherit action key;
        })
        {
          # better indenting
          ">" = ">gv";
          "<" = "<gv";
          "<TAB>" = ">gv";
          "<S-TAB>" = "<gv";

          # move selected line / block of text in visual mode
          "K" = ":m '<-2<CR>gv=gv";
          "J" = ":m '>+1<CR>gv=gv";
        };
    in
      nixvimLib.nixvim.keymaps.mkKeymaps
      {options.silent = true;}
      (normal ++ visual);
  };
}
