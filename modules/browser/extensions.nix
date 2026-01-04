{
  ublock-origin = {
    id = "uBlock0@raymondhill.net";
    privateAllowed = true;
    settings = {
      selectedFilterLists = [
        "user-filters"
        "ublock-filters"
        "ublock-badware"
        "ublock-privacy"
        "ublock-unbreak"
        "ublock-quick-fixes"
        "easylist"
        "easyprivacy"
        "urlhaus-1"
        "plowe-0"
      ];
    };
    permissions = [
      "alarms"
      "dns"
      "menus"
      "privacy"
      "storage"
      "tabs"
      "unlimitedStorage"
      "webNavigation"
      "webRequest"
      "webRequestBlocking"
      "<all_urls>"
      "http://*/*"
      "https://*/*"
      "file://*/*"
      "https://easylist.to/*"
      "https://*.fanboy.co.nz/*"
      "https://filterlists.com/*"
      "https://forums.lanik.us/*"
      "https://github.com/*"
      "https://*.github.io/*"
      "https://github.com/uBlockOrigin/*"
      "https://ublockorigin.github.io/*"
      "https://*.reddit.com/r/uBlockOrigin/*"
    ];
  };
  sponsorblock = {
    id = "sponsorBlocker@ajay.app";
    settings = {
      alreadyInstalled = true;
    };
    permissions = [
      "storage"
      "scripting"
      "https://sponsor.ajay.app/*"
      "https://*.youtube.com/*"
      "https://www.youtube-nocookie.com/embed/*"
    ];
  };
  dearrow = {
    id = "deArrow@ajay.app";
  };
}
