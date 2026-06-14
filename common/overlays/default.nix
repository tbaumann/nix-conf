{ inputs, ... }: {
  nixpkgs.overlays = with inputs; [
    llm-agents.overlays.default
    # FahrenheitResearch Rust-backed weather stack + hermes weather plugin.
    (_final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (import ../../pkgs/python-weather/default.nix)
      ];
    })
  ];
}
