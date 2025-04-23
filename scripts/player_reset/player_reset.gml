function player_reset(){
	
	if (!instance_exists(Player)) return;
	
	with (Player) {
		
		// currency
		coin = 0;
		
		// special
		special = false;
		specialCooldown = 0;
		
		// health
		isDead = false;
		showHealthbar = 0;
		
		// movement
		force = vec2();
		
		spdMultiplier = 1.0;
		staminaMultiplier = 1.0;
		runMultiplier = 1.25;
		
		// leveling
		xp = 0;
		xpNextLevel = 100;
		level = 0;
		
		projectileStats = {
			burn: {
				active: false,
				time: 180,
			},
	
			explosive: {
				active: false,
				damage: 0,
				range: 0,
			},
		}
		
	}
	
}