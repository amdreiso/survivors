
hordeCooldown = max(0, hordeCooldown - GameSpeed);
hasEnemies = (instance_number(Enemy) > 0);

if (newHorde && hordeCooldown <= 0) {
	newHorde = false;
}

enemySpawnTick += GameSpeed;

if (enemySpawnTick >= enemySpawnTime && enemyCountIndex > 0) {
	var amount = 1;
	amount = irandom_range(1, enemyCountIndex div (enemyCountDefault / 4));
	
	repeat(amount) spawnEnemy();
}

show_debug_message(enemyCountIndex div (enemyCountDefault/2));

if (hasEnemies) {
	hordeEndCooldown = 120;
} else {
	hordeEndCooldown -= GameSpeed;
}

if (enemyCountIndex <= 0 && !hasEnemies && hordeEndCooldown <= 0) {
	enemyCount = floor(enemyCount * (horde * hordeEnemyMultiplier));
	
	enemyCountIndex = enemyCount;
	hordeComplete();
	
	if (horde > 2) player_add_level();
}
