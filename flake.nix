{
  description = "Andrew's home manager config'";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
        # be sure to change if necessary
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };

      devShells."${system}".default = pkgs.mkShell {
        packages = with pkgs; [
            nixd
        ];
        shellHook = ''
            echo `${pkgs.nixd}/bin/hello --version`
        '';
      };
    };
}
