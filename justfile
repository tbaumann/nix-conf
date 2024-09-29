############################################################################
#
#  Main nixos-rebuild commands
#
############################################################################

default: zuse

zuse: 
	NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --flake '.#zuse' --impure --use-remote-sudo --log-format internal-json -v --show-trace  |& nom --json

zuse-klappi:
	NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --flake '.#zuse-klappi' --impure --use-remote-sudo --log-format internal-json -v --target-host zuse-klappi.local |& nom --json

nas: 
	nixos-rebuild switch --flake '.#nas' --impure --use-remote-sudo --log-format internal-json -v --show-trace  --target-host nas.local |& nom --json

router:
	nixos-rebuild switch --flake '.#router' --impure --use-remote-sudo --log-format internal-json -v --target-host router.local |& nom --json

router-image:
  nix build '.#nixosConfigurations.router.config.system.build.sdImage' --impure --out-link result-router-image --log-format internal-json -v --show-trace  |& nom --json

nas-image:
  nix build '.#nixosConfigurations.nas.config.system.build.sdImage' --impure --out-link result-nas-image --log-format internal-json -v --show-trace  |& nom --json

topology:
  nix build '.#topology.x86_64-linux.config.output' --impure --out-link result-topology


show:
	nix flake show

update:
	nix flake update

# Update specific input
# usage: make update-input i=wallpapers
update-input:
	nix flake lock --update-input "$@"

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	nix-collect-garbage -d

############################################################################
#
#  Misc, other useful commands
#
############################################################################

fmt:
	# format the nix files in this repo
	nix fmt

clean:  
	rm -rf result
