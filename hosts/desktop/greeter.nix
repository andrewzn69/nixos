{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland --theme 'border=green;title=green;greet=black;text=white;prompt=blue;input=white;action=green;button=blue'";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  console.colors = [
    "171A1C"
    "CC241D"
    "98971A"
    "D79921"
    "458588"
    "B16286"
    "689D6A"
    "EBDBB2"
    "4B4B4B"
    "CC241D"
    "98971A"
    "D79921"
    "458588"
    "B16286"
    "689D6A"
    "A89984"
  ];
}
