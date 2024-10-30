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
        # symlink the appropriate file to config.nix
        userConfig = import ./config.nix;

        system = userConfig.system;

        pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix ];

        extraSpecialArgs = {
            inherit userConfig;
        };
      };

      # i now have nixd installed globally via home manager, so this devshell is no longer needed

      # devShells."${system}".default = pkgs.mkShell {
      #   packages = with pkgs; [
      #       nixd
      #   ];
      #   shellHook = ''
      #       echo `${pkgs.nixd}/bin/nixd --version`
      #   '';
      # };
    };
}
