############################################################################
#
#  Main nixos-rebuild commands
#
############################################################################

zuse: 
	nixos-rebuild switch --flake '.#zuse' --impure --use-remote-sudo --log-format internal-json -v |& nom --json

zuse-klappi:
	nixos-rebuild switch --flake '.#zuse-klappi' --impure --use-remote-sudo --log-format internal-json -v --target-host zuse-klappi.local |& nom --json


show:
	nix flake show

update:
	nix flake update

# Update specific input
# usage: make update-input i=wallpapers
update-input:
	nix flake lock --update-input $(i)

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

.PHONY: clean  
clean:  
	rm -rf result
