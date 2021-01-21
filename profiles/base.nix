{ config, pkgs, lib, ... }:
{
  i18n = {
    consoleFont = "Fira Mono";
    defaultLocale = "en_US.UTF-8";
  }
  time.timezone = "America/Chicago";

  # mount tmpfs on /tmp
  boot.tmpOnTmpfs = lib.mkDefault true;

  # install basic packages
  environment.systemPackages = with pkgs; [
    htop
    iotop
    iftop
    wget
    curl
    whois
    file
    lsof
    inotify-tools
    xz
    lz4
    zip
    unzip
    rsync
    xclip
    screen
    yq
    gitAndTools.gitFull
  ];

  programs.bash.enableCompletion = true;

  environment.variables = {
    "EDITOR" = "nano";
    "VISUAL" = "nano";
  };

  # copy the system configuration into nix-store
  system.copySystemConfiguration = true;
}
