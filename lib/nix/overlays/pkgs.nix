self: super:
{
  minecraft-server-latest = super.callPackage ./pkgs/minecraft-server-latest { };
  odroid-status-screen-go = super.callPackage ./pkgs/odroid-status-screen-go { };
  feeds2imap = super.callPackage ./pkgs/feeds2imap { };
  apod-nasa-scraper-rs = super.callPackage ./pkgs/apod-nasa-scraper-rs { };
  sipeed-longan-toolchain-gd32v = super.callPackage ./pkgs/sipeed-longan-toolchain-gd32v { };
  sipeed-longan-flashtool-gd32v = super.callPackage ./pkgs/sipeed-longan-flashtool-gd32v { };

  cereal = super.callPackage ./pkgs/cereal { };
}
