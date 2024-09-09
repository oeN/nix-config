{config, ...}: let
  my-user = config.my.user;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${my-user.name}" = {
    home = "/Users/${my-user.name}";
  };
}
