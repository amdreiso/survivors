
speed = spd * GameSpeed;

color = c_white;

if (burn.active) {
	effect_add(eEffectID.Burn, burn.time);
}


handleDestroy();

effects_apply(self);


tick += GameSpeed;
if (tick >= lifeTime) {
	instance_destroy();
}

gracePeriod = max(0, gracePeriod - GameSpeed);
