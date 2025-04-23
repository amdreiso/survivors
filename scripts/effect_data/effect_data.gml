
function effect_data(){
	
	globalvar EffectData; 
	EffectData = ds_map_create();
	
}

function effect_create(effectID, name, load = function(){}, update = function(){}, destroy = function(obj){}) {
	var effect = {};
	
	effect.name = name;
	effect.load = load;
	effect.update = update;
	effect.destroy = destroy;
	
	EffectData[? effectID] = effect;
}

function effect_get(effectID) {
	if (!ds_map_exists(EffectData, effectID)) return;
	return EffectData[? effectID];
}

function effect_init() {
	
	effect_create(
		eEffectID.Burn,
		"Burn",
		function(obj) {
		},
		
		function(obj) {
			with (obj) {
				static tick = 0;
				tick += GameSpeed;
				
				var val = 222;
				color = c_red;
				
				if (floor(tick) % 60 == true) {
					var damage = 10;
					hit(damage, -1);
					if (obj == Player) camera_shake(5);
				}
				
				if (floor(tick) % 10 == true) {
					repeat ( irandom(1) ) {
						var range = sprite_get_width(sprite_index) / 4;
						var xx = x + random_range(-range, range);
						var yy = y + random_range(-range, range);
						
						with (instance_create_depth(xx, yy, depth, Particle)) {
							sprite = sBurningParticles;
							image_speed = 0;
							image_index = irandom(sprite_get_number(sprite));
							destroyTime = irandom_range(60, 120);
							scale = random_range(0.70, 1.00);
							
							vsp = -random(0.20);
						}
					}
				}
			}
		},
		
		function(obj) {
		}
	);
	
	effect_create(
		eEffectID.SpeedBoost1,
		"Speed Boost I",
		function(obj) {
			with (obj) {
				spdMultiplier += 0.05;
			}
		},
		
		function(obj) {
		},
		
		function(obj) {
			with (obj) {
				spdMultiplier -= 0.05;
			}
		},
	);
	
	effect_create(
		eEffectID.SpeedBoost2,
		"Speed Boost II",
		function(obj) {
			with (obj) {
				spdMultiplier += 0.40;
			}
		},
		
		function(obj) {
		},
		
		function(obj) {
			with (obj) {
				spdMultiplier -= 0.40;
			}
		},
	);
	
	effect_create(
		eEffectID.SpeedBoost3,
		"Speed Boost III",
		function(obj) {
			with (obj) {
				spdMultiplier += 0.90;
			}
		},
		
		function(obj) {
		},
		
		function(obj) {
			with (obj) {
				spdMultiplier -= 0.90;
			}
		},
	);
	
	effect_create(
		eEffectID.Armor1,
		"Armor1",
		function(obj) {
			with (obj) {
				armor -= 0.30;
			}
		},
		
		function(obj) {
		},
		
		function(obj) {
			with (obj) {
				armor += 0.30;
			}
		},
	);
	
}

