
busy = (Paused || levelPrompt || isDead);

color = c_white;




// Movement
handleMovement();


// Weapons
weaponCodeUpdate();

if (Keymap.player.switchWeapons) {
	if (handIndex == 0) handIndex = 1; else handIndex = 0;
}


// Health
handleHealth();


// Collisions
if (place_meeting(x, y, Enemy)) {
	var enemy = instance_nearest(x, y, Enemy);
	hit(enemy.damage, enemy);
	effects_transfer(enemy);
}

if (distance_to_object(Coin) < coinMagnetRange * coinMagnetMultiplier) {
	var coin = instance_nearest(x, y, Coin);
	
	if (!coin.collected) {
		coins += 1 + Level.storedCoins;
		Level.storedCoins = 0;
		
		//if (!audio_is_playing(snd_coin1)) audio_play_sound(snd_coin1, 0, false, 0.25, 0.06, random_range(0.80, 1.00));
	}
	
	coin.collected = true;
}


if (place_meeting(x, y, EnemyProjectile) && hitCooldown == 0) {
	var p = instance_nearest(x, y, EnemyProjectile);
	var damage = p.damage;
	
	hit(damage, p);
	
	if (p.destructible) {
		instance_destroy(p);
	}
}


// Enemies
if (enemyClosest != -1) {
	if (getHand().weaponID == -1) return;
	
	var range = WeaponData[? getHand().weaponID][getHand().weaponUpgrade].components.range * reachMultiplier;
	enemyInRange = (distance_to_object(enemyClosest) < range);
}

if (instance_exists(Enemy)) {
	enemyClosest = instance_nearest(x, y, Enemy);
	
} else {
	enemyClosest = -1;
}


// Effects
effects_apply(self);


// Items
updateItems();


// Consumables
consumablesLogic();


// Character's unique code
character_get(characterID).update(self);


// Garbage
if (keyboard_check_pressed(ord("X"))) instance_create_depth(x, y, depth, Drop);



x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

