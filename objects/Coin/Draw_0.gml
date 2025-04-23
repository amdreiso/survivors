
depth = -y;


if (floor(fallingTime) <= 0) {
	vsp = 0;
	
	sprite_index = sCoin;
	
	force = vec2();
} else {
	sprite_index = sCoinFlipping;
}

draw_self();
