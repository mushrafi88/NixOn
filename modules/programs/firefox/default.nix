{ config, pkgs, inputs, ... }:

{
 programs.firefox = {
    enable = true;
    #nativeMessagingHosts.packages =  [ pkgs.tridactyl-native ] ;
    #nativeMessagingHosts.tridactyl = true;
    #package = pkgs.firefox-devedition-unwrapped;
    profiles.venerable_asura = { 
      settings = {
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
        "browser.startup.homepage" = "file:///home/venerable_white/Browser-Homepage/homepage.html";
        "browser.bookmarks.addedImportButton" = "true";
        "browser.download.panel.shown" = "true";
        "pdfjs.enabledCache.state" = "true";
        "privacy.clearOnShutdown.history" = "false";
        "toolkit.telemetry.reportingpolicy.firstRun" = "false";
        "browser.policies.runOncePerModification.displayBookmarksToolbar" = "never";
        "browser.toolbars.bookmarks.showOtherBookmarks" = "false";
        "browser.toolbars.bookmarks.visibility" = "never";

        	/****************************************************************************
				 * Betterfox                                                                *
				 * "Ad meliora"                                                             *
				 * version: 115                                                             *
				 * url: https://github.com/yokoffing/Betterfox                              *
				****************************************************************************/

				/****************************************************************************
				 * SECTION: FASTFOX                                                         *
				****************************************************************************/

        
        "nglayout.initialpaint.delay" = 0;
				"nglayout.initialpaint.delay_in_oopif" = 0;
				"content.notify.interval" = 100000;
				"browser.startup.preXulSkeletonUI" = false;
        "layout.css.grid-template-masonry-value.enabled" = true;
				"dom.enable_web_task_scheduling" = true;

        /** GFX ***/
				"gfx.webrender.all" = true;
				"gfx.webrender.precache-shaders" = true;
				"gfx.webrender.compositor" = true;
				"layers.gpu-process.enabled" = true;
				"media.hardware-video-decoding.enabled" = true;
        /* "media.ffmpeg.vaapi.enabled" = true; */ 
				"gfx.canvas.accelerated" = true;
				"gfx.canvas.accelerated.cache-items" = 32768;
				"gfx.canvas.accelerated.cache-size" = 4096;
				"gfx.content.skia-font-cache-size" = 80;
				"image.cache.size" = 10485760;
				"image.mem.decode_bytes_at_a_time" = 131072;
				"image.mem.shared.unmap.min_expiration_ms" = 120000;
				"media.memory_cache_max_size" = 1048576;
				"media.memory_caches_combined_limit_kb" = 2560000;
				"media.cache_readahead_limit" = 9000;
				"media.cache_resume_threshold" = 6000;
				
				/** BROWSER CACHE ***/
				"browser.cache.memory.max_entry_size" = 153600;

        /** NETWORK ***/
				"network.buffer.cache.size" = 262144;
				"network.buffer.cache.count" = 128;
				"network.http.max-connections" = 1800;
				"network.http.max-persistent-connections-per-server" = 10;
				"network.ssl_tokens_cache_capacity" = 32768;

        	/** WEBRTC ***/
				"media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
				"media.peerconnection.ice.default_address_only" = true;

        /** MOZILLA ***/
				"accessibility.force_disabled" = 1;
				#"identity.fxaccounts.enabled" = false;
				"browser.tabs.firefox-view" = false;
				"permissions.default.desktop-notification" = 2;
				"permissions.default.geo" = 2;
				"geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
				"geo.provider.ms-windows-location" = false; # WINDOWS
				"geo.provider.use_corelocation" = false; # MAC
				"geo.provider.use_gpsd" = false; # LINUX
				"geo.provider.use_geoclue" = false; # LINUX
				"permissions.manager.defaultsUrl" = "";
				"webchannel.allowObject.urlWhitelist" = "";

        /** MOZILLA UI ***/
				"layout.css.prefers-color-scheme.content-override" = 0;
				"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
				"app.update.suppressPrompts" = true;
				"browser.compactmode.show" = true;
				"browser.privatebrowsing.vpnpromourl" = "";
				"extensions.getAddons.showPane" = false;
				"extensions.htmlaboutaddons.recommendations.enabled" = false;
				"browser.shell.checkDefaultBrowser" = false;
				"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
				"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
				"browser.preferences.moreFromMozilla" = false;
				"browser.tabs.tabmanager.enabled" = false;
				"browser.aboutwelcome.enabled" = false;
				"findbar.highlightAll" = true;
				"middlemouse.contentLoadURL" = false;
				"browser.privatebrowsing.enable-new-indicator" = false;

				/** FULLSCREEN ***/
				"full-screen-api.transition-duration.enter" = "0 0";
				"full-screen-api.transition-duration.leave" = "0 0";
				"full-screen-api.warning.delay" = -1;
				"full-screen-api.warning.timeout" = 0;

				/** URL BAR ***/
				"browser.urlbar.suggest.engines" = false;
				"browser.urlbar.suggest.topsites" = false;
				"browser.urlbar.suggest.calculator" = true;
				"browser.urlbar.unitConversion.enabled" = true;

        /** TELEMETRY ***/
				"toolkit.telemetry.unified" = false;
				"toolkit.telemetry.enabled" = false;
				"toolkit.telemetry.server" = "data:,";
				"toolkit.telemetry.archive.enabled" = false;
				"toolkit.telemetry.newProfilePing.enabled" = false;
				"toolkit.telemetry.shutdownPingSender.enabled" = false;
				"toolkit.telemetry.updatePing.enabled" = false;
				"toolkit.telemetry.bhrPing.enabled" = false;
				"toolkit.telemetry.firstShutdownPing.enabled" = false;
				"toolkit.telemetry.coverage.opt-out" = true;
				"toolkit.coverage.opt-out" = true;
				"datareporting.healthreport.uploadEnabled" = false;
				"datareporting.policy.dataSubmissionEnabled" = false;
				"app.shield.optoutstudies.enabled" = false;
				"browser.discovery.enabled" = false;
				"breakpad.reportURL" = "";
				"browser.tabs.crashReporting.sendReport" = false;
				"browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
				"captivedetect.canonicalURL" = "";
				"network.captive-portal-service.enabled" = false;
				"network.connectivity-service.enabled" = false;
				"default-browser-agent.enabled" = false;
				"app.normandy.enabled" = false;
				"app.normandy.api_url" = "";
				"browser.ping-centre.telemetry" = false;
				"browser.newtabpage.activity-stream.feeds.telemetry" = false;
				"browser.newtabpage.activity-stream.telemetry" = false;

        /*** POCKET ***/
				"extensions.pocket.enabled" = false;



      };
      userChrome = ''
          /* 
  This stylesheet is based on:
    - https://github.com/khuedoan/one-line-firefox
    - https://github.com/MrOtherGuy/firefox-csshacks
*/

/* Title bar */
.titlebar-buttonbox {
  display: none !important;
}

.titlebar-spacer {
  display: none !important;
}

/* Tab bar */
#navigator-toolbox {
  border: 0px !important;
  padding-bottom: 1px !important; /* symmetry */
}

#TabsToolbar {
  margin-left: 40vw !important; /* offset for url bar and icons */
}

#tabbrowser-tabs {
  --tab-min-height: 29px !important;
  border: none !important;
  box-shadow: none !important;
}

