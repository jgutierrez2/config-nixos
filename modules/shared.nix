# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gh
    syncthing

    tree
    guile_3_0

    kitty
    emacs
    python3
    ghc

    hyprland
    hyprlock
    wofi
    tofi
    waybar
    hyprpaper
    wl-clipboard
    dmenu-rs
    cliphist

    brave
    kodi

    cifs-utils

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
  ];

  system.activationScripts = {
    mnt = {
      text = "mkdir -p /mnt/nas-media";
      deps = [];
    };
  };

  fileSystems."/mnt/nas-shared" = {
    device = "//192.168.3.196/Shared";
    fsType = "cifs";
    options = [
      "guest"             # No username/password required
      "noperm"
      "uid=1000"
      "gid=1000"
      "file_mode=0777"
      "dir_mode=0777"
    ];
  };

  fileSystems."/mnt/nas-media" = {
    device = "//192.168.3.196/Media";
    fsType = "cifs";
    options = [
      "guest"             # No username/password required
      "noperm"
      "uid=1000"
      "gid=1000"
      "file_mode=0777"
      "dir_mode=0777"
    ];
  };

}
