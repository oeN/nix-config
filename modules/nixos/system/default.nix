# System-related modules
{lib, ...}: {
  imports = lib.attrValues (lib.my.mapModules ./. (file: file));
}
