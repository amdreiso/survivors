function char_default(){
	
	var update = function(player) {
		
	}
	
	var draw = function(player) {
		
	}
	
	var drawGUI = function(player) {
		with (player) {
			
			if (busy) return;
			
			var specialBuildUpTime = 1.645 * 60;
			
			static logoAlpha = 0;
			static logoScale = 4.5;
			
			
			if (keyboard_check_pressed(vk_space) && !special) {
				special = true;
			}
			
			if (special) {
				specialCooldown += GameSpeed;
			} else return;
			
			if (specialCooldown < specialBuildUpTime) {
				
				logoAlpha = lerp(logoAlpha, 1, 0.25);
				
			} else {
				
				logoAlpha = lerp(logoAlpha, 0, 0.1);
				
			}
			
			// Draw transparent SQUARE
			draw_set_alpha(logoAlpha / 1.10);
			
			var c0 = c_black;
			draw_rectangle_color(0, 0, WIDTH, HEIGHT, c0, c0, c0, c0, false);
			
			draw_set_alpha(1);
			
			
			logoScale += 0.025;
			
			var logoSpeed = (current_time / 500);
			
			var xx = window_get_width()/2;
			var yy = window_get_height()/2;
			
			draw_sprite_ext(sCharacterDefault_Special, logoSpeed, xx, yy, logoScale, logoScale, 0, c_fuchsia, logoAlpha);
			
			
			if (specialCooldown < specialBuildUpTime) return;
			
			camera_shake(1.4);
			
			if (irandom(10) > 2) {
				var pos = randvec2(x, y-10, 200);
				var particle = instance_create_depth(pos.x, pos.y, depth, Particle);
			
				with (particle) {
					self.sprite = sSkullParticles;
					self.image_speed = 0;
					self.image_index = irandom(sprite_get_number(sprite));
					self.destroyTime = irandom_range(60, 120);
					self.scale = random_range(0.70, 1.50);
					
					self.image_blend = c_fuchsia;
					
					self.vsp = -random(0.20);
				}
			}
			
			static attackType = 0;
			static dir = 0;
			
			static tick = 0;
			
			tick += GameSpeed;
			
			switch (attackType) {
				case 0:			// weird stuff
					
					for (var i = -1; i < 2; i++) {
						if (i != 0 && tick % 5 == true) {
							var proj = instance_create_depth(x, y - sprite_get_height(sprite_index) / 2, depth, Projectile);
					
							dir += 15;
					
							struct_merge(proj, projectileStats);
					
							proj.direction = dir * i;
							proj.target = eProjectileTarget.Enemy;
							proj.damage = 25;
							proj.lifeTime = 3 * 60;
						}
					}
					
					if (tick > 5 * 60) {
						tick = 0;
						attackType = 1;
					}
					
					break;
				
				
				case 1:			// radial attack
					
					var proj = instance_create_depth(x, y - sprite_get_height(sprite_index) / 2, depth, Projectile);
					
					dir += 15;
					
					struct_merge(proj, projectileStats);
					
					proj.direction = dir;
					proj.target = eProjectileTarget.Enemy;
					proj.damage = 25;
					proj.lifeTime = 3 * 60;
					
					projectile_apply_effects(proj, [
						[0, 5 * 60]
					]);
					
					if (tick > 5 * 60) {
						tick = 0;
						attackType = 2;
					}
					
					break;
				
				case 2:			// radial attack
					
					repeat (2) {
					
						var proj = instance_create_depth(x, y - sprite_get_height(sprite_index) / 2, depth, Projectile);
					
						dir += 15 * choose(-1, 1);
					
						struct_merge(proj, projectileStats);
					
						proj.direction = dir;
						proj.target = eProjectileTarget.Enemy;
						proj.damage = 25;
						proj.lifeTime = 3 * 60;
					
						projectile_apply_effects(proj, [
							[0, 5 * 60]
						]);
					
					}
					
					if (tick > 5 * 60) {
						tick = 0;
						attackType = 3;
					}
					
					
					break;
				
				case 3:			// radial attack
					
						
					var proj = instance_create_depth(x, y - sprite_get_height(sprite_index) / 2, depth, Projectile);
						
					if (enemyClosest != -1)
						dir = point_direction(x, y, enemyClosest.x, enemyClosest.y);
						
					struct_merge(proj, projectileStats);
						
					proj.direction = dir;
					proj.target = eProjectileTarget.Enemy;
					proj.damage = 25;
					proj.lifeTime = 3 * 60;
					proj.image_blend = c_red;
					proj.scale = 3;
						
					proj.explosive = {
						active: true,
						damage: 200,
						range: 300,
					};
						
					
					special = false;
					specialCooldown = 0;
					tick = 0;
					dir = 0;
					logoScale = 4.5;
					attackType = 0;
					
					break;
			}
		}
	}
	
	character_create(
		eCharacterID.Default,
		"John",
		character_create_sprite(sCharacterDefault_Idle, sCharacterDefault_Move, sCharacterDefault_Idle),
		
		update,
		draw,
		drawGUI,
		
		{
			weaponID: eWeaponID.Pistol, 
			card: sCharacterDefault_Card,
			
			defaultSpd: 1.83,
			
			color: c_fuchsia,
			
			description: "John, an ex-military hitman, who fought against the 'Incel Revolt' in 2199, is now being hunted down by those same NERDS...",
			weaponDescription: "",
		}
	);
	
}

