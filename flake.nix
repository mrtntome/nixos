{
  description = "System Config";

  inputs = {
    nixpkgs.url = "github:/nixos/nixpkgs/nixos-23.05";
    hardware.url = "github:NixOS/nixos-hardware/429f232fe1dc398c5afea19a51aad6931ee0fb89";
  };

  outputs = { self, nixpkgs, home-manager , ... }: 
  {
    nixosConfigurations = {
      thinkpad-t440p = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        system = "x86_64-linux";
        modules = [
          ./thinkpad-t440p
        ];
      };
      rpi4-server = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
        system = "aarch64-linux";
        modules = [
          ./rpi4-server
        ];
      };
    };
  };
}
