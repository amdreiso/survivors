
size = 0;
sizeTo = random_range(0.60, 3.00) * 3;

sprite_index = sExplosionParticles;
image_speed = 0;
image_index = irandom(sprite_get_number(sprite_index));
xscale = choose(-1, 1);
yscale = choose(-1, 1);

color = choose(c_ltgray, c_gray);

alarm[0] = irandom_range(2, 20) * 3;

hsp = random_range(-0.20, 0.20);
vsp = random(0.50);

