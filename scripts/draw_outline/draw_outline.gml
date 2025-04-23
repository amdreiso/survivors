function draw_outline(sprite, x, y, offset, color, scale = 1){
	
	gpu_set_fog(true, color, 0, 1);
	
	draw_sprite_ext(sprite, image_index, x+offset, y, image_xscale * scale, image_yscale * scale, image_angle, color, image_alpha);
	draw_sprite_ext(sprite, image_index, x, y+offset, image_xscale * scale, image_yscale * scale, image_angle, color, image_alpha);
	draw_sprite_ext(sprite, image_index, x+offset, y+offset, image_xscale * scale, image_yscale * scale, image_angle, color, image_alpha);
	draw_sprite_ext(sprite, image_index, x-offset, y, image_xscale * scale, image_yscale * scale, image_angle, color, image_alpha);
	draw_sprite_ext(sprite, image_index, x, y-offset, image_xscale * scale, image_yscale * scale, image_angle, color, image_alpha);
	draw_sprite_ext(sprite, image_index, x-offset, y-offset, image_xscale * scale, image_yscale * scale, image_angle, color, image_alpha);
	draw_sprite_ext(sprite, image_index, x+offset, y-offset, image_xscale * scale, image_yscale * scale, image_angle, color, image_alpha);
	draw_sprite_ext(sprite, image_index, x-offset, y+offset, image_xscale * scale, image_yscale * scale, image_angle, color, image_alpha);
	
	gpu_set_fog(false, c_white, 0, 1);
	
	draw_sprite_ext(sprite, image_index, x, y, image_xscale * scale, image_yscale * scale, image_angle, c_white, image_alpha);
	
}