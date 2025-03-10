{lib, ...}: let
  contName = "jellyfin";
  dir1 = "/etc/oci.cont/${contName}/config";
in {
  system.activationScripts."make${contName}Dir" = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1} & chown 1000:1000 ${toString dir1}
  '';

  virtualisation.oci-containers.containers."${contName}" = {
    hostname = "${contName}";
    autoStart = true;
    image = "ghcr.io/linuxserver/${toString contName}:10.10.3ubu2404-ls42";

    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "${toString dir1}:/config"
      "/external-media/data/media:/data/media"
      "/mnt/nas-media:/data/nas-media/"
    ];

    ports = [
      "8096:8096"
    ];

    environment = {
      PUID = "1000";
      PGID = "1000";
    };

    extraOptions = [
#      "--network=macvlan_lan"
#      "--ip=192.168.87.32"
       "--device=/dev/dri"
    ];
  };
}
