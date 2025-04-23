function character_data(){
	globalvar CharacterData;
	CharacterData = ds_map_create();
}

function character_get_default_components() {
	var components = {};
	
	components.weaponID = 0;
	components.card = sCharacterDefault_Card;
	components.description = "";
	
	return components;
}
	
function character_create_sprite(idle, move, jump) {
	var spr = {};
	
	spr.idle = idle;
	spr.move = move;
	spr.jump = jump;
	
	return spr;
}
	
function character_create(characterID, name, spr, update, draw, drawGUI, components = {}) {
	var character = {};
	
	character.name					= name;
	character.sprite				= spr;
	character.update				= update;
	character.draw					= draw;
	character.drawGUI				= drawGUI;
	character.components		= character_get_default_components();
	
	struct_merge(character.components, components);
	CharacterData[? characterID] = character;
}

function character_get(characterID) {
	if (!ds_map_exists(CharacterData, characterID)) {
		return undefined;
	}
	
	return CharacterData[? characterID];
}



