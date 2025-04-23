
drawItemIcons();

drawWeaponGUI();
drawConsumables();

draw_sprite_ext(sCoin, 0, 50, 50, 5, 5, 0, c_white, 1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text_transformed_color(80, 55, coins, 2, 2, 0, c_white, c_white, c_white, c_white, 1);

drawLevelPrompt();


// Character's unique code
character_get(characterID).drawGUI(self);


// Dead GUI
drawDeadMenu();
