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
  DisableAccounts = true;
  DisableFeedbackCommands = true;
  DisableSystemAddonUpdate = true;
  DisableProfileUpdate = true;
  DisableDeveloperTools = false;
  DisableFirefoxScreenshots = true;

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
