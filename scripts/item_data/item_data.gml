
function item_data(){
	globalvar ItemData; 
	ItemData = ds_map_create();
}

function item_create(itemID, name, sprite, description, load = function(){}, update = function(){}) {
	var item = {};
	
	item.name = name;
	item.sprite = sprite;
	item.description = description;
	item.load = load;
	item.update = update;
	
	ItemData[? itemID] = item;
	show_debug_message(ItemData[? itemID]);
}

function item_init() {
	
	item_create(
		eItemID.Jalapeno, 
		"Jalapeno", 
		sItem_Jalapeno,
		"Makes all your bullets flamable",
		function(obj) {
			with (obj) {
				projectileStats.burn.active = true;
			}
		},
		function(obj) {
		}
	);
	
	item_create(
		eItemID.Blahaj, 
		"Blahaj", 
		sItem_Blahaj, 
		"Boosts your speed by 10%",
		function(obj) {
			with (obj) {
				spdMultiplier += 0.10;
			}
		},
		function(obj) {
		}
	);
	
}

function item_get(itemID) {
	if (!ds_map_exists(ItemData, itemID)) return;
	return ItemData[? itemID];
}


