function text(x, y, str, xscale = 1, yscale = 1, angle = 0, color = c_white, alpha = 1, font = fnt_main, halign = fa_center, valign = fa_middle){
	
	draw_set_font(font);
	draw_set_halign(halign);
	draw_set_valign(valign);
	
	draw_text_transformed_color(x, y, str, xscale, yscale, angle, color, color, color, color, alpha);
	
}