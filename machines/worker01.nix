{ config, pkgs, lib, ... }:
let 
  pubkeys = import ../keys/pubkeys.nix;
in
{
  imports = 
    [
      /etc/nixos/hardware-configuration.nix
      ../services/grub.nix
      ../services/docker.nix
      ../profiles/base.nix
      ../users/zsiegel.nix
    ];

  boot.loader.grub.device = "/dev/sda";

  users.users.zsiegel.openssh.authorizedKeys.keys = [ pubkeys.zworker01 ];

  networking = {
    hostName = "zworker01";
    domain = "zlan";
 
    # Router sets static IP for me
    interfaces.en01.useDHCP = true;
 
    nameservers = [ "192.168.11.2" "1.1.1.1" "1.0.0.1" ];
    defaultGateway = "192.168.11.2";
  };

  # from https://codeberg.org/davidak/nixos-config
  # show IP in login screen
  # https://github.com/NixOS/nixpkgs/issues/63322
  environment.etc."issue.d/ip.issue".text = "\\4\n";
  networking.dhcpcd.runHook = "${pkgs.utillinux}/bin/agetty --reload";
}
