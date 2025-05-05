
function weapon_get_default_components(type) {
	switch ( type ) {
		case eWeaponType.Gun:
			return {
				damage: 1,
				precision: 2,
				recoil: 1,
				cadency: 20,
				automatic: false,
				
				range: 200,
				
				sprite: -1,
				spriteGUI: -1,
				
				projectileOffset: 0,
				
				playerRecoil: 0,
				
				cameraShake: 0,
				cameraShakePower: 1,
				
				isUnique: false,
				
				effects: [],
				
				projectile: {
					spd: 2,
					damage: 20,
					
					stun: 5,
					knockback: 0,
				}
			}
	}
}

function weapon_create(name, type, cost, update = function(){}, draw = function(){}, components = {}) {
		var wpn = {};
		
		wpn.name = name;
		wpn.type = type;
		wpn.cost = cost;
		wpn.update = update;
		wpn.draw = draw;
		wpn.components = weapon_get_default_components(type);
		
		struct_merge(wpn.components, components);
		
		return wpn;
	}

function weapon_data(){
	
	globalvar WeaponData;
	WeaponData = ds_map_create();
	
}



/*

{
	0: {
		"name": "gun level 1",
		"sprite": sprite,
		"components": {},
	}
}
