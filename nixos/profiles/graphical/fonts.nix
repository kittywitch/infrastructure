{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      font-awesome
      twitter-color-emoji
      iosevka-bin
      monaspace
      corefonts
      vistafonts
      open-dyslexic
      chicago95
    ];
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      allowBitmaps = true;
      defaultFonts = {
        emoji = [
          "Twitter Color Emoji"
        ];
      };
    };
  };
}
