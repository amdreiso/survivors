
characterID = 0;
index = 0;

listMargin = 10;
listItemPadding = 1.1;
listItemScale = 0.5;
listItemScaleMultiplier = 0.80;
listItemNewScale = 1.0;
listItemMax = 4;

enum CHARACTER_PAGE {
	Home,
	Weapon,
}

pageButtons = [
	{
		page: CHARACTER_PAGE.Home,
		icon: sIcon_Home,
	},
	{
		page: CHARACTER_PAGE.Weapon,
		icon: sIcon_Weapon,
	},
];

pageIndex = 0;

draw = function() {
	
	var scale = 0.80;
	var len = ds_map_size(CharacterData);
	
	for (var i = 0; i < len; i++) {
		
		var character = character_get(i);
		var spr = character.components.card;
		
		var scale = listItemScale;
		var itemColor = c_gray;
		
		listItemScaleMultiplier = 0.90;
		
		if (characterID == i) {
			listItemScaleMultiplier = 1.00;
			itemColor = c_white;
		}
		
		var newScale = scale * listItemScaleMultiplier;
		listItemNewScale = lerp(listItemNewScale, newScale, 1);
		
		
		var maxRows = listItemMax;
		var slotWidth = sprite_get_width(spr) * scale;
		var slotHeight = sprite_get_height(spr) * scale;
		var slotPadding = listItemPadding;
		var margin = listMargin;
		
		var yIndent = i div maxRows;
		
		var wp = slotWidth * slotPadding;
		
		var slotX = ((margin + slotWidth / 2) + i * wp) - (yIndent * maxRows) * wp;
		var slotY = (margin + slotHeight / 2) + (yIndent * (slotHeight * slotPadding));
		
		ii = i;
		
		var buttonWidth = sprite_get_width(spr) * listItemNewScale;
		var buttonHeight = sprite_get_height(spr) * listItemNewScale;
		
		button_gui(slotX, slotY, buttonWidth, buttonHeight, "", -1, true, Style.outlineColor, Style.rainbow, 0.25, 1, function(){
			
			if (mouse_check_button_pressed(mb_left)) {
				characterID = ii;
			}
			
		}, BUTTON_ORIGIN.MiddleCenter);
		
		
		draw_sprite_ext(spr, -1, slotX, slotY, newScale, newScale, 0, itemColor, 1);
		
	}
	
}

drawSelectedCharacter = function() {
	if (characterID == -1) return;
	
	var character = character_get(characterID);
	var name = character.name;
	var card = character.components.card;
	var desc = character.components.description;
	var weapon = weapon_get(character.components.weaponID);
	var len = listItemMax;
	var spriteWidth = sprite_get_width(sCharacterDefault_Card) / 2;
	
	var xOffset = listMargin + (len * spriteWidth * listItemPadding);
	var width = window_get_width() - xOffset;
	
	draw_line_color(xOffset, 0, xOffset, 500, c_white, c_white);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	// Center
	var xx = xOffset + width / 2;
	
	draw_text_transformed(xx, 50, name, 2, 2, 0);
	
	var infoOffset = sprite_get_width(card) - sprite_get_width(card) / 4;
	var offset = 25;
	
	var farRight = xx + infoOffset - offset;
	var farLeft = xx - sprite_get_width(card) + offset;
	
	draw_set_halign(fa_left);
	draw_sprite_ext(card, 0, farRight, 200, 0.5, 0.5, 0, c_white, 1);
	draw_text_ext_transformed(farLeft, 200, desc, 14, 350, 1, 1, 0);
	
	for (var i = 0; i < array_length(pageButtons); i++) {
		currentButton = pageButtons[i];
		
		var buttonWidth = 40;
		var buttonHeight = 30;
		var buttonPadding = 1.05;
		
		var buttonOffsetX = 50;	
		var buttonX = (farLeft + buttonOffsetX) + i * (buttonWidth * buttonPadding);
		var buttonY = 350;
		
		var iconColor = Style.iconColor;
		
		if (i == pageIndex) {
			rect(
				buttonX, buttonY, buttonWidth, buttonHeight, Style.outlineColor, false, 0.60
			);
			
			iconColor = Style.iconColorSelected;
		}
		
		if (currentButton.icon != -1) {
			draw_sprite_ext(currentButton.icon, 0, buttonX, buttonY, 1, 1, 0, iconColor, 1);
		}
		
		button_gui(
			buttonX, buttonY, buttonWidth, buttonHeight, "", -1, true, Style.outlineColor,
			c_white, 0.1, 1, function(){
				
				if (mouse_check_button_pressed(mb_left)) {
					pageIndex = currentButton.page;
				}
				
			}, BUTTON_ORIGIN.MiddleCenter
		);
		
		var lineY = ceil(buttonY + buttonHeight / 2) + 1;
		draw_line_color(
			buttonX - buttonWidth / 2, lineY, farRight, lineY,
			Style.outlineColor, Style.outlineColor
		);
		
	}
	
	switch (pageIndex) {
		
		case CHARACTER_PAGE.Home:
			
			break;
		
		case CHARACTER_PAGE.Weapon:
			
			break;
		
	}
	
	button_gui(
		xx, window_get_height() - 35, width / 1.25, 30, "Play", -1, true, Style.outlineColor, c_white, 0.10, 1,
		function(){
			
			if (mouse_check_button_pressed(mb_left)) {
				room_goto(rmDebug);
				Main.setCharacterID = characterID;
			}
			
		}, BUTTON_ORIGIN.MiddleCenter
	);
	
}





