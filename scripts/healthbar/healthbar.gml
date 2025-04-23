function healthbar(){
	
	showHealthbar = max(0, showHealthbar - GameSpeed);

	if (showHealthbar > 0) {
		var width = 6;
		var height = 0.3;
		var part = (hp / hpMax) * 100;
	
		var yy = y - sprite_get_height(sprite_index) * 1.25;
	
		draw_healthbar(x - width, yy - height, x + width, yy + height, part, c_black, c_red, c_white, 0, true, true);
	}
	
}