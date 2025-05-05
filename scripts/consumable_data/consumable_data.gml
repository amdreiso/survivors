
function consumable_data(){
	
	globalvar ConsumableData;
	ConsumableData = ds_map_create();
	
}

function consumable_create(consumableID, name, sprite, icon, load = function(){}) {
	var consumable = {};
	
	consumable.name = name;
	consumable.sprite = sprite;
	consumable.icon = icon;
	consumable.load = load;
	
	ConsumableData[? consumableID] = consumable;
}

function consumable_init() {
	
	consumable_create(eConsumableID.Estrogen, "Estrogen", sConsumable_Estrogen, sConsumable_EstrogenHUD, function(obj) {
		with (obj) {
			effect_add(eEffectID.SpeedBoost2, 10 * 60);
		}
	});
	
	consumable_create(eConsumableID.BlackPanty, "Black Panty", sConsumable_BlackPanty, sConsumable_BlackPantyHUD, function(obj) {
		with (obj) {
			effect_add(eEffectID.SpeedBoost1, 10 * 60);
			effect_add(eEffectID.Armor1, 60 * 60);
		}
	});
	
	consumable_create(eConsumableID.Granade, "Granade", sConsumable_Grenade, sConsumable_BlackPantyHUD, function(obj) {
		granade_throw(obj);
	});
	
}

function consumable_get(consumableID) {
	if (!ds_map_exists(ConsumableData, consumableID)) return;
	return ConsumableData[? consumableID];
}