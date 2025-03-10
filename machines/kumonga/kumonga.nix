# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  imports =
    [ ../../modules/shared.nix
      ./packages.nix
      ./services.nix
    ];

  networking.hostName = "kumonga"; # Define your hostname.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #allow chat ai to work
  networking.firewall.allowedTCPPorts = [ 3000 5000 8000 ];

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
