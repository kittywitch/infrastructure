{
  config,
  pkgs,
  inputs,
  ...
}: {
  systemd.user.services.konawall-py-gnome = {
    Unit = {
      Description = "konawall-py";
      X-Restart-Triggers = [(toString config.xdg.configFile."konawall/config.toml".source)];
      After = ["gnome-session.target" "network-online.target"];
      Environment = [
        "PYSTRAY_BACKEND=gtk"
      ];
    };
    Service = {
      ExecStart = "${inputs.konawall-py.packages.${pkgs.system}.konawall-py}/bin/konawall";
      Restart = "on-failure";
      RestartSec = "1s";
    };
    Install = {WantedBy = ["gnome-session.target"];};
  };
}
