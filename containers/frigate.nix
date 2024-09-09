{
  config,
  pkgs,
  lib,
  ...
}: let
  contName = "frigate";
  rtmp = 1935;
  web = 5000;
  rtsp = 8554;
  webRTC = 8555;
  dir1 = "/etc/oci.cont/${contName}/db";
  dir2 = "/external-media/${contName}/media";
  dir3 = "/home/jacob/.config/${contName}";
in {
  system.activationScripts.makeFrigateDir = lib.stringAfter ["var"] ''
    mkdir -v -p ${toString dir1} ${toString dir2}
  '';

  # make tmpdir for frigate to use, ssd wear bla bla, probs isnt even working :)
  fileSystems."/tmp/cache" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=1G" "mode=755"];
  };

  virtualisation.oci-containers.containers.${contName} = {
    hostname = "${contName}";
    autoStart = true;
    image = "ghcr.io/blakeblackshear/frigate:0.14.1";
    ports = [
      "${toString rtmp}:${toString rtmp}"
      "${toString web}:${toString web}"
      "${toString rtsp}:${toString rtsp}"
      "${toString webRTC}:${toString webRTC}/tcp"
      "${toString webRTC}:${toString webRTC}/udp"
    ];

    volumes = [
      "${toString dir1}:/db"
      "${toString dir2}:/media/frigate"
      "${toString dir3}:/config"
      "/etc/localtime:/etc/localtime:ro"
    ];

    extraOptions = [
 #     "--network=macvlan_lan"
 #     "--ip=${secrets.ip.frigate}"
      "--privileged"
      "--shm-size=512m"
#      "--device=/dev/bus/usb:/dev/bus/usb" # coral
      "--device=/dev/dri/renderD128" # gpu
      "--mount=type=tmpfs,target=/tmp/cache,tmpfs-size=1000000000" # tempfs
    ];
  };
}
