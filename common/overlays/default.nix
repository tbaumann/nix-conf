{inputs, ...}: {
  nixpkgs.overlays = with inputs; [llm-agents.overlays.default];
}
