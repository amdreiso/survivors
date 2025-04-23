
function xp_add(val) {
	if (!instance_exists(Player)) return;
	
	with (Player) {
		xp += round(val);
		if (xp >= xpNextLevel) {
			xp -= xpNextLevel;
			xpNextLevel = floor( xpNextLevel * xpNextLevelMultiplier );
			
			//player_add_level();
		}
	}
}