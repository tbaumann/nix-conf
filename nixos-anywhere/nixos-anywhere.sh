#/bin/bash

nix --extra-experimental-features "nix-command flakes" run github:numtide/nixos-anywhere -- --flake ".#zuse-klappi" $@
