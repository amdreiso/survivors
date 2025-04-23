

// Draw player
draw();


// Character's unique code
character_get(characterID).draw(self);


// Weapons
weaponCodeDraw();


// Draw healthbar
healthbar();


if (enemyClosest != -1) {
	with (enemyClosest) {
		if (sprite_index != -1) 
			draw_outline(sprite_index, x, y, 1, Style.rainbow);
	}
}
