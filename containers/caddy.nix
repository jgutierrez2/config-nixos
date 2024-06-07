{lib, ...}: let
   contName = "caddy";
   dir1 = "/etc/oci.cont/${contName}/config";
   dir2 = "/etc/oci.cont/${contName}/data";
   dir3 = "/etc/oci.cont/${contName}/site";
 in {
   system.activationScripts."make${contName}Dir" = lib.stringAfter ["var"] ''
     mkdir -v -p ${toString dir1} && mkdir -v -p ${toString dir2} && mkdir -v -p ${toString dir3} 
   '';

   virtualisation.oci-containers.containers."${contName}" = {
       hostname = "${contName}";
       autoStart = true;
       image = "${toString contName}:latest";

       volumes = [
         "${toString dir1}:/config"
         "${toString dir2}:/data"
         "${toString dir3}:/srv"
         "/etc/oci.cont/${contName}/config/Caddyfile:/etc/caddy/Caddyfile"
       ];

       ports = [
         "80:80"
         "443:443"
         "443:443/udp"
       ];

       environment = {
         PUID = "1000";
         PGID = "1000";
       };
     };
   environment.etc."oci.cont/${contName}/config/Caddyfile" = {
     text = ''
   http://fluidd.gooterez.me {
     reverse_proxy 192.168.3.186:80
   }

   http://fin.gooterez.me {
     reverse_proxy 192.168.3.101:8096
   }

   http://radarr.gooterez.me {
     reverse_proxy 192.168.3.101:7878
   }

   http://sonarr.gooterez.me {
     reverse_proxy 192.168.3.101:8989
   }

   http://readarr.gooterez.me {
     reverse_proxy 192.168.3.101:8787
   }

   http://prowlarr.gooterez.me {
     reverse_proxy 192.168.3.101:9696
   }

   http://sabnzbd.gooterez.me {
     reverse_proxy 192.168.3.101:2000
   }

   http://frigate.gooterez.me {
     reverse_proxy 192.168.3.102:5000
   }

   http://hass.gooterez.me {
     reverse_proxy 192.168.3.102:8123
   }

   http://pkm.gooterez.me {
     reverse_proxy 192.168.3.101:7681
   }
     '';
   };
 }
