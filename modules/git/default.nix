{ pkgs, ...}:

{
	programs = {
		git = {
			enable = true;
			delta = {
				enable = true;
			};
			userEmail = "fpujol@proton.me";
			userName = "fedepujol";
			extraConfig = {
				init.defaultBranch = "main";
			};
		};
	};
}
