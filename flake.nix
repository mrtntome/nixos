{
  description = "System Config";

  inputs = {
    nixpkgs.url = "github:/nixos/nixpkgs/nixos-23.05";
    hardware.url = "github:NixOS/nixos-hardware/429f232fe1dc398c5afea19a51aad6931ee0fb89";
  };

  outputs = { self, nixpkgs, home-manager , ... }: 
  {
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    nixosConfigurations = {
      thinkpad-t440p = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./thinkpad-t440p
        ];
      };
    };
  };
}
