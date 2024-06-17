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

    webdav-server-rs = {
      enable = true;
      settings = {
        server.listen = [ "0.0.0.0:4918" "[::]:4918" ];
        location = [
          {
            route = [ "/public/*path" ];
            directory = "/home/jacob/notes";
            handler = "filesystem";
            methods = [ "webdav-rw" ];
            autoindex = true;
            auth = "false";
          }
          ];
      };
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

                                          #webdav
                                          4918
                                        ];

  #for syncthing
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}
