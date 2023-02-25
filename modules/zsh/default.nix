{ pkgs, ...}:
{
	programs = {
		zsh = {
			enable = true;
			enableAutosuggestions = false;
			enableCompletion = true;
			enableSyntaxHighlighting = true;
			autocd = true;
			defaultKeymap = "viins";
			dotDir = ".config/zsh";
			history = {
				ignoreDups = true;
				ignoreSpace = true;
				path = "$ZDOTDIR/zsh_history";
			};
		};
	};
}
