{ pkgs, ... }:

let
  python = pkgs.python3.withPackages (pythonPackages: [
    pythonPackages.pip
    pythonPackages.virtualenv
  ]);
in
{
  home.packages = [
    python
  ];
}
