{ config, pkgs, ... }:

{
  virtualisation = {
    oci-containers = {
      backend = "podman";
      containers = {
        ollama = {
          image = "docker.io/ollama/ollama:latest";
          autoStart = true;
          ports = [
            "11434:11434"
          ];
          volumes = [
            "ollama:/root/.ollama"
          ];
        };
      };
    };
  };

}
