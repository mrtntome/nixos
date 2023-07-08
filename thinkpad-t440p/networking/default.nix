{ config, pkgs, ... }:

{
  networking.hostName = "t440p";
  networking.networkmanager.enable = true;
}
