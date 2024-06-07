{
  services = {
    syncthing = {
      enable = true;
      user = "jacob";
      dataDir = "/home/jacob/Documents";
      configDir = "/home/jacob/.config/syncthing";
    };

    pipewire = {
      enable = tue;
      pulse.enable = true;
    };
  };
}
