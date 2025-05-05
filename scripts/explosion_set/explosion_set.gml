function explosion_set(x, y, range, damage, knockback = 10){
	// Create Explosion Particles
	repeat ( 30 ) {
		var pos = vec2(
			irandom_range(x - range, x + range),
			irandom_range(y - range, y + range)
		);
		
		instance_create_layer(pos.x, pos.y, "Glow", ExplosionParticle);
	}
	
	// Set damage
	with (Enemy) {
		var dist = point_distance(self.x, self.y, x, y);
		var dir = point_direction(self.x, self.y, Player.x, Player.y);
		var damageFactor = 1;
		var r = range * 5;
		
		var knockbackRange = range * 2;
		
		if (dist <= r) {
			damageFactor = 1 - (dist / r);
			hit(round(damage * damageFactor), Player);
		}
		
		// Knockback
		if (dist <= knockbackRange) {
			var knockbackFactor = 1 - (dist / knockbackRange);
			
			force = vec2();
			
			force.x -= lengthdir_x(knockback * knockbackFactor, dir);
			force.y -= lengthdir_y(knockback * knockbackFactor, dir);
		}
	}
	
	camera_shake(20 - (point_distance(x, y, Player.x, Player.y) / 10));
}