{
  description = "NixOS and nix-darwin configs for my machines";
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Global catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    # NixOS Spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add nix-homebrew input
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    catppuccin,
    darwin,
    home-manager,
    nixpkgs,
    nix-homebrew,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Define user configurations
    users = {
      reuben = {
        avatar = ./files/avatar/face.jpg;
        email = "reuben@talbott.ws";
        fullName = "Reuben Talbott";
        #gitKey = "";
        name = "reuben";
      };
    };

    # Function for NixOS system configuration
    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
          nixosModules = "${self}/modules/nixos";
        };
        modules = [./hosts/${hostname}];
      };

    # Function for nix-darwin system configuration
    mkDarwinConfiguration = hostname: username:
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
          homebrewModules = "${self}/modules/homebrew";
        };
        modules = [
          ./hosts/${hostname}
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };

    # Function for Home Manager configuration
    mkHomeConfiguration = system: username: hostname:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
          nhModules = "${self}/modules/home-manager";
        };
        modules = [
          ./home/${username}/${hostname}
          catppuccin.homeManagerModules.catppuccin
        ];
      };
  in {
    nixosConfigurations = {
      energy = mkNixosConfiguration "energy" "nabokikh";
      nabokikh-z13 = mkNixosConfiguration "nabokikh-z13" "nabokikh";
    };

    darwinConfigurations = {
      "JenzabarPro" = mkDarwinConfiguration "JenzabarPro" "reuben";
    };

    homeConfigurations = {
      "nabokikh@energy" = mkHomeConfiguration "x86_64-linux" "nabokikh" "energy";
      "reuben@JenzabarPro" = mkHomeConfiguration "aarch64-darwin" "reuben" "JenzabarPro";
      "nabokikh@nabokikh-z13" = mkHomeConfiguration "x86_64-linux" "nabokikh" "nabokikh-z13";
    };

    overlays = import ./overlays {inherit inputs;};
  };
}
