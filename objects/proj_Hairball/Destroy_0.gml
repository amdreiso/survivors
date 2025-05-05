
event_inherited();

redirect ++;

if (redirect > 3) return;

var range = 40;
var offset = 0;
var dir = irandom(360);
var xx = x + lengthdir_x(offset, dir);
var yy = y + lengthdir_y(offset, dir);

var proj = instance_create_depth(xx, yy, -9999, proj_Hairball);

struct_merge(proj, WeaponData[? Player.weaponID][Player.weaponUpgrade].components.projectile);
struct_merge(proj, Player.projectileStats);

proj.direction = dir;
proj.gracePeriod = 10;
proj.sprite = sHairball;
proj.target = eProjectileTarget.Enemy;


