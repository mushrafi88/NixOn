{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "history-substring-search"
        "extract"
        "command-not-found"
        "autojump"
        "colored-man-pages"
        "zsh-interactive-cd"
      ];
      theme = "af-magic";
    };
    initExtra = ''
                        bindkey '^f' autosuggest-accept

                       # ALIAS CONFIGS # 
                  	 #
                  # # ex - archive extractor
                  # # usage: ex <file>
                  extract ()
                  {
                    if [ -f $1 ] ; then
                      case $1 in
                        *.tar.bz2)   tar xjf $1   ;;
                        *.tar.gz)    tar xzf $1   ;;
                        *.bz2)       bunzip2 $1   ;;
                        *.rar)       unrar x $1     ;;
                        *.gz)        gunzip $1    ;;
                        *.tar)       tar xf $1    ;;
                        *.tbz2)      tar xjf $1   ;;
                        *.tgz)       tar xzf $1   ;;
                        *.zip)       unzip $1     ;;
                        *.Z)         uncompress $1;;
                        *.7z)        7z x $1      ;;
                        *.iso)        7z x $1      ;;
                        *)           echo "'$1' cannot be extracted via ex()" ;;
                      esac
                    else
                      echo "'$1' is not a valid file"
                    fi
                  }

                  export EDITOR=nvim

                  alias ls='ls --color=auto'
                  alias l='ls -lFh --color=auto'     #size,show type,human readable
                  alias grep='grep --color'
  
                  alias dud='du -d 1 -h'
                  alias duf='du -sh *'
                  alias fd='find . -type d -name'
                  alias h='history'
                  alias hgrep="fc -El 0 | grep"
                  alias help='man'
                  alias p='ps -f'
                  alias sortnr='sort -n -r'
                  alias unexport='unset'

                  alias rm='rm -i'
                  alias cp='cp -i'
                  alias mv='mv -i'
                  alias ff='find -L | fzf'
                  alias q='exit'
                  alias nv_chad='export OPENAI_API_KEY=$(echo $(pass show api/openai_key)) && nvim'
      			alias animdl_start='nix-shell $HOME/NixOn/environment/animdl.nix'
            	  #yafetch
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