/* Nav bar */
#nav-bar {
  background: transparent !important;
  margin-top: -36px !important;
  margin-right: 60vw !important; /* offset for tab bar */
  padding-bottom: 1px !important; /* symmetry */
}

/* URL bar elements - uncomment selectors to _hide_ them */

/* #back-button {
  display: none !important;
} */

/* #forward-button {
  display: none !important;
} */

/* #tracking-protection-icon-container {
  display: none !important;
} */

#urlbar-container {
  min-width: 175px !important;
}

#urlbar-background {
  animation: none !important;
}

#urlbar {
  background: transparent !important;
  border: none !important;
  box-shadow: none !important;
}

#page-action-buttons {
  display: none !important;
}

#PanelUI-button {
  display: none !important;
}

/* properly display url bar pop up (history, search suggestions,...) */

:root{
  --toolbar-field-background-color: var(--toolbar-field-non-lwt-bgcolor);
  --toolbar-field-focus-background-color: var(--lwt-toolbar-field-focus,Field);
}
:root:-moz-lwtheme{
  --toolbar-field-background-color: var(--lwt-toolbar-field-background-color);
}

.urlbarView-row-inner{
   /* This sets how far the dropdown-items are from the window edge */
  padding-inline-start: 6px !important;
}

#urlbar-container,
#urlbar {
  position: static !important;
  display: -moz-box !important;
}

#urlbar {
  height: 24px !important;
  max-height: 24px !important;
  width: auto !important;
  box-shadow: inset 0 0 0 1px var(--toolbar-field-border-color, hsla(240,5%,5%,.25));
  background-color: var(--toolbar-field-background-color, hsla(0,0%,100%,.8));
  border-radius: var(--toolbarbutton-border-radius);
  --uc-urlbar-min-width: none; /* navbar_tabs_oneliner.css compatibility */
}

#urlbar[focused] {
  box-shadow: inset 0 0 0 1px var(--toolbar-field-focus-border-color, highlight);
  height: 24px !important;
  max-height: 24px !important;
}

#urlbar[focused] > *:not(.urlbarView) {
  padding: unset !important;
  padding-top: 2px !important;
  padding-left: 1px !important;
  height: 24px !important;
  max-height: 24px !important;
}

.urlbarView {
  position: absolute !important;
  margin: 0 !important;
  margin-top: 8px !important;
  left: 0 !important;
  width: 40vw !important; /* width of the urlbar pop up; set to 100vw to make it as wide as the browser window */
  border-width: 1px 0;
  top: calc(var(--urlbar-toolbar-height) + 1px); /* symmetry */
  background-color: var(--toolbar-field-focus-background-color, inherit);
  z-index: 4;
  box-shadow: 0 1px 4px rgba(0,0,0,.05);
}

#urlbar > #urlbar-input-container {
  padding: 0px !important;
  width: auto !important;
  height: 24px !important;
  max-height: 24px !important;
}

#urlbar > #urlbar-background {
  display: none !important;
}

/* This may seem pretty weird, but it gets around an issue where the height of urlbar may suddenly change when one starts typing into it */
/* If you are otherwise modifying the urlbar height then you might need to modify the height of this too */
#urlbar > #urlbar-input-container::before {
  content: "";
  display: -moz-box;
  height: 24px !important;
} 
           '';
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        darkreader
        tridactyl
        youtube-shorts-block
        aria2-integration
      ];
    };
  };
  home.file.".config/tridactyl".source = ./tridactyl;
  home.file."Browser-Homepage".source = ./homepage;
}
