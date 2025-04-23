
event_inherited();

for (var i = -2; i < 3; i++) {
	var proj = instance_create_depth(x, y - sprite_get_height(sprite_index) / 2, depth, Projectile);
	
	struct_merge(proj, WeaponData[? eWeaponID.Pistol][1].components.projectile);
	struct_merge(proj, Player.projectileStats);
	
	proj.sprite = sProjectile_Pistol;
	proj.direction = irandom(360);
	proj.image_angle = proj.direction;
	proj.target = eProjectileTarget.Enemy;
	proj.damage = 5;
	proj.scale = random_range(0.45, 0.70);
}
