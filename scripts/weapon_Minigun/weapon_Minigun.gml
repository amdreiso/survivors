function weapon_Minigun(){
	WeaponData[? eWeaponID.Minigun] = [
	
		// First Upgrade
		weapon_create("Minigun", eWeaponType.Gun, 0,
		function(player) {
			if (!instance_exists(Enemy)) return;
			
			with (player) {
				if (busy) return;
				
				static tick = 0;
				tick += GameSpeed;
				
				var weapon					= WeaponData[? getHand().weaponID][getHand().weaponUpgrade];
				var cadency					= weapon.components.cadency;
				var projectile			= weapon.components.projectile;
				var range						= weapon.components.range;
				var recoil					= weapon.components.recoil;
				var offset					= weapon.components.projectileOffset;
				var precision				= weapon.components.precision;
				
				var enemy = instance_nearest(x, y, Enemy);
				var spr = enemy.sprite_index;
				var yOffset = 0;
				if (spr != -1) yOffset = sprite_get_height(spr) / 4;
				
				var x0 = enemy.x, y0 = enemy.y - yOffset;
				var dir = point_direction(x, y, x0, y0) + random_range(-precision, precision);
				
				var shoot = (floor(tick) % cadency == true);
				
				minigunCooldown = max(0, minigunCooldown - GameSpeed);
				
				if (minigunCooldown == 0) {
					minigunOverheat = max(0, minigunOverheat - GameSpeed);
				}
				
				if (minigunOverheat == 0) {
					minigunOverheated = false;
				}
				
				if (enemyInRange && shoot && minigunOverheat < 100 && !minigunOverheated) {
					show_debug_message("true");
					
					var xx = x + lengthdir_x(offset, dir);
					var yy = y + lengthdir_y(offset, dir);
					
					var proj = instance_create_depth(xx, yy - sprite_get_height(sprite_index) / 2, depth, Projectile);
					
					struct_merge(proj, projectile);
					struct_merge(proj, projectileStats);
					
					proj.direction = dir;
					proj.target = eProjectileTarget.Enemy;
					proj.image_angle = proj.direction;
					proj.sprite = sProjectile_Minigun;
					
					weaponRecoil = recoil;
					
					projectile_apply_effects(proj, weapon.components.effects);
					
					camera_shake(weapon.components.cameraShake);
					
					// Player recoil
					var playerRecoil = weapon.components.playerRecoil;
					force.x = -lengthdir_x(playerRecoil, dir);
					force.y = -lengthdir_y(playerRecoil, dir);
					
					minigunCooldown = 60;
					minigunOverheat ++;
					if (minigunOverheat > 99) {
						minigunOverheated = true;
					}
				}
			}
		},
		
		function(player) {
			with (player) {
				
				var offsetX = 10;
				var xx = x + offsetX;
				var yy = y - sprite_get_height(sprite_index) / 5;
				var width = 20;
				var height = 2;
				
				var part = (minigunOverheat / 100) * 100;
				draw_healthbar(xx, yy - height/2, xx + width, yy + height/2, part, c_black, c_white, c_red, 0, true, true);
				
			}
		},

		{	
			recoil: 20,
			precision: 6,
			cadency: 2,
			sprite: sDefault,
			spriteGUI: sDefault,
			
			range: 100,
			
			cameraShake: 1.8,
			projectileOffset: 0,
			
			playerRecoil: 0.21,
			
			projectile: {
				spd: 5.333,
				damage: 12.66,
				stun: 0,
			},
			
		}),
		
	]
}