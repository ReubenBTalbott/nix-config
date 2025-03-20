{
  outputs,
  userConfig,
  pkgs,
  ...
}: {
  imports = [
    ../${hostname}
    ../misc/qt
    ../programs/bat
    ../programs/btop
    ../programs/fastfetch
    ../programs/git
    ../programs/tmux
    ../scripts
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${userConfig.name}"
      else "/home/${userConfig.name}";
  };

  # Ensure common packages are installed
  home.packages = with pkgs;
    [
      mysql-client
    ]
    ++ lib.optionals stdenv.isDarwin [
      colima
      docker
    ]
    ++ lib.optionals (!stdenv.isDarwin) [
    ];

  # Catpuccin flavor and accent
  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
  };
}
