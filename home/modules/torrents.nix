{ ... }:

let
  torrentClients = [
    "aria2.desktop"
    "com.transmissionbt.Transmission.desktop"
    "deluge.desktop"
    "fragments.desktop"
    "org.deluge_torrent.deluge.desktop"
    "org.qbittorrent.qBittorrent.desktop"
    "org.transmissionbt.Transmission.desktop"
    "transmission-gtk.desktop"
    "transmission-qt.desktop"
    "webtorrent-desktop.desktop"
  ];
in
{
  xdg.configFile."mimeapps.list".force = true;

  xdg.mimeApps = {
    enable = true;
    associations.removed = {
      "application/x-bittorrent" = torrentClients;
      "x-scheme-handler/magnet" = torrentClients;
    };
    defaultApplications = {
      "application/x-bittorrent" = [ ];
      "x-scheme-handler/magnet" = [ ];
    };
  };
}
