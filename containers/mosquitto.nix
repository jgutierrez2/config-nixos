{lib, ...}: let
  contName = "mosquitto";
  dir1 = "/etc/oci.cont/${contName}";
in {
  system.activationScripts."make${contName}Dir" = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1}/config &
    mkdir -v -p ${toString dir1}/data &
    mkdir -v -p ${toString dir1}/log
  '';

  virtualisation.oci-containers.containers."${contName}" = {
    hostname = "${contName}";
    autoStart = true;
    image = "eclipse-mosquitto:latest";
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
 #     "${toString dir1}/config:/mosquitto/config"
      "${toString dir1}/data:/mosquitto/data"
      "${toString dir1}/log:/mosquitto/log"
    ];
    ports = [
      "1883:1883"  # MQTT
      "9001:9001"  # WebSocket
    ];
    environment = {
      PUID = "1000";
      PGID = "1000";
    };
  };
}
