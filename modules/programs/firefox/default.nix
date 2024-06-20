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
              /* change these variables to get different colors */
        :root {
            --tridactyl-bg: black !important;
            --tridactyl-fg: white !important;
        }

        #tabbrowser-tabs {
        	--tab-active-bg-color: #005577;
        	--tab-inactive-bg-color: #333333;
        	--tab-active-fallback-fg-color: #ffffff;
        	--tab-inactive-fallback-fg-color: #888888;
        }

        /* change to control tabbar height */
        /* try increasing to 20px if you see a black line under tabbar */
        #titlebar { --tab-min-height: 16px !important; }

        /* --- GENERAL DEBLOAT ---------------------------------- */

        /* Bottom left page loading status or url preview */
        #statuspanel { display: none !important; }

        /* --- DEBLOAT NAVBAR ----------------------------------- */

        #back-button { display: none; }
        #forward-button { display: none; }
        #reload-button { display: none; }
        #stop-button { display: none; }
        #home-button { display: none; }
        /* #downloads-button { display: none; } */
        #library-button { display: none; }
        #fxa-toolbar-menu-button { display: none; }

        /* Empty space before and after the url bar */
        #customizableui-special-spring1,
        #customizableui-special-spring2 { display: none; }

        #nav-bar,
        #navigator-toolbox {
        	border-width: 0 !important;
        	--toolbar-field-focus-border-color: #42414d;
        }

        /* --- STYLE URLBAR ------------------------------------- */

        #urlbar-container {
        	--urlbar-container-height: var(--tab-min-height) !important;
        	margin-left: 0 !important;
        	margin-right: 0 !important;
        	padding-top: 0 !important;
        	padding-bottom: 0 !important;
        	font-family: 'Jetbrains Mono', monospace;
        	font-size: 11px;
        }

        #urlbar {
        	--urlbar-height: var(--tab-min-height) !important;
        	--urlbar-toolbar-height: var(--tab-min-height) !important;
        	min-height: var(--tab-min-height) !important;
        	border-color: var(--lwt-toolbar-field-border-color, hsla(240,5%,5%,.25)) !important;
        	--autocomplete-popup-highlight-background: transparent !important;
        }

        #urlbar-background {
        	border-width: 0 !important;
        	border-radius: 0 !important;
        }

        #urlbar-input-container {
        	border-width: 0 !important;
        	margin-left: 1em !important;
        }

        #urlbar-input {
        	margin-left: 0.4em !important;
        	margin-right: 0.4em !important;
        }

        .urlbarView-row {
        	padding-top: 0 !important;
        	padding-bottom: 0 !important;
        	line-height: var(--urlbar-height) !important;
        }

        .urlbarView-row-inner {
        	padding-top: 0.3em !important;
        	padding-bottom: 0.3em !important;
        	height: var(--urlbar-height) !important;
        }

        .urlbarView-favicon {
        	height: 1em !important;
        	width: 1em !important;
        	margin-bottom: 0.2em !important;
        }

        /* --- DEBLOAT URLBAR ----------------------------------- */

        #identity-box { display: none; }
        #pageActionButton { display: none; }
        #pocket-button { display: none; }
        #urlbar-zoom-button { display: none; }
        #tracking-protection-icon-container { display: none !important; }
        #reader-mode-button{ display: none !important; }
        #star-button { display: none; }

        /* this will remove the invisible box at the end of urlbar but also will
         * disable the Ctrl+D shortcut */
        /* #star-button-box { display: none; } */

        /* Go to arrow button at the end of the urlbar when searching */
        #urlbar-go-button { display: none; }

        /* remove container indicator from urlbar */
        #userContext-label, #userContext-indicator { display: none !important;}

        /* --- STYLE TAB TOOLBAR -------------------------------- */

        #titlebar {
        	--proton-tab-block-margin: 0px !important;
        	--tab-block-margin: 0 !important;
        }

        :root:not([customizing]) #TabsToolbar{
        	background-color: #222;
        }

        :root:not([customizing]) #navigator-toolbox {
        	background-color: #222 !important;
        }

        #TabsToolbar, .tabbrowser-tab {
        	max-height: var(--tab-min-height) !important;
        	font-size: 11px !important;
        }

        /* Change color of normal tabs */
        tab:not([selected="true"]) {
        	background-color: var(--tab-inactive-bg-color) !important;
        	color: var(--identity-icon-color, --tab-inactive-fallback-fg-color) !important;
        }

        tab {
        	font-family: 'Jetbrains Mono', monospace;
        	font-weight: bold;
        	border: none !important;
        }

        /* safari style tab width */
        .tabbrowser-tab[fadein] { max-width: 100vw !important; border: none }

        /* Hide close button on tabs */
        #tabbrowser-tabs .tabbrowser-tab .tab-close-button { display: none !important; }

        /* hide container line on tab*/
        #tabbrowser-tabs .tab-context-line { display: none }

        /* disable favicons in tab */
        .tab-icon-stack:not([pinned]) { display: none !important; }

        .tabbrowser-tab {
        	/* remove border between tabs */
        	padding-inline: 0px !important;
        	/* reduce fade effect of tab text */
        	--tab-label-mask-size: 1em !important;
        	/* fix pinned tab behaviour on overflow */
        	overflow-clip-margin: 0px !important;
        }

        /* remove min-height from tabs toolbar (needed for fullscreen one tab) */
        #TabsToolbar,
        #tabbrowser-tabs,
        #tabbrowser-tabs > .tabbrowser-arrowscrollbox,
        #tabbrowser-arrowscrollbox { min-height: 0 !important; }

        /* Tab: selected colors */
        #tabbrowser-tabs .tabbrowser-tab[selected] .tab-content {
        	background: var(--tab-active-bg-color) !important;
        	border: none !important;
        	color: var(--identity-icon-color, --tab-active-fallback-fg-color) !important;
        }

        /* Tab: hovered colors */
        #tabbrowser-tabs .tabbrowser-tab:hover:not([selected]) .tab-content {
        	background: var(--tab-active-bg-color) !important;
        }

        /* remove white margin around active tabs */
        #tabbrowser-tabs:not([movingtab]) > #tabbrowser-arrowscrollbox > .tabbrowser-tab[beforeselected-visible]::after,
        #tabbrowser-tabs[movingtab] > #tabbrowser-arrowscrollbox > .tabbrowser-tab[visuallyselected]::before,
        .tabbrowser-tab[visuallyselected]::after { border: none !important; }

        /*AGENT_SHEET*/
        #main-window #navigator-toolbox #TabsToolbar:not(:-moz-lwtheme) { background: var(--tab-active-bg-color) !important; }

        /* hide window controls */
        .titlebar-buttonbox-container { display: none; }

        /* remove titlebar spacers */
        .titlebar-spacer { display: none !important; }

        /* disable tab shadow */
        #tabbrowser-tabs:not([noshadowfortests]) .tab-background:is([selected], [multiselected]) {
            box-shadow: none !important;
        }

        /* remove dark space between pinned tab and first non-pinned tab */
        #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs]) > #tabbrowser-arrowscrollbox > .tabbrowser-tab[first-visible-unpinned-tab] {
        	margin-inline-start: 0px !important;
        }

        /* remove dropdown menu button which displays all tabs on overflow */
        #alltabs-button { display: none !important }

        /* fix displaying of pinned tabs on overflow */
        #tabbrowser-tabs:not([secondarytext-unsupported]) .tab-label-container {
        	height: var(--tab-min-height) !important;
        }

        /* remove overflow scroll buttons */
        #scrollbutton-up,
        #scrollbutton-down {
        	display: none !important;
        }

        /* --- AUTOHIDE URLBAR ---------------------------------- */

        /* hide urlbar unless focused */
        #nav-bar {
        	min-height: 0 !important;
        	max-height: 0 !important;
        	height: 0 !important;
        	--moz-transform: scaleY(0) !important;
        	transform: scaleY(0) !important;
        }

        /* #titlebar:hover~#nav-bar, */
        /* #nav-bar:hover, */
        #nav-bar:focus-within {
        	--moz-transform: scale(1) !important;
        	transform: scale(1) !important;
        	max-height: var(--urlbar-height) !important;
        	height: var(--urlbar-height) !important;
        	min-height: var(--urlbar-height) !important;
        }

        /* show on toolbox focus */
        #navigator-toolbox:focus-within > .browser-toolbar {
        	transform: translateY(0);
        	opacity: 1;
        }
        /* show on toolbox hover */
        /* #titlebar:hover ~ .browser-toolbar, */
        /* #nav-bar:hover, */
        /* #nav-bar:hover + #PersonalToolbar { */
        /* 	transform: translateY(0); */
        /* 	opacity: 1; */
        /* } */

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
