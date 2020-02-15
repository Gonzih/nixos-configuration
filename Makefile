SSH := ssh -t

.PHONY: install
install: lib/secrets.nix
	sudo rsync -arxv --delete lib /etc/nixos/

.PHONY: channel-update
channel-update:
	@echo -n "Are you sure you want to fuck everything up? [y/N] " && read ans && [ $${ans:-N} = y ]
	sudo nix-channel --list
	sudo nix-channel --update

.PHONY: switch
switch: install
	sudo nixos-rebuild switch
	make gc

.PHONY: gc
gc: clean
	sudo nix-collect-garbage --delete-older-than 30d

.PHONY: optimise
optimise:
	sudo nix-store --optimise

.PHONY: pull
pull:
	git pull

.PHONY: checkout
checkout:
	git checkout

.PHONY: crypt-unlock
crypt-unlock:
	git-crypt unlock

.PHONY: setup-unstable-channels
setup-unstable-channels:
	 sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

STABLE_VERSION=19.09
.PHONY: setup-stable-channels
setup-stable-channels:
	 sudo nix-channel --add https://nixos.org/channels/nixos-$(STABLE_VERSION) nixos

lib/secrets.nix.asc:
	gpg --encrypt --sign --armor -r gonzih@gmail.com lib/secrets.nix

lib/secrets.nix:
	gpg --decrypt lib/secrets.nix.asc > lib/secrets.nix

.PHONY: clean
clean:
	sudo rm -f /etc/nixos/lib/secrets.nix

TARGET_CONF_DIR=/home/gnzh/configuration.nix

.PHONY: remote-channel-update
remote-channel-update:
	$(SSH) $(TARGET) "cd $(TARGET_CONF_DIR) && make pull channel-update"

.PHONY: remote-switch
remote-switch: lib/secrets.nix
	$(SSH) $(TARGET) "cd $(TARGET_CONF_DIR) && make checkout pull"
	scp lib/secrets.nix $(TARGET):$(TARGET_CONF_DIR)/lib/secrets.nix
	$(SSH) $(TARGET) "cd $(TARGET_CONF_DIR) && make switch"
