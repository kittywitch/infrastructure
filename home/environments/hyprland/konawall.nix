{
  inputs,
  pkgs,
  config,
  ...
}: let
  konawallConfig = {
    interval = 60 * 5;
    rotate = true;
    source = "konachan";
    tags = [
      "rating:s"
      "touhou"
      "score:>=50"
      "width:>=1500"
    ];
    logging = {
      file = "INFO";
      console = "DEBUG";
    };
  };
in {
  systemd.user.services.konawall-py-hyprland = {
    Unit = {
      Description = "konawall-py";
      X-Restart-Triggers = [(toString config.xdg.configFile."konawall/config.toml".source)];
      After = ["hyprland-session.target" "network-online.target"];
    };
    Service = {
      ExecStart = "${inputs.konawall-py.packages.${pkgs.system}.konawall-py}/bin/konawall";
      Restart = "on-failure";
      RestartSec = "1s";
    };
    Install = {WantedBy = ["hyprland-session.target"];};
  };
  xdg.configFile = {
    "konawall/config.toml".source = (pkgs.formats.toml {}).generate "konawall-config" konawallConfig;
  };
}
