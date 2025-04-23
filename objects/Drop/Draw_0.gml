
var consumable = consumable_get(consumableID);

if (consumable.sprite == -1) return;


sprite_index = consumable.sprite;
draw_outline(sprite_index, x, y, 0.5, Style.rainbow);

if (distance_to_object(Player) < 35) {
	var offset = 0.5 + (sin(current_time * 0.02) * 0.10) + 0.10;
	draw_outline(sprite_index, x, y, 0.75 + offset, Style.rainbow);
	
	if (Keymap.player.interact) {
		if (Player.addConsumable(consumableID)) instance_destroy();
	}
}
