{ pkgs }:

pkgs.writeShellScript "rofi-powermenu" ''
  dir="''$HOME/.config/rofi"
  theme='powermenu'

  uptime_sec=''$(awk '{print int(''$1)}' /proc/uptime)
  days=''$((uptime_sec / 86400))
  hours=''$((uptime_sec % 86400 / 3600))
  mins=''$((uptime_sec % 3600 / 60))
  [ ''$days -eq 1 ] && d='day' || d='days'
  [ ''$hours -eq 1 ] && h='hour' || h='hours'
  [ ''$mins -eq 1 ] && m='minute' || m='minutes'
	uptime="''$days ''$d ''$hours ''$h ''$mins ''$m"

  hibernate='󰽥'
  shutdown=''
  reboot=''
  lock=''
  suspend='󰒲'
  logout='󰍃'

  rofi_cmd() {
  	rofi -dmenu \
  		-mesg "Uptime: ''$uptime" \
  		-theme "''${dir}/''${theme}".rasi
  }

  run_rofi() {
  	echo -e "''$suspend\n''$reboot\n''$shutdown\n''$lock\n''$logout\n''$hibernate" | rofi_cmd
  }

    chosen="$(run_rofi)"
    case ''${chosen} in
      "''$shutdown")
        systemctl poweroff
        ;;
      "''$reboot")
        systemctl reboot
        ;;
      "''$hibernate")
        systemctl hibernate
        ;;
      "''$lock")
        swaylock -c 000000
        ;;
      "''$suspend")
        systemctl suspend
        ;;
      "''$logout")
        hyprctl dispatch exit
        ;;
    esac
''
