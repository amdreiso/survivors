function weapon_Pistol(){
	WeaponData[? eWeaponID.Pistol] = [
	
		// First Upgrade
		weapon_create("Penistol", eWeaponType.Gun, 0, 
		function(player) {
			if (!instance_exists(Enemy)) return;
			
			with (player) {
				if (busy) return;
				
				var weaponID = getHand().weaponID;
				if (weaponID != eWeaponID.Pistol) return;
				
				static tick = 0;
				tick += GameSpeed;
				
				var weapon					= WeaponData[? weaponID][getHand().weaponUpgrade];
				var cadency					= weapon.components.cadency;
				var projectile			= weapon.components.projectile;
				var range						= weapon.components.range;
				var recoil					= weapon.components.recoil;
				var offset					= weapon.components.projectileOffset;
				var precision				= weapon.components.precision;
				
				var enemy = instance_nearest(x, y, Enemy);
				var spr = enemy.sprite_index;
				var yOffset = 0;
				if (spr != -1) yOffset = sprite_get_height(spr) / 2; 
				var x0 = enemy.x, y0 = enemy.y;
				var dir = point_direction(x, y, x0, y0) + random_range(-precision, precision);
				
				var shoot = (tick % cadency == true);
				
				if (enemyInRange && shoot) {
					var xx = x + lengthdir_x(offset.x, dir);
					var yy = y + lengthdir_y(offset.y, dir);
					var proj = instance_create_depth(xx, yy - sprite_get_height(sprite_index) / 2, depth, Projectile);
					
					struct_merge(proj, projectile);
					struct_merge(proj, projectileStats);
					
					proj.direction = dir;
					proj.target = eProjectileTarget.Enemy;
					proj.damage = 40;
					proj.sprite = sProjectile_Pistol;
					proj.image_angle = proj.direction;
					
					weaponRecoil = recoil;
					
					projectile_apply_effects(proj, weapon.components.effects);
					
					camera_shake(weapon.components.cameraShake);
				}
			}
		},
		
		function(player) {
		},

		{
			recoil: 6,
			cadency: 50,
			spriteGUI: sPistol_Icon,
			range: 80,
			
			projectileOffset: vec2(15),
			
			isUnique: true,
			
			projectile: {
				spd: 1.94,
			},
		}),
		
		// Second Upgrade
		weapon_create("Shotcum", eWeaponType.Gun, 125,
		function(player) {
			if (!instance_exists(Enemy)) return;
			
			with (player) {
				if (busy) return;
				
				var weaponID = getHand().weaponID;
				if (weaponID != eWeaponID.Pistol) return;
				
				static tick = 0;
				tick += GameSpeed;
				
				var w = getHand();
				
				var weapon					= WeaponData[? w.weaponID][w.weaponUpgrade];
				var cadency					= weapon.components.cadency;
				var projectile			= weapon.components.projectile;
				var offset					= weapon.components.projectileOffset;
				var range						= weapon.components.range;
				var recoil					= weapon.components.recoil;
				var precision				= weapon.components.precision;
				
				var enemy = instance_nearest(x, y, Enemy);
				var spr = enemy.sprite_index;
				var yOffset = 0;
				if (spr != -1) yOffset = sprite_get_height(spr) / 2; 
				var x0 = enemy.x, y0 = enemy.y - yOffset;
				var dir = point_direction(x, y, x0, y0) + random_range(-precision, precision);
				
				var shoot = (tick % cadency == true);
				
				if (enemyInRange && shoot) {
					for (var i = -1; i < 2; i++) {
						var radius = 17;
						var xx = x + lengthdir_x(offset.x, dir);
						var yy = y + lengthdir_y(offset.y, dir);
						var proj = instance_create_depth(xx, yy - sprite_get_height(sprite_index) / 2, depth, proj_Shotcum);
						
						struct_merge(proj, projectile);
						struct_merge(proj, projectileStats);
						
						proj.direction = dir + (i * radius);
						proj.image_angle = proj.direction;
						
						
						weaponRecoil = recoil;
						
						projectile_apply_effects(proj, weapon.components.effects);
						
						camera_shake(weapon.components.cameraShake);
					}
				}
			}
		},
		
		function(player) {
		},

		{
			recoil: 16,
			cadency: 55,
			sprite: sShotcum,
			spriteGUI: sShotcum_Icon,
			
			projectileOffset: vec2(25),
			
			range: 80,
			
			cameraShake: 3.0,
			isUnique: true,
			
			projectile: {
				spd: 2.07,
			},
		}),
		
		// Third Upgrade
		weapon_create("Bazooka", eWeaponType.Gun, 1000,
		function(player) {
			if (!instance_exists(Enemy)) return;
			
			with (player) {
				if (busy) return;
				
				var weaponID = getHand().weaponID;
				if (weaponID != eWeaponID.Pistol) return;
				
				static tick = 0;
				tick += GameSpeed;
				
				var w = getHand();
				
				var weapon					= WeaponData[? w.weaponID][w.weaponUpgrade];
				var cadency					= weapon.components.cadency;
				var projectile			= weapon.components.projectile;
				var offset					= weapon.components.projectileOffset;
				var range						= weapon.components.range;
				var recoil					= weapon.components.recoil;
				var precision				= weapon.components.precision;
				
				var enemy = instance_nearest(x, y, Enemy);
				var spr = enemy.sprite_index;
				var yOffset = 0;
				if (spr != -1) yOffset = sprite_get_height(spr) / 2; 
				var x0 = enemy.x, y0 = enemy.y - yOffset;
				var dir = point_direction(x, y, x0, y0) + random_range(-precision, precision);
				
				var shoot = (tick % cadency == true);
				
				if (enemyInRange && shoot) {
					var xx = x + lengthdir_x(offset.x, dir);
					var yy = y + lengthdir_y(offset.y, dir);
					var proj = instance_create_depth(xx, yy - sprite_get_height(sprite_index) / 2, depth, proj_Shotcum);
						
					struct_merge(proj, projectile);
					struct_merge(proj, projectileStats);
						
					proj.direction = dir;
					proj.image_angle = proj.direction;
						
					weaponRecoil = recoil;
						
					projectile_apply_effects(proj, weapon.components.effects);
						
					camera_shake(weapon.components.cameraShake);
				}
			}
		},
		
		function(player) {
		},

		{
			recoil: 26,
			cadency: 25,
			sprite: sBazooka,
			spriteGUI: sBazooka_Icon,
			
			projectileOffset: vec2(19),
			
			range: 80,
			
			cameraShake: 3.0,
			isUnique: true,
			
			projectile: {
				spd: 1.54,
			},
		}),
	];
}