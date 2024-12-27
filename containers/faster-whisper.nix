{ lib,config, pkgs, ... }:
let
  contName = "faster-whisper";
  dir1 = "/etc/oci.cont/${contName}/config";
in {
  system.activationScripts."make${contName}Dir" = lib.stringAfter ["var"] ''
     mkdir -v -p ${toString dir1}
   '';

  virtualisation = {
    oci-containers = {
      containers.faster-whisper = {
        image = "lscr.io/linuxserver/faster-whisper:latest"; # Use the latest tag or specify another
        autoStart = true;
        ports = [
          "10300:10300" # Expose the default port for faster-whisper
        ];
        volumes = [
          "${toString dir1}:/config" # Mount volume for configuration data
        ];
        environment = {
          PUID = "1000"; # User ID to run the container as
          PGID = "1000"; # Group ID to run the container as
          TZ = "Chicago/America"; # Timezon
          WHISPER_MODEL = "tiny-int8"; # Set your model
          WHISPER_LANG = "en"; # Optional language setting
        };
        # If using GPU
        # extraOptions = [ "--gpus=all" ]; 
      };
    };
  };

  # Ensure necessary packages are available
  environment.systemPackages = with pkgs; [
    podman
    nvidia-docker # If you're using NVIDIA GPUs
  ];
}
