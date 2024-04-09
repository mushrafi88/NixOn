{ config, lib, pkgs, ... }:

let
  snippets_cp = pkgs.writeShellScriptBin "snippets_cp" '' 
#!/usr/bin/env bash 
  
inotifywait -m -e modify --format '%w%f' "$HOME/NixOn/modules/editors/nvim/LuaSnip_snippets" -r | while read -r FILE
do
  rsync -av "$HOME/NixOn/modules/editors/nvim/LuaSnip_snippets/friendly_snippets/"* "$HOME/.local/share/nvim/lazy/friendly-snippets/snippets/"  

  rsync -av "$HOME/NixOn/modules/editors/nvim/LuaSnip_snippets/lua_latex_snippets/"* "$HOME/.local/share/nvim/lazy/luasnip-latex-snippets.nvim/lua/luasnip-latex-snippets/luasnippets/tex/"  
done
'';
in

{
  home.packages = with pkgs; [
    snippets_cp
  ];
}
