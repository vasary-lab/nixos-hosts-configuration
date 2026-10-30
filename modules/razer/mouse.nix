{ lib, userName, ... }:

{
  hardware.openrazer = {
    enable = true;
    users = [ userName ];
  };

  # Diagnostic experiment: keep OpenRazer available, but let this mouse stay on
  # hid-generic instead of binding to the OpenRazer mouse kernel driver.
  boot.kernelModules = lib.mkForce [
    "atkbd"
    "ctr"
    "kvm-amd"
    "loop"
    "razeraccessory"
    "razerkbd"
    "razerkraken"
    "uvcvideo"
  ];
  boot.blacklistedKernelModules = [ "razermouse" ];
}
