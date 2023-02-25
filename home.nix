{ config, pkgs, ...}:

{
	# Imports
	imports = [
		./modules/git
		./modules/neovim
		./modules/wezterm
		./modules/xresources
		./modules/zsh
	];

	# Let Home-Manager install and manage itself
	programs.home-manager.enable = true;
	
	# Home-Manager needs a bit of information about you and the paths it should manage
	home.username = "fedepujol";
	home.homeDirectory = "/home/fedepujol";
	
	# This value determines the Home-Manager release that your configuration is compatible with.
	# This helps avoid breakage when a new Home-Manager release introduces backwards incompatible changes.
	#
	# You can update Home-Manager without changing this value.
	# See the Home-Manager release notes for a list of state version changes in each release.
	home.stateVersion = "22.05";
	
	home.packages = with pkgs; [
		android-tools
		bleachbit
		fzf
		htop
		lazygit
		nodePackages.npm
		ripgrep
		scrcpy
		testdisk
		wezterm
		
		# Lsp's
		nodePackages.bash-language-server
		nodePackages.pyright
		nodePackages.typescript-language-server
		nodePackages.vim-language-server
		nodePackages.vscode-langservers-extracted
		nodePackages.yaml-language-server
		nil
		sumneko-lua-language-server
	];
}
