
depth = -99999;

if (sprite == -1) return;

if (getRandomSprite) {
	image_speed = 0;
	image_index = irandom(sprite_get_number(sprite));
	
	getRandomSprite = false;
}

image_xscale = xscale * scale;
image_yscale = yscale * scale;

sprite_index = sprite;
draw_self();

