{
  InstallAddonPermission = {
    Default = false;
  };

  ExtensionRecommendations = false;

  # privacy and telemetry
  DisableTelemetry = true;
  DisableFirefoxStudies = true;
  DisablePocket = true;
  DisableFirefoxAccounts = true;
  DisableFeedbackCommands = true;

  # updates
  DisableAppUpdate = true;

  # other privacy settings
  DontCheckDefaultBrowser = true;
  OverrideFirstRunPage = "";
  OverridePostUpdatePage = "";

  # tracking protection
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
  };
}
