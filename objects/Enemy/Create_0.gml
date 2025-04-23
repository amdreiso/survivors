

busy = false;
sleep = 0;


// Movement
allowMovement = true;
defaultSpd = 0.65;
spd = defaultSpd;
hsp = 0;
vsp = 0;
force = vec2();
isMoving = false;

target = Player;
damage = 15;
knockback = 5;

effects = [];


// Zombie
isZombie = false;

zombify = function() {
	isZombie = true;
	target = instance_nearest(x, y, Enemy);
}

handleZombie = function() {
	if (!isZombie) return;
	
	if (place_meeting(x, y, Enemy)) {
		var enemy = instance_nearest(x, y, Enemy);
		
		enemy.hit( damage, self );
		
		instance_destroy();
	}
}

handleMovement = function() {
	if (target == noone || sleep > 0 || busy) return;
	
	spd = defaultSpd;
	isMoving = (hsp != 0 || vsp != 0);
	
	var dir = point_direction(x, y, target.x, target.y);
	
	hsp = lengthdir_x(spd, dir);
	vsp = lengthdir_y(spd, dir);
	
	force.x = lerp(force.x, 0, 0.1);
	force.y = lerp(force.y, 0, 0.1);
	
	
	if (allowMovement) {
		x += hsp + force.x;
		y += vsp + force.y;
	}
	
	handleZombie();
}

count = 0;

// Health
hpMax = 100;
hp = 100;
isHit = false;
hitCooldown = 0;
isDead = false;
showHitmarker = true;
killedByPlayer = false;

xp = 5;
xpHit = 0;

showHealthbar = 0;

checkDead = function() {
	if (hp <= 0) {
		isDead = true;
		killedByPlayer = true;
	}
}

handleHealth = function() {
	if (hitCooldown > 0) {
		hitCooldown -= GameSpeed;
	} else {
		hitCooldown = 0;
		isHit = false;
	}
	
	if (isDead) {
		xp_add(xp);
		instance_destroy();
	}
}

hit = function(damage, e, shake = 0.8, stun = 5) {
	if (isHit) return;
	
	hp -= damage;
	camera_shake(shake);
	
	hitCooldown = 0;
	isHit = true;
	sleep = stun;
	
	checkDead();
	
	showHealthbar = HEALTHBAR_TIME;
	hitmarker_create(damage);
}


// Draw
color = c_white;

spriteState = {
	idle: sEnemyNerd_Idle,
	move: sEnemyNerd_Move,
}

draw = function(){
	var sprite = spriteState.idle;
	
	if (isMoving) {
		sprite = spriteState.move;
	} else {
	}
	
	if (isZombie) {
		shader_set(shd_zombie);
		
		if (irandom(10) > 8) {
			var pos = randvec2(x, y-10, 15);
			var particle = instance_create_depth(pos.x, pos.y, depth, Particle);
			
			with (particle) {
				self.sprite = sSkullParticles;
				self.image_speed = 0;
				self.image_index = irandom(sprite_get_number(sprite));
				self.destroyTime = irandom_range(60, 120);
				self.scale = random_range(0.70, 1.00);
				
				self.image_blend = c_fuchsia;
				
				self.vsp = -random(0.20);
			}
		}
	}
	
	
	// Turn on x axis
	if (hsp != 0) {
		image_xscale = sign(hsp);
	}
	
	image_blend = color;
	
	sprite_index = sprite;
	draw_self();
	
	shader_reset();
}



projectileStats = {
	burn: {
		active: false,
		time: 180,
	},
	
	explosive: {
		active: false,
		damage: 0,
		range: 0,
	},
}


