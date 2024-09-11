{
  "editor.fontSize" = 19;
  "editor.fontFamily" = "FiraMono Nerd Font Mono";
  "editor.fontLigatures" = true;
  "editor.rulers" = [80 100];
  "editor.minimap.enabled" = false;
  "editor.tabSize" = 2;
  "editor.wordWrap" = "off";
  "editor.renderWhitespace" = "all";
  "editor.formatOnSave" = true;
  "editor.cursorStyle" = "line";
  "editor.lineNumbers" = "on";

  "files.autoSave" = "onFocusChange";

  "workbench.startupEditor" = "newUntitledFile";
  "window.zoomLevel" = 1;

  "explorer.confirmDragAndDrop" = false;
  "editor.selectionClipboard" = false;
  "explorer.autoReveal" = false;
  "explorer.openEditors.visible" = 0;

  # everything is managed by nix
  "sync.autoDownload" = false;
  "sync.autoUpload" = false;
  "sync.forceDownload" = false;
  "sync.quietSync" = false;
  "sync.removeExtensions" = false;
  "sync.syncExtensions" = false;

  "extensions.ignoreRecommendations" = true;
  # color scheme
  "workbench.colorTheme" = "Catppuccin Macchiato";
  "workbench.preferredDarkColorTheme" = "Catppuccin Macchiato";
  "workbench.preferredLightColorTheme" = "Catppuccin Latte";
  "window.autoDetectColorScheme" = true;
  # icons
  "workbench.iconTheme" = "vscode-icons";
  "vsicons.presets.hideExplorerArrows" = true;
  "catppuccin-icons.hidesExplorerArrows" = true;
  # the settings.json is not writable it cannot switch icon pack
  "catppuccin.syncWithIconPack" = false;
  # "catppuccin-icons.monochrome" = true;

  "vsicons.dontShowNewVersionMessage" = true;
  # vim
  "vim.useCtrlKeys" = false;
  "vim.leader" = "<space>";
  "vim.easymotion" = true;
  "vim.incsearch" = true;
  "vim.useSystemClipboard" = true;
}
