{lib, ...}: let
  contName = "readarr";
  dir1 = "/etc/oci.cont/${contName}";
in {
  system.activationScripts."make${contName}Dir" = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1} & chown 1000:1000 ${toString dir1}
  '';

  virtualisation.oci-containers.containers."${contName}" = {
    hostname = "${contName}";
    autoStart = true;
    image = "ghcr.io/linuxserver/${toString contName}:develop";

    volumes = [
      "/etc/localtime:/etc/localtime:ro"
      "${toString dir1}:/config"
      "/external-media/data:/data"
    ];

    ports = [
      "8787:8787"
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
