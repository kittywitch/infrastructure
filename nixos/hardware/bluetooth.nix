{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ bluez5-experimental ];

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services = {
    blueman.enable = true;
  };

  home-manager.sharedModules = [
    {
      xsession.preferStatusNotifierItems = true;
      services.blueman-applet.enable = true;
    }
  ];
}
