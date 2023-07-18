{
  description = "System Config";

  inputs = {
    nixpkgs.url = "github:/nixos/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, ... }: 
  {
    nixosConfigurations = {
      thinkpad-t440p = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./thinkpad-t440p
        ];
      };
      rpi4-server = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./rpi4-server
        ];
      };
    };
  };
}
