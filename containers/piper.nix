{ config, pkgs, lib, ... }:
  let
    contName = "piper";
    dir1 = "/etc/oci.cont/${contName}/config";
  in 

{
  virtualisation.oci-containers.containers.piper = {
    image = "rhasspy/wyoming-piper:latest";
    ports = [
      {
        hostAddress = "0.0.0.0";
        hostPort = 10200;
        containerPort = 10200;
      }
    ];
    volumes = [
      "${toString dir1}:/data"
    ];
    extraOptions = [
      "--voice"
      "en_US-lessac-medium"
    ];
  };
}
