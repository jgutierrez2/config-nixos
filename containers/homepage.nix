{lib, ...}: let
  contName = "homepage";
in {

  virtualisation.oci-containers.containers."${contName}" = {
    hostname = "${contName}";
    autoStart = true;
    image = "ghcr.io/gethomepage/${toString contName}:latest";
  
    volumes = [
      "/home/jacob/.config/homepage:/app/config"
      "/run/user/1000/podman/podman.sock:/var/run/docker.sock"
    ];

    ports = [
      "3000:3000"
    ];
            
    environment = {
      PUID = "1000";
      PGID = "1000";
    };
  };
}
