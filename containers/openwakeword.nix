{ lib, config, pkgs, ... }:
let
  contName = "openwakeword";
  dir1 = "/etc/oci.cont/${contName}/config";
in {
  system.activationScripts."make${contName}Dir" = lib.stringAfter ["var"] ''
     mkdir -v -p ${toString dir1}
   '';

  virtualisation = {
    oci-containers = {
      containers.openwakeword = {
        image = "rhasspy/wyoming-openwakeword:latest";
        autoStart = true;
        ports = [
          "10400:10400" # Default port for OpenWakeWord
        ];
        volumes = [
          "${toString dir1}:/config" # Mount volume for configuration data
        ];
        environment = {
          PUID = "1000"; # User ID to run the container as
          PGID = "1000"; # Group ID to run the container as
          TZ = "America/Chicago"; # Your timezone
          # OpenWakeWord specific settings
          WAKE_WORDS = "hey_jarvis"; # Comma-separated list of wake words
          THRESHOLD = "0.5"; # Detection threshold (0-1)
          DEBUG = "1"; # Enable debug logging
        };
        extraOptions = [
          "--log-level=debug"
        ];
      };
    };
  };

  # Ensure necessary packages are available
  environment.systemPackages = with pkgs; [
    podman
  ];

  # Open firewall port
  networking.firewall = {
    allowedTCPPorts = [ 10400 ];
  };
}
