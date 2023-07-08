{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cage
    greetd.greetd
    greetd.regreet
    source-code-pro
    catppuccin-gtk
    catppuccin-cursors.frappeDark
    gnome.adwaita-icon-theme
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- regreet";
	user = "greeter";
      };
    };
  };

  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
	font_name = "source-code-pro 16";
	cursor_theme_name = "Catppuccin-Frappe-Dark";
	icon_theme_name = "Adwaita";
        theme_name = "Catppuccin-Frappe-Standard-Blue-Dark";
      };
    };
  };
}
