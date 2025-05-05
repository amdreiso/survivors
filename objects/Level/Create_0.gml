
horde = 1;
hordeCooldown = 0;
newHorde = true;
hordeEndCooldown = 120;
hordeEnemyMultiplier = 1.25;

hasEnemies = false;

hordeComplete = function() {
	horde ++;
	hordeCooldown = 2 * 60;
	newHorde = true;
}

resetEnemySpawnTime = function() {
	return random_range(1.00, 4.00) * 60;
}

enemyCountDefault = 20;
enemyCount = enemyCountDefault;
enemyCountIndex = 0;
enemySpawnTime = resetEnemySpawnTime();
enemySpawnTick = 0;

spawnEnemy = function() {
	if (instance_number(Enemy) > MAX_ENEMIES_ON_SCREEN || Player.busy) return;
	
	var range = 600;
	var minDistance = 300;
	var funnyValue = 500;
	
	var pos = vec2(
		irandom_range(Player.x - range, Player.x + range),
		irandom_range(Player.y - range, Player.y + range)
	);
	
	// If enemy is closer than 300 pixels to the player, recalculate position
	var con = (
		point_distance(Player.x, Player.y, pos.x, pos.y) < minDistance
	);
	
	if (con) {
		return false;
	}
	
	// Spawn enemy at random position
	var enemyObj = choose(Enemy, Enemy, Enemy, MilitaryNerd, Enemy, Enemy, MechaNerd);
	var enemy = instance_create_depth(pos.x, pos.y, depth, enemyObj);
	
	enemyCountIndex --;
	
	enemySpawnTick = 0;
	enemySpawnTime = (resetEnemySpawnTime()) - enemyCount / 5;
	
	return true;
}

restart = function() {
	
	player_reset();
	
	horde = 1;
	hordeCooldown = 0;
	newHorde = true;
	hordeEndCooldown = 120;
	hordeEnemyMultiplier = 1.10;
	
	instance_destroy(Enemy);
	instance_destroy(Drop);
	instance_destroy(Coin);
	instance_destroy(Particle);
	instance_destroy(EnemyProjectile);
	instance_destroy(Projectile);
	instance_destroy(Hitmarker);
	
}

restart();

storedCoins = 0;
