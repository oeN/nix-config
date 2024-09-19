# Host-specific secrets
let
  keys = import ../../../../keys;

  all = [keys.hosts.scyther] ++ (builtins.attrValues keys.users);
in {
  "scaleway-credentials.age".publicKeys = all;
  "backup/password.age".publicKeys = all;
  "route53/credentials.age".publicKeys = all;
  "wireguard/private-key.age".publicKeys = all;
  "nginx/sso/auth-key.age".publicKeys = all;
  "nginx/sso/users/diomedet/password-hash.age".publicKeys = all;
  "monitoring/secret-key.age" = {
    publicKeys = all;
    owner = "grafana";
  };
  "monitoring/password.age" = {
    owner = "grafana";
    publicKeys = all;
  };
}
