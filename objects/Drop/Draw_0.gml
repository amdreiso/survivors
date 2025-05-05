
var consumable = consumable_get(consumableID);

if (consumable.sprite == -1) return;

var scale = sin(current_time * 0.01) * 0.25;

sprite_index = consumable.sprite;
draw_outline(sprite_index, x, y, 0.5 + scale, Style.rainbow);

image_xscale = 1 + scale;
image_yscale = 1 + scale;

if (distance_to_object(Player) < 35) {
	var offset = 0.5 + (sin(current_time * 0.02) * 0.10) + 0.10;
	draw_outline(sprite_index, x, y, (0.5 + scale) + offset, Style.rainbow);
	
	if (Keymap.player.interact) {
		if (Player.addConsumable(consumableID)) instance_destroy();
	}
}
