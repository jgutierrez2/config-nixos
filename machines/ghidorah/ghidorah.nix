# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{

  imports =
    [ ../../modules/shared.nix

      ../../containers/frigate.nix
      ../../containers/hass.nix
      ../../containers/zwavejs.nix
    ];


  networking.hostName = "ghidorah"; # Define your hostname.

  fileSystems."/external-media" = {
    device = "/dev/disk/by-uuid/6c713be8-7eea-4420-b944-f21cb3542218";
    fsType = "ext4";
  };

 hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2015) or newer processors. LIBVA_DRIVER_NAME=iHD
#      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Optionally, set the env var
  virtualisation.docker.enable = true;

}
