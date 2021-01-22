{ config, pkgs, lib, ... }:

{
  users.extraUsers.zsiegel = {
    isNormalUser = true;
    extraGroups = lib.mkDefault [ "wheel" "docker" ];
  };
}
