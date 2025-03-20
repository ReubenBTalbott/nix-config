{...}: {
  programs.fish = {
    enable = true;
    
    interactiveShellInit = ''
      # Set environment variables
      set -gx EDITOR nvim
      set -gx VISUAL $EDITOR
      
      # Remove greeting
      set -g fish_greeting
    '';
    
    shellAliases = {
      # Add your aliases here
      ".." = "cd ..";
      "..." = "cd ../..";
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -la";
    };
    
    plugins = [
      # Add fish plugins if needed
      # Example:
      # {
      #   name = "z";
      #   src = pkgs.fishPlugins.z.src;
      # }
    ];
  };
}