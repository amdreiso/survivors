function char_akira(){
	
	var update = function(player) {
	}
	
	var draw = function(player) {
	}
	
	var drawGUI = function(player) {
	}
	
	character_create(
		eCharacterID.Akira,
		"Akira",
		character_create_sprite(sCharacter_Akira_Idle, sCharacter_Akira_Move, sCharacter_Akira_Idle),
		update,
		draw,
		drawGUI,
		{
			weaponID: eWeaponID.Majesty, 
			card: sCharacterDefault_Card,
			
			defaultSpd: 1.23,
			
			color: c_fuchsia,
			
			description: "",
			weaponDescription: "",
		}
	);
	
}

