{ user-agents }:

let
  userAgents = builtins.fromJSON (builtins.readFile "${user-agents}/user-agents.json");
  edge = builtins.filter (ua: builtins.match ".*Edg/.*" ua != null) userAgents;
  userAgent = builtins.elemAt edge (builtins.length edge - 1);
in
{
  "browser.tabs.warnOnClose" = false;
  "browser.tabs.closeWindowWithLastTab" = false;
  "browser.startup.couldRestoreSession.count" = -1;

  # allow extensions to be enabled automatically
  "extensions.autoDisableScopes" = 0;
  "extensions.update.autoUpdateDefault" = false;
  "extensions.update.enabled" = false;

  # disable onboarding
  "browser.aboutwelcome.enabled" = false;
  "trailhead.firstrun.didSeeAboutWelcome" = true;
  "browser.startup.homepage_override.mstone" = "ignore";
  "startup.homepage_welcome_url" = "";
  "startup.homepage_override_url" = "";
  "browser.messaging-system.whatsNewPanel.enabled" = false;
  "browser.startup.firstrunSkipsHomepage" = true;

  "browser.aboutConfig.showWarning" = false;
  "signon.rememberSignons" = false;

  "findbar.highlightAll" = true;

  "privacy.resistFingerprinting" = false;
  "privacy.fingerprintingProtection" = true;
  "privacy.fingerprintingProtection.overrides" = "-AllTargets,+CanvasRandomization,+JSDateTimeUTC,+WebGLRenderInfo,+NavigatorHWConcurrency,+AudioContext";

  "general.useragent.override" = userAgent;
  "general.platform.override" = "Win32";
  "general.oscpu.override" = "Windows NT 10.0; Win64; x64";
  "general.appversion.override" = "5.0 (Windows)";
}
