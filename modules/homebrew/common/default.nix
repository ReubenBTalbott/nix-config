{
  pkgs,
  outputs,
  userConfig,
  ...
}:
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
      "ripgrep"          # Fast search tool
      "fd"              # User-friendly find alternative
      "jq"              # JSON processor
      "tree"            # Directory listing
      "htop"            # Process viewer
      "coreutils"       # GNU core utilities
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
      "roots/tap"
    ];

    # Mac App Store apps
    masApps = {
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
    };
  };
}