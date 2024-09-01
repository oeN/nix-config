{ ... }: {
  nix.settings.builders-use-substitutes = true;

  nix.buildMachines = [{
    system = "x86_64-linux";
    sshUser = "root";
    sshKey = "/Users/diomedet/.ssh/id_ed25519";
    hostName = "scyther";
  }];
  nix.distributedBuilds = true;
}
