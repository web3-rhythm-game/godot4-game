extends Control

# perfect 5187ff
# good a956ff
# normal a6acaf
# bad da0067
# miss 4f0049

func SetTextInfo(text: String):
	$ScoreLevelText.text = "[center]" + text
	
	match text:
		"Perfect":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("5187ff"))
		"Good":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("a956ff"))
		"Normal":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("a6acaf"))
		"Bad":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("da0067"))
		"Miss":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("4f0049"))
