{lib, ...}: let
  contName = "calibre-web";
  dir1 = "/etc/oci.cont/${contName}/config";
in {
  system.activationScripts."make${contName}Dir" = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1} & chown 1000:1000 ${toString dir1}
  '';

  virtualisation.oci-containers.containers."${contName}" = {
    hostname = "${contName}";
    autoStart = true;
    image = "ghcr.io/linuxserver/${toString contName}:latest";

    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "${toString dir1}:/config"
      "/external-media/data/media/books:/data/media/books"
    ];

    ports = [
      "8083:8083"
    ];
            
    environment = {
      PUID = "1000";
      PGID = "1000";
    };

  };
}
