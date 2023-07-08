{
  home.stateVersion = "23.05";
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host scyther
        HostName 10.10.5.109
    '';
  };
}
