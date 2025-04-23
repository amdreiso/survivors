function player_add_level(){
	with (Player) {
		level ++;
		levelPrompt = true;
		levelPromptSetWeapons();
	}
}