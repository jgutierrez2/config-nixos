{
  pkgs,
  lib,
  ...
}: let
  contName = "matter-server";
  dir1 = "/etc/oci.cont/${contName}/config";
in {
  system.activationScripts.makeMatterServerDir = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1}
  '';

  virtualisation.oci-containers.containers.${contName} = {
    hostname = "${contName}";
    autoStart = true;
    image = "ghcr.io/home-assistant-libs/python-matter-server:6.6";
    extraOptions = [ "--network=host" ];
    volumes = [
      "${dir1}:/data/"
      "/var/run/dbus:/run/dbus:ro"
      "/etc/localtime:/etc/localtime:ro"
    ];
  };
}
