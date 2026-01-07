{ pkgs }:

pkgs.writeShellScript "rofi-powermenu" ''
  dir="$HOME/.config/rofi"
  theme='powermenu'

  uptime="$(uptime -p | sed -e 's/up //g')"

  hibernate='󰽥'
  shutdown=''
  reboot=''
  lock=''
  suspend='󰒲'
  logout='󰍃'

  rofi_cmd() {
  	rofi -dmenu \
  		-mesg "Uptime: $uptime" \
  		-theme "''${dir}/''${theme}".rasi
  }

  run_rofi() {
  	echo -e "$suspend\n$reboot\n$shutdown\n$lock\n$logout\n$hibernate" | rofi_cmd
  }

    chosen="$(run_rofi)"
    case ''${chosen} in
      "$shutdown")
        systemctl poweroff
        ;;
      "$reboot")
        systemctl reboot
        ;;
      "$hibernate")
        systemctl hibernate
        ;;
      "$lock")
        swaylock -c 000000
        ;;
      "$suspend")
        systemctl suspend
        ;;
      "$logout")
        hyprctl dispatch exit
        ;;
    esac
''
