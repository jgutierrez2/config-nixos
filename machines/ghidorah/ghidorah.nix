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
      ../../containers/matter-server.nix
      ../../containers/faster-whisper.nix
      ../../containers/mosquitto.nix
    ];


  networking.hostName = "ghidorah"; # Define your hostname.

  fileSystems."/external-media" = {
    device = "/dev/disk/by-uuid/c2cfd22f-7dbb-49f4-9ac7-208e3f28e4ca";
    fsType = "ext4";
  };

 environment.systemPackages = with pkgs; [
   #  python-matter-server
   ];

 # services.matter-server = {
 #  enable = true;
 #  port = 5580;
 #  };

 networking.firewall.allowedTCPPorts = [ 5580
                                        ];
 networking.firewall.allowedUDPPorts = [ 5580
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

}
