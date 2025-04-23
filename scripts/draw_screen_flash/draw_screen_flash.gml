function draw_screen_flash(){
	draw_set_alpha(ScreenFlash.alpha);
	
	var c = ScreenFlash.color;
	draw_rectangle_color(0, 0, window_get_width(), window_get_height(), c, c, c, c, false);
	
	draw_set_alpha(1);
	
	ScreenFlash.alpha = lerp(ScreenFlash.alpha, 0, ScreenFlash.time);
}