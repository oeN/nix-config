{my, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${my.vars.username}" = {
    home = "/Users/${my.vars.username}";
  };
}
