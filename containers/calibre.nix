{lib, ...}: let
  contName = "calibre";
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
      "8980:8080"
      "8981:8081"
    ];
            
    environment = {
      PUID = "1000";
      PGID = "1000";
    };

  };
}
