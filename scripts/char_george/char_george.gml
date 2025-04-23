function char_george(){
	
	var update = function(player) {
	}
	
	var draw = function(player) {
	}
	
	var drawGUI = function(player) {
	}
	
	character_create(
		eCharacterID.George,
		"George the Nun",
		character_create_sprite(sCharacterGeorge_Idle, sCharacterGeorge_Move, sCharacterGeorge_Idle),
		update,
		draw,
		drawGUI,
		{
			weaponID: eWeaponID.BloodClaws,
			card: sCharacterGeorge_Card,
			color: c_maroon,
		}
	);
	
}

