{ config, pkgs, ... } :
{

  services = {
    ttyd = {
      enable = true;
      writeable = true;
      port = 7681;
      terminalType = "xterm-direct";
      entrypoint = [ "${pkgs.shadow}/bin/login" ];
      #extraOptions = "new -A -s ttyd";
      };

    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      user = "jacob";
      configDir = "/home/jacob/.config/syncthing";
    };

    emacs = {
      enable = true;
    };
  };

  #for ttyd
  networking.firewall.allowedTCPPorts = [ 7681

                                          #syncthing
                                          8384
                                          22000
                                        ];

  #for syncthing
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}
