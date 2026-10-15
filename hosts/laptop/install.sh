#!/usr/bin/env bash
# installs a host from the nixos apple silicon installer
# the nixos partition is made by hand beforehand so nothing automated writes the gpt shared with macos
set -euo pipefail

flake="${1:-github:andrewzn69/nixos#laptop}"
repo="${flake%%#*}"
host="${flake##*#}"
nix=(nix --extra-experimental-features "nix-command flakes")

if [[ $EUID -ne 0 ]]; then
  echo "run as root" >&2
  exit 1
fi

read -ra disks <<< "$("${nix[@]}" eval --raw "$repo#nixosConfigurations.$host.config.disko.devices.disk" \
  --apply 'd: builtins.concatStringsSep " " (map (x: x.device) (builtins.attrValues d))')"
for disk in "${disks[@]}"; do
  if [[ ! -e "$disk" ]]; then
    echo "$disk not found, create the partition with sgdisk first" >&2
    exit 1
  fi
done

esp=$("${nix[@]}" eval --raw "$repo#nixosConfigurations.$host.config.fileSystems.\"/boot\".device")
# the asahi installer records the esp it made for this os in the device tree
esp_machine="/dev/disk/by-partuuid/$(tr -d '\0' < /proc/device-tree/chosen/asahi,efi-system-partition)"
if [[ "$esp" != "$esp_machine" ]]; then
  echo "esp in config $esp does not match this machine $esp_machine" >&2
  exit 1
fi

"${nix[@]}" run --inputs-from "$repo" disko -- --mode format,mount --flake "$flake"

mkdir -p /mnt/boot
mountpoint -q /mnt/boot || mount "$esp" /mnt/boot

nix-store --add-fixed sha256 /mnt/boot/vendorfw/firmware.cpio

nixos-install --flake "$flake"

read -ra users <<< "$("${nix[@]}" eval --raw "$repo#nixosConfigurations.$host.config.users.users" \
  --apply 'u: builtins.concatStringsSep " " (builtins.filter (n: u.${n}.isNormalUser) (builtins.attrNames u))')"
for user in "${users[@]}"; do
  echo "password for $user"
  nixos-enter --root /mnt -c "passwd $user"
done

echo "install finished, reboot to start nixos"
