
gracePeriod = 0;

spd = 1;
direction = 0;

target = Enemy;

sprite = sProjectile;
scale = 1;

attacked = false;

destroy = false;
destructible = true;
damage = 1;
onDestroy = function(obj){};
destroyOnLastFrame = false;

knockback = 2;

handleDestroy = function() {
	if (!destroy) return;
	
	if (fadeOut > 0) {
		
		fadeOut = max(0, fadeOut - fadeOutSpeed * GameSpeed);
		image_alpha = fadeOut / 120;
		
		return;
	}
	
	instance_destroy();
}

fadeOut = 0;
fadeOutSpeed = 1;

tick = 0;
lifeTime = 10 * 60;

burn = false;
explosive = false;

knockback = 0;
stun = 5;

effects = [];

hp = 0;
showHitmarker = false;

color = c_white;

hit = function(damage, e) {
}

