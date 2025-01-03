# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’)

{ config, pkgs, lib, ... }:

{

  imports =
    [
      ../../modules/shared.nix
      ./services.nix

   #   ../../containers/homepage.nix
      ../../containers/radarr.nix
      ../../containers/sonarr.nix
      ../../containers/readarr.nix
      ../../containers/calibre.nix
      ../../containers/calibre-web.nix
      ../../containers/sabnzbd.nix
      ../../containers/prowlarr.nix
      ../../containers/jellyfin.nix
      ../../containers/caddy.nix
      ../../containers/dyalog-serve.nix
      ../../containers/dyalog-web.nix
      ../../containers/ollama.nix
    ];

  networking.hostName = "biollante"; # Define your hostname.

  fileSystems."/external-media" = {
    device = "/dev/disk/by-uuid/18c8aea6-4ac9-413b-9a00-22da584dc4a9";
    fsType = "ext4";
  };

  environment.systemPackages = with pkgs; [
    dyalog
    python3
    pkgs.python3Packages.requests
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  nixpkgs.config.dyalog.acceptLicense = true;

 services.xserver = {
  enable = true;
  xkb.layout = "us";
  xkb.options = "apl";
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

  environment.interactiveShellInit = ''
    alias wn='emacsclient ~/notes/work-notes.org'
    PS1="\n┌──(\u@\h)-[\[\w\]]\n└─> "
  '';


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  systemd.services = {
    only-ai = {
      description = "Only AI Chat Application";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        Type = "simple";
        User = "jacob";
        ExecStart = "/home/jacob/.services/only-ai/result/bin/start-app";
        Restart = "always";
        RestartSec = "10";
      };
    };


    only-tasks = {
      description = "Only Tasks Application";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        Type = "simple";
        User = "jacob";
        ExecStart = "/home/jacob/.services/only-tasks/result/bin/task-manager 4000";
        Restart = "always";
        RestartSec = "10";
        WorkingDirectory = "/home/jacob/.services/only-tasks";
        Environment = "PORT=4000";
 };
    };
  };

  #allow chat ai to work
  networking.firewall.allowedTCPPorts = [ 3000 5000
                                          4000];


}
