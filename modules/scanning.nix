{ pkgs, ... }:

{
  hardware.sane = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    naps2
    sane-backends
    simple-scan
  ];
}
