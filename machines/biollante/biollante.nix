# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’)

{ config, pkgs, lib, ... }:

{

  imports =
    [
      ../../modules/shared.nix
      ./services.nix

      ../../containers/homepage.nix
      ../../containers/radarr.nix
      ../../containers/sonarr.nix
      ../../containers/readarr.nix
      ../../containers/calibre.nix
      ../../containers/calibre-web.nix
      ../../containers/sabnzbd.nix
      ../../containers/prowlarr.nix
      ../../containers/jellyfin.nix
      ../../containers/caddy.nix
    ];

  networking.hostName = "biollante"; # Define your hostname.

  fileSystems."/external-media" = {
    device = "/dev/disk/by-uuid/18c8aea6-4ac9-413b-9a00-22da584dc4a9";
    fsType = "ext4";
  };

  environment.systemPackages = with pkgs; [
    tmux
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];


 hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2015) or newer processors. LIBVA_DRIVER_NAME=iHD
#      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Optionally, set the env var
  virtualisation.docker.enable = true;

  environment.interactiveShellInit = ''
    alias wn='emacsclient ~/notes/work-notes.org'
    PS1="> "
  '';
}
