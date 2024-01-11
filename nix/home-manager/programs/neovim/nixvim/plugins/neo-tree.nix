{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = ":Neotree action=focus reveal toggle<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<C-b>";
        action = ":Neotree toggle<cr>";
        options.silent = true;
      }
    ];

    plugins.neo-tree = {
      enable = true;

      closeIfLastWindow = true;
      buffers.followCurrentFile.enabled = true;
      /*
      window = {
        width = 30;
        autoExpandWidth = true;
      };
      */
    };
  };
}
