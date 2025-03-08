{ config, pkgs, lib, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gh
    syncthing
    cloudflare-warp

    tree
    guile_3_0

    kitty
    python3
    stack

    hyprland
    hyprpaper
    hypridle
    hyprlock
    xdg-desktop-portal-hyprland
    # hyprsysteminfo
    hyprsunset
    hyprpolkitagent
    # hyprland-qt-support

    hyprcursor
    hyprutils
    hyprlang
    hyprwayland-scanner
    aquamarine
    # hyprgraphics
    # hyprland-qtutils

    rofi-wayland
    waybar
    wl-clipboard
    wlroots
    pipewire
    xwayland
    cliphist

    brave
    kodi

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  services.dbus.enable = true;

  # services.elogind.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

}
