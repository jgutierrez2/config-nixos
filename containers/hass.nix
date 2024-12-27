{
  pkgs,
  lib,
  ...
}: let
  contName = "hass";
  dir1 = "/etc/oci.cont/${contName}/config";
in {
  system.activationScripts.makeFrigateDir = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1}
  '';

  virtualisation.oci-containers.containers.${contName} = {
    hostname = "${contName}";
    autoStart = true;
    image = "ghcr.io/home-assistant/home-assistant:2024.11";
    ports = [
      "8123:8123"
    ];

    volumes = [
      "${dir1}:/config"
      "/var/run/dbus:/run/dbus:ro"
      "/etc/localtime:/etc/localtime:ro"
      "home-assistant-dockerenv:/.dockerenv"

    ];

    extraOptions = [
      "--net=host"
    ];
  };
}
