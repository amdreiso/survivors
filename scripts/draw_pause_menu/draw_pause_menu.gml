function draw_pause_menu(){
	
	static pauseMenuAlpha = 0;
	
	if (!Paused) {
		pauseMenuAlpha = lerp(pauseMenuAlpha, 0, 0.5);
	} else {
		pauseMenuAlpha = lerp(pauseMenuAlpha, 1, 0.5);
	}
	
	if (pauseMenuAlpha < 0.05) return;
	
	var width = 500;
	var height = 600;
	
	var x0 = WIDTH / 2, y0 = HEIGHT / 2;
	
	rect(x0, y0, WIDTH, HEIGHT, c_black, false, pauseMenuAlpha / 1.25);
	
}