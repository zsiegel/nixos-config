# nixos-config
Contains all of my NixOS-config files.

Adapted from https://codeberg.org/davidak/nixos-config

```bash

# ON HOST MACHINE
rsync -ah --delete --progress $HOME/src/github.com/nixos-config/ root@${HOST}:nixos/

# ON TARGET NIXOS MACHINE
rm /etc/nixos/configuration.nix
ln -s /root/nixos/machines/{MACHINE_NAME}/configuration.nix /etc/nixos/configuration.nix
nixos-rebuild switch

```