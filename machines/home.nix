# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’)

{ config, pkgs, lib, ... }:

{

  imports =
    [
      ../modules/shared.nix

      ../containers/radarr.nix
      ../containers/sonarr.nix
      ../containers/readarr.nix
      ../containers/calibre.nix
      ../containers/calibre-web.nix
      ../containers/sabnzbd.nix
      ../containers/prowlarr.nix
      ../containers/jellyfin.nix
      ../containers/caddy.nix
    ];

  networking.hostName = "home"; # Define your hostname.

  fileSystems."/external-media" = {
    device = "/dev/disk/by-uuid/18c8aea6-4ac9-413b-9a00-22da584dc4a9";
    fsType = "ext4";
  };

  environment.systemPackages = with pkgs; [

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

  services = {
    ttyd = {
      enable = true;
      writeable = true;
      port = 7681;
      terminalType = "xterm-direct";
#      entrypoint = [ "bash" ];
    };

    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      user = "jacob";
      configDir = "/home/jacob/.config/syncthing";
    };

    emacs = {
      enable = true;
    };
  };

  #for ttyd
  networking.firewall.allowedTCPPorts = [ 7681

                                          #syncthing
                                          8384
                                          22000
                                        ];

  #for syncthing
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  environment.interactiveShellInit = ''
    alias wn='emacsclient ~/notes/work-notes.org'
  '';
}
