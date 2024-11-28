{
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;

      settings = {
        theme = "dark";
        auto_close = false;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>m";
        action = ":MarkdownPreview<cr>";
        options.silent = true;
      }
    ];
  };
}
