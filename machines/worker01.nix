{ config, pkgs, lib, ... }:
let 
  pubkeys = import ../keys/pubkeys.nix;
in
{
  imports = 
    [
      /etc/nixos/hardware-configuration.nix
      ../services/grub.nix
      "../profiles/base.nix"
      "../services/docker.nix"
      "../users/zsiegel/base.nix"
    ];

  boot.loader.grub.device = "/dev/sda";

  networking = {
    hostname = "zworker01";
    domain = "zlan";
 
    # Router sets static IP for me
    interfaces.en01.useDHCP = true;
 
    nameservers = [ "192.168.11.2" "1.1.1.1" "1.0.0.1" ];
    defaultGateway = [ "192.168.11.2" ];
  };

  users.extraUsers.zsiegel = {
    openssh.authorizedKeys.keys = [ pubkeys.zworker01 ];
  };

  # from https://codeberg.org/davidak/nixos-config
  # show IP in login screen
  # https://github.com/NixOS/nixpkgs/issues/63322
  environment.etc."issue.d/ip.issue".text = "\\4\n";
  networking.dhcpcd.runHook = "${pkgs.utillinux}/bin/agetty --reload";
}
