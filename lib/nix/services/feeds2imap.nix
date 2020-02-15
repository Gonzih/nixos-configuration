{ config, pkgs, ... }:

let
  secrets = import ./../../secrets.nix;

  # configData {{{
  configData = ''
paths:
  db: /var/lib/feeds2imap/feeds.db

daemon:
  enabled: true
  delay: 5

imap:
  enabled: yes
  host: ${secrets.feeds2imap.host}
  port: ${secrets.feeds2imap.port}
  username: ${secrets.feeds2imap.imap.username}
  password: ${secrets.feeds2imap.imap.password}
  folder:
    prefix: RSS
    capitalize: true
  to:
    name: ${secrets.feeds2imap.to.name}
    email: ${secrets.feeds2imap.to.email}
  from:
    name: ${secrets.feeds2imap.from.name}
    email: ${secrets.feeds2imap.from.email}

debug: true

urls:
  nature:
  - https://primitivetechnology.wordpress.com/feed/
  rust:
  - https://blog.rust-lang.org/feed.xml
  - https://osblog.stephenmarz.com/feed.rss
  - https://readrust.net/all/feed.rss
  hacking:
  - https://hackaday.com/feed/
  - https://strangeparts.com/feed/
  nim:
  - https://nim-lang.org/news.xml
  fun:
  - http://this-plt-life.tumblr.com/rss
  - https://xkcd.com/atom.xml
  - http://classicprogrammerpaintings.com/rss
  embed:
  - https://blog.fsck.com/atom.xml
  - http://feeds.feedburner.com/cnx-software/blog
  funprog:
  - http://functionaltalks.org/feed.xml
  clojure:
  - https://feeds.feedburner.com/stevelosh?format=xml
  - https://feeds.feedburner.com/Clojure/coreBlog
  - https://swannodette.github.com/atom.xml
  - https://feeds.feedburner.com/cognicast
  - https://blog.cognitect.com/blog?format=rss
  - http://blog.fikesfarm.com/feed.xml
  - https://reborg.tumblr.com/rss
  - https://feeds.soundcloud.com/users/soundcloud:users:220484243/sounds.rss
  elixir:
  - https://feeds.feedburner.com/ElixirLang
  hardware:
  - https://feeds.feedburner.com/Liliputing
  - https://www.ifixit.com/Guide/rss/teardowns
  - https://smallformfactor.net/category/reviews/feed
  lisp:
  - https://blog.racket-lang.org/feeds/all.rss.xml
  - https://planet.lisp.org/rss20.xml
  linux:
  - https://www.archlinux.org/feeds/news/
  - https://nixos.org/news-rss.xml
  haskell:
  - https://www.haskellcast.com/feed.xml
  - https://www.yesodweb.com/feed
  - http://keera.co.uk/blog/feed/
  go:
  - https://blog.golang.org/feed.atom
  - https://dave.cheney.net/category/golang/feed
  - https://spf13.com/topics/golang/index.xml
  literature:
  - http://www.marclaidlaw.com/feed/
  openai:
  - https://blog.openai.com/rss/
  Ml:
  - https://medium.com/feed/@ageitgey
  security:
  - https://krebsonsecurity.com/feed/
  Paper:
  - https://unsharpen.com/feed/
  ocaml:
  - https://ocaml.org/feed.xml
  ''; # }}}

  config = pkgs.writeText "config.yaml" configData;
in

{
  systemd.services.feeds2imap = {
    description = "Feeds2IMAP";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/feeds2imap-go --config ${config}";
      Restart = "always";
      RestartSec = 15;
    };
    path = [
    ];
    wantedBy = [ "default.target" ];
  };

  systemd.services.feeds2imap.enable = true;

  system.activationScripts = {
    feeds2imap = {
      text = ''
        mkdir -p /var/lib/feeds2imap
      '';
      deps = [];
    };
  };
}
