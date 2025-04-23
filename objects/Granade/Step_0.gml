
time = max(0, time - GameSpeed);

force.x = lerp(force.x, 0, 0.1);
force.y = lerp(force.y, 0, 0.1);

x += force.x;
y += force.y;

if (time == 0) {
	explosion_set(x, y, range, damage, 30);
	instance_destroy();
}
