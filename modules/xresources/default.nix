{ pkgs, ...}:

{
	xresources = {
		properties = {
			"Xft.dpi" = 71;
			"Xft.antialias" = true;
			"Xft.rbga" = "rgb";
			"Xft.autohint" = true;
			"Xft.hintstyle" = "hintfull";
			"Xft.lcdfilter" = "lcdfilter";

			# Xterm
			"XTerm*faceName" = "Fira Code";
			"XTerm*faceSize" = 10;
			"XTerm*renderFont" = true;

			# Colors
			"*.foreground" = "#E0E0E0";
			"*.background" = "#212121";
			"*.cursorColor" = "#B0B0B0";
			"*.color0" = "#161616";
			"*.color8" = "#7f7061";
			"*.color1" = "#D84315";
			"*.color9" = "#FF5722";
			"*.color2" = "#00c853";
			"*.color10"= "#2e7d32";
			"*.color3" = "#ffff8d";
			"*.color11" = "#f9a825";
			"*.color4" = "#90caf9";
			"*.color12" = "#1976d3";
			"*.color5" = "#f8bbd9";
			"*.color13" = "#f06292";
			"*.color6" = "#80deea";
			"*.color14" = "#00838f";
			"*.color7" = "#e1e1e1";
			"*.color15" = "#ffffff";
		};
	};
}
