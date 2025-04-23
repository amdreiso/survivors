function weapon_Bloodclaws(){
	WeaponData[? eWeaponID.BloodClaws] = [
	
		// First Upgrade
		weapon_create("Blood Claws", eWeaponType.Gun, 0,
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
				
				var enemy = instance_nearest(x, y, Enemy);
				var spr = enemy.sprite_index;
				var yOffset = 0;
				if (spr != -1) yOffset = sprite_get_height(spr) / 2;
				
				var x0 = enemy.x, y0 = enemy.y - yOffset;
				var dir = point_direction(x, y, x0, y0);
				
				var shoot = (tick % cadency == true);
				
				if (enemyInRange && shoot) {
					
					var xx = x + lengthdir_x(offset, dir);
					var yy = y + lengthdir_y(offset, dir);
					
					var proj = instance_create_depth(xx, yy - sprite_get_height(sprite_index) / 2, depth, Projectile);
					
					struct_merge(proj, projectile);
					struct_merge(proj, projectileStats);
					
					proj.direction = dir;
					proj.target = eProjectileTarget.Enemy;
					proj.image_angle = proj.direction;
					proj.sprite = sCharacterGeorge_Attack;
					proj.fadeOut = 120;
					proj.fadeOutSpeed = 10;
					proj.destroy = true;
					
					weaponRecoil = recoil;
					
					projectile_apply_effects(proj, weapon.components.effects);
					
					camera_shake(weapon.components.cameraShake, weapon.components.cameraShakePower);
				}
			}
		},
		
		function(player) {
		},

		{
			recoil: 6,
			cadency: 10,
			sprite: -1,
			spriteGUI: sCharacterGeorge_Attack,
			
			range: 30,
			
			cameraShake: 1.70,
			cameraShakePower: 2,
			
			isUnique: true,
			
			projectile: {
				spd: 0.333,
				damage: 15,
				knockback: 0.19,
			},
		}),
		
	
		// Second Upgrade
		weapon_create("Explosive Blood Claws", eWeaponType.Gun, 100,
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
				
				var enemy = instance_nearest(x, y, Enemy);
				var spr = enemy.sprite_index;
				var yOffset = 0;
				if (spr != -1) yOffset = sprite_get_height(spr) / 2; 
				var x0 = enemy.x, y0 = enemy.y - yOffset;
				
				var shoot = (tick % cadency == true);
				
				if (enemyInRange && shoot) {
					var proj = instance_create_depth(x, y - sprite_get_height(sprite_index) / 2, depth, Projectile);
					proj.direction = point_direction(x, y, x0, y0);
					proj.target = eProjectileTarget.Enemy;
					proj.image_angle = proj.direction;
					proj.sprite = sCharacterGeorge_Attack;
					proj.fadeOut = 120;
					proj.fadeOutSpeed = 10;
					proj.destroy = true;
					proj.onDestroy = function(){
						camera_shake(1.5);
					}
					proj.scale = 2;
					
					weaponRecoil = recoil;
					
					struct_merge(proj, projectile);
					struct_merge(proj, projectileStats);
					
					if (irandom(100) > 99) {
						proj.explosive = {
							active: true,
							damage: 100,
							range: 100,
						};
					}
					
					projectile_apply_effects(proj, weapon.components.effects);
					
					camera_shake(weapon.components.cameraShake);
				}
			}
		},
		
		function(player) {
		},

		{
			recoil: 6,
			cadency: 10,
			sprite: -1,
			spriteGUI: sCharacterGeorge_Attack,
			
			range: 30,
			
			cameraShake: 1.90,
			cameraShakePower: 2,
			
			isUnique: true,
			
			projectile: {
				spd: 0.1,
				damage: 30,
				knockback: 3,
			}
		}),
		
	]
}