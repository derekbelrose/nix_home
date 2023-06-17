{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "derek";
  home.homeDirectory = "/home/derek";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.emacs = {
	  enable = true;
	  extraPackages = epkgs: [
		  epkgs.nix-mode
		  epkgs.magit
  	];
  };

  home.packages = [
	  pkgs.htop
	  pkgs.slack
	  pkgs.vim
	  pkgs.firefox
	  pkgs.lm_sensors
    pkgs.tmux
  ];


  systemd.user.services.emacs-daemon = {
	  Unit = {
		  Description = "Emacs Text Editor - Daemon Mode";
		  Documentation = "info:emacs man:emacs(1) https://www.gnu.org/software/emacs/";
	  };
	  Service = {
		  Type = "forking";
		  ExecStart = "${pkgs.stdenv.shell} -l -c 'exec %h/.nix-profile/bin/emacs --daemon'";
		  ExecStop = "%h/.nix-profile/bin/emacsclient --eval '(kill-emacs)'";
		  Restart = "on-failure";
	  };
	  Install = {
		  WantedBy = ["default.target"];
	  };
  };
}
