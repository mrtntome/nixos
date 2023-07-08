{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    neovim
    tmux
    curl
    git
    sway
    foot
    qutebrowser
  ];
}
