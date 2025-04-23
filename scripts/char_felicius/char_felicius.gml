function char_felicius(){
	
	var update = function(player) {
		
		
		
	}
	
	var draw = function(player) {
		with (player) {
			static isCat = false;
			static catCooldown = 0;
		
			if (keyboard_check_pressed(vk_space) && !isCat) {
				isCat = true;
				catCooldown = 10 * 60;
			}
		
			catCooldown = max(0, catCooldown - GameSpeed);
		
			if (catCooldown == 0) isCat = false;
		
			if (isCat) {
				var sprite = sCharacterFelicius_CatIdle;
				
				if (isMoving) sprite = sCharacterFelicius_CatMove;
				
				drawPlayer = false;
				sprite_index = sprite;
				draw_self();
			} else {
				
				drawPlayer = true;
				
			}
		}
	}
	
	var drawGUI = function(player) {
	}
	
	character_create(
		eCharacterID.Felicius,
		"Felicius",
		character_create_sprite(sCharacterFelicius_Idle, sCharacterFelicius_Move, sCharacterFelicius_Idle),
		update,
		draw,
		drawGUI,
		{
			weaponID: eWeaponID.Hairball,
			card: sCharacterGeorge_Card,
			color: c_orange,
			
			spd: 1.23,
		}
	);
	
}
