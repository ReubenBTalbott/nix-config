{...}: {
  programs.fish = {
    enable = true;
    
    interactiveShellInit = ''
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