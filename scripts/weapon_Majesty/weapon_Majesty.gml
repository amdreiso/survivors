function weapon_Majesty(){
	WeaponData[? eWeaponID.Majesty] = [
	
		// First Upgrade
		weapon_create("Majesty", eWeaponType.Gun, 0, 
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
			sprite: sPistol,
			spriteGUI: sWeapon_Majesty,
			range: 80,
			
			projectileOffset: vec2(15),
			
			isUnique: true,
			
			projectile: {
				spd: 1.39,
			},
		}),
	];
}