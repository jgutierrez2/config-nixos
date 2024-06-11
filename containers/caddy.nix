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
         "/home/jacob/.config/caddy/Caddyfile:/etc/caddy/Caddyfile"
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
  }
