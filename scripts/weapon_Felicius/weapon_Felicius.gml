function weapon_Felicius(){
	WeaponData[? eWeaponID.Hairball] = [
	
		// First Upgrade
		weapon_create("Hairball", eWeaponType.Gun, 0,
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
				
				var x0 = enemy.x, y0 = enemy.y - yOffset;
				var dir = point_direction(x, y, x0, y0) + random_range(-precision, precision);
				
				var shoot = (tick % cadency == true);
				
				if (enemyInRange && shoot) {
					
					var xx = x + lengthdir_x(offset, dir);
					var yy = y + lengthdir_y(offset, dir);
					
					var proj = instance_create_depth(xx, yy - sprite_get_height(sprite_index) / 2, depth, proj_Hairball);
					
					struct_merge(proj, projectile);
					struct_merge(proj, projectileStats);
					
					proj.direction = dir;
					proj.target = eProjectileTarget.Enemy;
					proj.image_angle = proj.direction;
					proj.sprite = sHairball;
					
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
			cadency: 15,
			sprite: -1,
			spriteGUI: sCharacterGeorge_Attack,
			
			range: 60,
			
			isUnique: true,
			
			projectile: {
				spd: 1.333,
				damage: 8,
				redirect: 0,
			},
		}),
		
	]
}