_: {
  services.nginx = {
    virtualHosts = {
      "public.gensokyo.zone" = {
        extraConfig = ''
          allow 103.21.244.0/22;
          allow 103.22.200.0/22;
          allow 103.31.4.0/22;
          allow 104.16.0.0/12;
          allow 108.162.192.0/18;
          allow 131.0.72.0/22;
          allow 141.101.64.0/18;
          allow 162.158.0.0/15;
          allow 172.64.0.0/13;
          allow 173.245.48.0/20;
          allow 188.114.96.0/20;
          allow 190.93.240.0/20;
          allow 197.234.240.0/22;
          allow 198.41.128.0/17;

          # IPv6
          allow 2400:cb00::/32;
          allow 2405:b500::/32;
          allow 2606:4700::/32;
          allow 2803:f800::/32;
          allow 2c0f:f248::/32;
          allow 2a06:98c0::/29;

          deny all;
        '';
        locations."/kat-is-a-cute-girl/" = {
          alias = "/var/www/public/";
          extraConfig = ''
            autoindex on;
          '';
        };
      };
    };
  };
}
