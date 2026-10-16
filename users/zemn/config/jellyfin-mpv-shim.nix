{ ... }:

{
  services.jellyfin-mpv-shim = {
    enable = true;

    settings = {
      language_preference = "custom";
      language_config = [
        {
          alang = "eng";
          slang = "eng";
        }
        { alang = "eng"; }
        { slang = "eng"; }
      ];

      allow_background = true;
      start_minimized = true;
    };
  };
}
