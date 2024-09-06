# Common secrets
let
  keys = import ../../../keys;

  inherit (keys) all;
in {
  "users/diomedet/hashed-password.age".publicKeys = all;
  "users/root/hashed-password.age".publicKeys = all;
}
