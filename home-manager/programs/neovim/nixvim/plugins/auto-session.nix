{
  programs.nixvim.plugins.auto-session = {
    enable = true;
    settings = {
      autoSave.enabled = true;
      autoRestore.enabled = true;
      autoSession.enabled = true;
      autoSession.enableLastSession = true;
      autoSession.allowedDirs = ["~/git/" "~/DT/"];
    };
  };
}
