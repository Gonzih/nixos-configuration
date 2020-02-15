# What is this?

This repo contains all my nix machines configuration.
Repo includes Makefile for local and remote configuration application.

## Notes for myself

Set dpi:

```nix
# Resolution
services.xserver.dpi = 130;
fonts.fontconfig.dpi = 130;

# Screen size
services.xserver.monitorSection = ''
  DisplaySize 310 174   # In millimeters
'';
```

Disable cpu throttling:

```nix
services.throttled.enable = lib.mkDefault true;
```

Lenovo thinkpad battery magic:

```nix
services.tlp = {
  enable = true;
  extraConfig = ''
    START_CHARGE_THRESH_BAT0=90
    STOP_CHARGE_THRESH_BAT0=95
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    ENERGY_PERF_POLICY_ON_BAT=powersave
    CPU_SCALING_GOVERNOR_ON_AC=balance-performance
    ENERGY_PERF_POLICY_ON_AC=balance-performance
  '';
};
```
