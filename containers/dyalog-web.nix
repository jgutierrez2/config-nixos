{
  config,
  pkgs,
  lib,
  ...
}: let
  contName = "dyalog-web";
in {

  virtualisation.oci-containers.containers.${contName} = {
    hostname = "${contName}";
    autoStart = true;
    image = "dyalog/dyalog";
    ports = [
      "8888:8888"
    ];

    volumes = [
      "/external-media/data/dyalog:/files"
    ];


    environment = {
      RIDE_INIT = "http:*:8888";
    };
  };
}
