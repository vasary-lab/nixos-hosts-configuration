{ config, pkgs, ... }:

let
  wireguardPeerEnv = config.sops.templates."networkmanager-wireguard.env".path;
in

{
  environment.systemPackages = [
    pkgs.wireguard-tools
  ];

  sops.templates."networkmanager-wireguard.env".content = ''
    WG_PRIVATE_KEY=${config.sops.placeholder."wireguard/private_key"}
    WG_PEER_PUBLIC_KEY=${config.sops.placeholder."wireguard/peer_public_key"}
  '';

  networking = {
    enableIPv6 = false;
    firewall.checkReversePath = "loose";

    networkmanager.ensureProfiles = {
      environmentFiles = [
        wireguardPeerEnv
      ];

      profiles.wg0 = {
        connection = {
          id = "WireGuard";
          type = "wireguard";
          uuid = "7e80277c-6db9-4f1b-8d39-9ddbbcf0fd0a";
          interface-name = "wg0";
          autoconnect = false;
        };

        wireguard = {
          private-key = "$WG_PRIVATE_KEY";
          private-key-flags = 0;
          peer-routes = true;
        };

        "wireguard-peer.$WG_PEER_PUBLIC_KEY" = {
          endpoint = "212.7.207.248:52999";
          allowed-ips = "0.0.0.0/0";
        };

        ipv4 = {
          method = "manual";
          address1 = "10.0.182.1/24";
          dns = "8.8.8.8;8.8.4.4;";
          dns-priority = -50;
          never-default = false;
        };

        ipv6.method = "disabled";
      };
    };
  };
}
