{
  pkgs,
  lib,
  ...
}: let
  contName = "zwavejs";
  dir1 = "/etc/oci.cont/${contName}/store";
in {
  system.activationScripts.makeFrigateDir = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1}
  '';

  virtualisation.oci-containers.containers.${contName} = {
    hostname = "${contName}";
    autoStart = true;
    image = "zwavejs/zwave-js-ui:latest";
    ports = [
      "8091:8091"
      "3000:3000"
    ];

    volumes = [
      "${dir1}:/usr/src/app/store"
    ];

    extraOptions = [
      "--device=/dev/serial/by-id/usb-Silicon_Labs_Zooz_ZST10_700_Z-Wave_Stick_d8b3184ecd60ec119a403f7625bfaa52-if00-port0:/dev/zwave" 
    ];

  };



}
