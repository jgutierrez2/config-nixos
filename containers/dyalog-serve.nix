{
  config,
  pkgs,
  lib,
  ...
}: let
  contName = "dyalog-serve";
in {

  virtualisation.oci-containers.containers.${contName} = {
    hostname = "${contName}";
    autoStart = true;
    image = "dyalog/dyalog";
    ports = [
      "4502:4502"
    ];

    volumes = [
      "/external-media/data/dyalog:/files"
    ];


    environment = {
      RIDE_INIT = "serve:*:4502";
    };
  };
}
