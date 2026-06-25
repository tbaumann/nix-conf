{inputs, ...}: {
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = {
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };
      aws = {
        disabled = true;
        symbol = "🅰 ";
      };
      gcloud = {
        disabled = true;
        # do not show the account/project's info
        # to avoid the leak of sensitive information when sharing the terminal
        format = "on [$symbol$active(\($region\))]($style) ";
        symbol = "🅶 ️";
      };

      palette = "catppuccin_mocha";
    };
  };
}
