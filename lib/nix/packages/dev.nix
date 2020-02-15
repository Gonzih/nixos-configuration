pkgs: with pkgs; [
    # basics
    ansible
    python
    # autofs5
    pprof
    graphviz
    shellcheck
    cmake

    # programming
    doge
    emacs
    neovim
    gcc
    go_1_13
    fzf
    entr
    rustup
    # Disable rust racer for now (failing for some reason)
    # might be good idea to install it via rustup
    # rustracer
    clojure
    leiningen
    boot
    jdk11
    protobuf
    jq

    # build
    pkg-config

    # nix tools
    nix-review

    # postgres tools
    postgresql_11

    # docker
    docker-compose

    # cloud crap
    minikube
    #docker-machine-kvm2
    google-cloud-sdk
    kubernetes-helm
    kustomize

    k9s

    # networking
    nmap
    apacheHttpd

    # ocaml
    ocaml
    opam

    # build utils
    binutils-unwrapped
    gnum4

    # aws
    s3cmd
    aws

    redis

    # keyboard
    # qmk_firmware

    bat
    hexyl

    sysbench

    # vulkan tools
    vulkan-tools
    vulkan-headers
    vulkan-loader

    # x11 stuff
    xorg.libX11

    # alsa
    alsaLib

    ctags

    wasm-pack
    cargo-generate
    cargo-watch
    binaryen

    arduino
    arduino-mk
    avrdude
    python27Packages.pyserial

    # ew
    nodejs

    cura
    # cura octoprint dep
    python37Packages.netifaces
    blender
    slic3r
    openscad


    bear
    wireguard
    qrencode
    tcpdump

    hugo
    zola
]
