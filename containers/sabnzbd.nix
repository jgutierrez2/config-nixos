{lib, ...}: let
  contName = "sabnzbd";
  dir1 = "/etc/oci.cont/${contName}";
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
      "/external-media/data/usenet:/data/usenet"       "/mnt/nas-media/downloads/usenet:/data/nas-media/downloads/usenet"
    ];

    ports = [
      "2000:8080"
    ];

    environment = {
      PUID = "1000";
      PGID = "1000";
    };

#    extraOptions = [
#      "--network=macvlan_lan"
#      "--ip=192.168.87.32"
#    ];
  };
}
