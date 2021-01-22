{ config, pkgs, lib, ... }:
let 
  pubkeys = import ../keys/pubkeys.nix;
in
{
  users.extraUsers.zsiegel = {
    isNormalUser = true;
    extraGroups = lib.mkDefault [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [ pubkeys.zworker01 ];
  };
}
