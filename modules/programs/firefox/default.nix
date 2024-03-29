{ config, pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    #nativeMessagingHosts.packages =  [ pkgs.tridactyl-native ] ;
    #nativeMessagingHosts.tridactyl = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      cfg = {
        # Tridactyl native connector
        enableTridactylNative = true;
      };
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        DisplayBookmarksToolbar = true;
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
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
      ];
    };
  };
  home.file.".config/tridactyl".source = ./tridactyl;
  home.file."Browser-Homepage".source = ./homepage;
}
