function weapon_SingularitySplitter(){
	WeaponData[? eWeaponID.SingularitySplitter] = [
	
		// First Upgrade
		weapon_create("Singularity Splitter", eWeaponType.Gun, 0,
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
					proj.sprite = sAlienProjectile;
					
					weaponRecoil = recoil;
					
					projectile_apply_effects(proj, weapon.components.effects);
					
					camera_shake(weapon.components.cameraShake);
					
					singularitySplitterShotCount ++;
				}
				
				// Shoot explosive bullet on 100 kills
				if (singularitySplitterShotCount >= 100) {
					singularitySplitterShotCount = 0;
					
					var xx = x + lengthdir_x(offset, dir);
					var yy = y + lengthdir_y(offset, dir);
					
					var proj = instance_create_depth(xx, yy - sprite_get_height(sprite_index) / 2, depth, Projectile);
					
					struct_merge(proj, projectile);
					struct_merge(proj, projectileStats);
					
					proj.spd = 1.25;
					proj.scale = 2.33;
					
					proj.direction = dir;
					proj.target = eProjectileTarget.Enemy;
					proj.image_angle = proj.direction;
					proj.sprite = sAlienExplosiveProjectile;
					
					proj.explosive = {
						active: true,
						damage: 120,
						range: 100,
					};
					
					projectile_apply_effects(proj, weapon.components.effects);
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
				
				var part = (singularitySplitterShotCount / 100) * 100;
				draw_healthbar(xx, yy, xx + width, yy + height, part, c_black, c_yellow, c_yellow, 0, true, true);
				
			}
			
		},

		{	
			recoil: 0,
			precision: 15,
			cadency: 5,
			sprite: sAlien,
			spriteGUI: sAlien_Icon,
			
			range: 100,
			
			cameraShake: 0,
			projectileOffset: 20,
			
			projectile: {
				spd: 2.333,
				damage: 6.66,
				stun: 0,
			},
			
		}),
		
	]
}