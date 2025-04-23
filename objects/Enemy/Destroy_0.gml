
repeat (irandom_range(1, 3)) {
	coin_create(x, y);
}

if (killedByPlayer) {

	repeat (irandom_range(10, 40) * 2) {
	
		with (instance_create_depth(x, y, depth, Particle)) {
		
			sprite = sBloodParticles;
		
			getRandomSprite = true;
			image_blend = choose(c_white, c_ltgray, c_gray);
			hsp = random_range(-1.00, 1.00);
			vsp -= random(2.30);
			destroyTime = irandom_range(10, 30);
			gravityApply = true;
			gravityForce = 0.05;
		
			xscale = choose(-1, 1);
			yscale = choose(-1, 1);
		
		}
	
	}

}

if (irandom(100) > 95) {
	var index = irandom(ds_map_size(ConsumableData) - 1);
	
	var drop = (instance_create_depth(x, y, depth, Drop));
	drop.consumableID = index;
}
