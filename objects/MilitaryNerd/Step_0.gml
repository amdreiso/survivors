
event_inherited();

shootCooldown = max(0, shootCooldown - GameSpeed);

if (distance_to_object(Player) < 100 && shootCooldown == 0) {
	shoot = true;
}

allowMovement = (!shoot);

if (shoot) {
	sprite_index = spriteState.idle;
	fireCooldown += GameSpeed;
	
	if (fireCooldown >= 20) {
		var precision = random_range(-2.00, 2.00);
		var dir = point_direction(x, y, Player.x, Player.y) + precision;
		var proj = instance_create_depth(x, y - sprite_get_height(sprite_index) / 2, depth, EnemyProjectile);
		
		struct_merge(proj, projectileStats);
		
		proj.direction = dir;
		proj.damage = 30;
		proj.sprite = sProjectile_Pistol;
		proj.image_angle = dir;
		
		fireCooldown = 0;
		burstCount ++;
	}
	
	if (burstCount >= 8) {
		shoot = false;
		shootCooldown = 5 * 60;
		burstCount = 0;
		
		spd = defaultSpd;
	}
}

color = c_purple;
