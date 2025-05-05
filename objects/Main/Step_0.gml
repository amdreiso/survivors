
Keymap = get_keymap();

// Gameplay
setPlayerCharacter();


// Rainbow
Style.rainbow = make_color_hsv(floor(rainbowTick), rainbowSaturation, rainbowValue);

rainbowTick += rainbowSpeed;
if (rainbowTick >= 255) rainbowTick = 0;


if (keyboard_check_pressed(vk_escape) && room == rmDebug) {
	Paused = !Paused;
}

if (keyboard_check_pressed(vk_f3)) {
	show_debug_overlay(!is_debug_overlay_open());
}
