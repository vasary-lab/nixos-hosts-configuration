{ pkgs, ... }:

let
  waitForSettledBoot = pkgs.writeShellScript "nix-gc-wait-for-settled-boot" ''
    set -eu

    min_uptime=600
    uptime_seconds="$(${pkgs.coreutils}/bin/cut -d. -f1 /proc/uptime)"

    if [ "$uptime_seconds" -lt "$min_uptime" ]; then
      ${pkgs.coreutils}/bin/sleep "$((min_uptime - uptime_seconds))"
    fi
  '';
in
{
  nix = {
    gc = {
      automatic = true;
      dates = "Sun 11:00";
      options = "--delete-older-than 3d";
      persistent = true;
      randomizedDelaySec = "0";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  systemd.services.nix-gc.serviceConfig = {
    CPUWeight = 10;
    ExecStartPre = waitForSettledBoot;
    IOSchedulingClass = "idle";
    IOWeight = 10;
    Nice = 19;
  };

}
