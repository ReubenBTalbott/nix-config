{
  pkgs,
  outputs,
  userConfig,
  homebrewModules,
  ...
}:

{
  imports = [
   ../${hostname}
  ];
}

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Removes all unmanaged formulae
      upgrade = true;
    };

    # Set the user who manages Homebrew
    user = "${userConfig.name}";

    # Homebrew formulae (packages)
    brews = [
      "mas"              # Mac App Store CLI
      "wget"             # File downloader
      "htop"            # Process viewer
    ];

    # Homebrew casks (applications)
    casks = [
      "1password-cli"
      "daisydisk"
      "logitech-g-hub"
      "sequel-ace"
      "vagrant"
      "appcleaner"
      "displaylink"
      "parallels"
      "spotify"
      "visual-studio-code"
      "bartender"
      "ghostty"
      "rocket"
      "stats"
      "betterdisplay"
      "google-chrome"
      "royal-tsx"
      "transmit"
      "bing-wallpaper"
      "keka"
      "scroll-reverser"
      "utm"
    ];

    # Homebrew taps (repositories)
    taps = [
      "homebrew/core"
      "homebrew/cask"
      "homebrew/bundle"
    ];

    # Mac App Store apps
    masApps = {
      "Refined GitHub" = 1519867270;
      "bonjourrStartpage" = 1615431236;
      "Microsoft To Do" = 1274495053;
    };
  };
}