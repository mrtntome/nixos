{ config, nixpkgs, lib, ... }:

{
  imports = [ ];

  pkgs = import nixpkgs {
    system = "aarch64-linux";
    config.allowUnfree = true;
  };

  users.users.pod-runner = {
    isNormalUser = true;
    description = "martin";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    tmux
    curl
    git
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  networking.hostName = "rpi4-server";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_AR.UTF-8";
      LC_IDENTIFICATION = "es_AR.UTF-8";
      LC_MEASUREMENT = "es_AR.UTF-8";
      LC_MONETARY = "es_AR.UTF-8";
      LC_NAME = "es_AR.UTF-8";
      LC_NUMERIC = "es_AR.UTF-8";
      LC_PAPER = "es_AR.UTF-8";
      LC_TELEPHONE = "es_AR.UTF-8";
      LC_TIME = "es_AR.UTF-8";
    };
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos-root";
      fsType = "ext4";
    };

  swapDevices = [ ];

  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "usb_storage"
      "usbhid"
      "uas"
      "vc4"
      "pcie_brcmstb"      # required for the pcie bus to work
      "reset-raspberrypi" # required for vl805 firmware to load
    ];
  };

  hardware.deviceTree.filter = lib.mkDefault "bcm2711-rpi-*.dtb";

  assertions = [
    {
      assertion = (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.1");
      message = "This version of raspberry pi 4 dts overlays requires a newer kernel version (>=6.1). Please upgrade nixpkgs for this system.";
    }
  ];

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  system.stateVersion = "23.05";

}
