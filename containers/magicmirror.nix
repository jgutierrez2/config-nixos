{
  config,
  pkgs,
  lib,
  ...
}: let
  contName = "magicmirror";
  dir1 = "/etc/oci.cont/${contName}/config";
  dir2 = "/etc/oci.cont/${contName}/modules";
  dir3 = "/etc/oci.cont/${contName}/css";
in {
  system.activationScripts.makeFrigateDir = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1} ${toString dir2} ${toString dir3}
  '';

  virtualisation.oci-containers.containers.${contName} = {
    hostname = "${contName}";
    autoStart = true;
    image = "karsten13/magicmirror:v2.29.0";
    ports = [
      "8080:8080"
    ];

    volumes = [
      "${toString dir1}:/config"
      "${toString dir2}:/modules"
      "${toString dir3}:/css"
      "/etc/localtime:/etc/localtime:ro"
    ];


  };
}
