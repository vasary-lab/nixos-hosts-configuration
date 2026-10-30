{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    autocd = true;

    shellAliases = {
      k = "kubectl";
      ll = "eza --icons=always -l";
      docker-compose = "podman-compose";
    };

    history = {
      append = true;
      extended = true;
      ignoreAllDups = true;
    };

    initContent = ''
      export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
      eval "$(direnv hook zsh)"

      autoload -Uz bracketed-paste-magic
      zle -N bracketed-paste bracketed-paste-magic

    '';

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "sudo"
        "colored-man-pages"
      ];
    };
  };
}
