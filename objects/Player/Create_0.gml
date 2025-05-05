

busy = false;


// Character stuff
characterID = 0;

setCharacter = function(val) {
	if (!ds_map_exists(CharacterData, val)) return;
	
	var character = character_get(val);
	
	characterID = val;
	struct_merge(self, character.components);
	
	setHand(0, character.components.weaponID);
}

special = false;
specialCooldown = 0;
killCount = 0;


// Movement
canMove												= true;
isMoving											= false;
defaultSpd										= 1.23;
spd														= defaultSpd;
spdMultiplier									= 1.0;
hsp														= 0;
vsp														= 0;
force													= vec2();
dash													= false;
dashForce											= 7;
dashCooldown									= 0;
isJumping											= false;
jumpCooldown									= 0;
onGround											= false;
staminaMax										= 100;
stamina												= 100;
staminaMultiplier							= 1.0;
staminaRechargeCooldown				= 0;
runMultiplier									= 1.5;
reachMultiplier								= 1.5;

enemyClosest = -1;
enemyInRange = 0;


runLogic = function() {
	var map	= Keymap.player;
	
	if (map.run) {
		
		if (stamina <= 0) return;
		
		stamina -= GameSpeed / 2;
		spd = (defaultSpd * runMultiplier) * spdMultiplier;
		staminaRechargeCooldown = 2 * 60;
		
	} else {
		
		if (staminaRechargeCooldown > 0) return;
		if (stamina >= staminaMax) return;
		stamina += GameSpeed * 2;
		
	}
}

handleMovement = function() {
	if (busy) return;
	
	isMoving = (hsp != 0 || vsp != 0);
	
	var map	= Keymap.player;
	
	var right		= map.right;
	var left		= map.left;
	var up			= map.up;
	var down		= map.down;
	
	spd = defaultSpd * spdMultiplier;
	
	// Run
	staminaRechargeCooldown = max(0, staminaRechargeCooldown - GameSpeed);
	
	//runLogic();
	
	force.x = lerp(force.x, 0, 0.1) * GameSpeed;
	force.y = lerp(force.y, 0, 0.1) * GameSpeed;
	
	var dir = point_direction(0, 0, right - left, down - up);
	var len = (right - left != 0) || (down - up != 0);
	
	hsp = lengthdir_x(spd * len, dir);
	vsp = lengthdir_y(spd * len, dir);
	
	if (canMove) {
		x += (hsp + force.x) * GameSpeed;
		y += (vsp + force.y) * GameSpeed;
	}
	
	
	// Jump
	if (jumpCooldown > 0) {
		jumpCooldown -= GameSpeed; 
	} else {
		isJumping = false;
		jumpCooldown = 0;
	}
	
	if (map.jump && !isJumping) {
		jumpCooldown = 2 * 60;
		isJumping = true;
	}
}


// Defense
armor = 1.00;


// Items
items = [];
itemMax = 5;

loadItems = function() {
	var len = array_length(items);
	
	player_reset();
	
	for (var i = 0; i < len; i++) {
		var item = item_get(items[i].itemID);
		item.load(self);
	}
}

updateItems = function() {
	var len = array_length(items);
	
	for (var i = 0; i < len; i++) {
		var item = item_get(items[i].itemID);
		item.update(self);
	}
}

clearItems = function() {
	items = [];
}

addItem = function(itemID) {
	if (array_length(items) >= itemMax) return;
	
	var newItem = {
		itemID: itemID,
	};
	
	array_push(
		items,
		newItem
	);
	
	loadItems();
}

drawItemIcons = function() {
	if (Paused) return;
	
	var len = array_length(items);
	
	for (var i = 0; i < len; i++) {
		var item = item_get(items[i].itemID);
		var sprite = item.sprite;
		
		
		if (sprite != -1) {
			var scale = 1;
			var padding = 1.5;
			var xx = display_get_gui_width() - sprite_get_width(sprite) / padding;
			var yy = sprite_get_height(sprite) / padding + i * sprite_get_height(sprite) * 1.25 * scale;
			
			desc = item.description;
			
			draw_sprite_ext(sprite, 0, xx, yy, scale, scale, 0, c_white, 1);
			
			button_gui(xx, yy, sprite_get_width(sprite), sprite_get_height(sprite), "", -1, false, 0, 0, 0, 0, function(){
				
				draw_set_halign(fa_right);
				draw_set_valign(fa_bottom);
				
				var xOffset = 30;
				var scale = 1;
				var c = c_white;
				var c0 = c_black;
				
				var str = desc;
				
				draw_text_ext_transformed_color(window_mouse_get_x()-scale-xOffset, window_mouse_get_y()-scale, str, 14, 200, scale, scale, 0, c0, c0, c0, c0, 1);
				draw_text_ext_transformed_color(window_mouse_get_x()-xOffset, window_mouse_get_y(), str, 14, 200, scale, scale, 0, c, c, c, c, 1);
				
			}, BUTTON_ORIGIN.MiddleCenter);
		}
	}
}


// Consumables
consumables = [];
consumablesMax = 4;

repeat (consumablesMax) {
	array_push(consumables, {
		consumableID: -1,
	});
}

useConsumable = function(val) {
	if (busy) return;
	
	var consumableID = consumables[val].consumableID;
	if (consumableID == -1) return;
	
	var c = consumable_get(consumableID);
	
	c.load(self);
	consumables[val].consumableID = -1;
	
	var color = character_get(Player.characterID).components.color;
	hitmarker_create($"used {c.name}", color, false, 10, 0.25, "");
}

addConsumable = function(val) {
	for (var i = 0; i < array_length(consumables); i++) {
		if (consumables[i].consumableID == -1) {
			consumables[i].consumableID = val;
			return true;
		}
	}
	
	return false;
}


consumablesLogic = function() {
	
	if (keyboard_check_pressed(ord("1"))) useConsumable(0);
	if (keyboard_check_pressed(ord("2"))) useConsumable(1);
	if (keyboard_check_pressed(ord("3"))) useConsumable(2);
	if (keyboard_check_pressed(ord("4"))) useConsumable(3);
	
}

drawConsumables = function() {
	if (Paused) return;
	
	var len = array_length(consumables);
	var spriteGUI = sSlotIcon;
	
	for (var i = 0; i < len; i++) {
		
		var padding = 1.1;
		var scale = Settings.graphics.guiScale;
		
		var size = sprite_get_width(spriteGUI) * scale;
		var margin = (size div 2) + Style.marginGUI;
		
		var xx = margin + i * (size * padding);
		var yy = HEIGHT - margin;
		
		draw_sprite_ext(spriteGUI, 0, xx, yy, scale, scale, 0, c_white, 1);
		text(xx, yy, string(i+1), scale / 2, scale / 2);
		
		var consumableID = consumables[i].consumableID;
		if (consumableID != -1) {
			var c = consumable_get(consumableID);
			if (c.sprite != -1) {
				draw_sprite_ext(c.sprite, 0, xx, yy, scale, scale, 0, c_white, 1);
			}
		}
	}
	
}


// Weapons
hands = [
	{
		weaponID: eWeaponID.Pistol,
		weaponUpgrade: 0,
	},
	{
		weaponID: eWeaponID.Minigun,
		weaponUpgrade: 0,
	},
];

addHand = function(weaponID = -1, weaponUpgrade = 0) {
	var hand = {};
	hand.weaponID = weaponID;
	hand.weaponUpgrade = weaponUpgrade;
	
	array_push(
		hands, hand
	);
}

handIndex = 0;

setHand = function(index, weaponID, weaponUpgrade = 0) {
	hands[index].weaponID = weaponID;
	hands[index].weaponUpgrade = weaponUpgrade;
}

getHand = function(val = -1) {
	if (val == -1)
		return hands[handIndex];
	
	return hands[val];
}

weaponRecoil = 0;
weaponAngle = 0;
weaponXscale = 1;
weaponYscale = 1;

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

// Upgrade weapon's level
upgradeWeapon = function() {
	var w = getHand();
	var weapon = weapon_get(w.weaponID);
	var cost = weapon[w.weaponUpgrade + 1].cost;
	
	if (coins >= cost) {
		coins -= cost;
		w.weaponUpgrade ++;
	}
}

// Weapons unique update code
weaponCodeUpdate = function() {
	var w = getHand();
	if (w.weaponID == -1 || busy) return;
	
	var weapon = WeaponData[? w.weaponID][w.weaponUpgrade];
	weapon.update(self);
}

// Weapons unique draw code
weaponCodeDraw = function() {
	var w = getHand();
	if (w.weaponID == -1 || busy) return;
	
	var weapon = WeaponData[? w.weaponID][w.weaponUpgrade];
	weapon.draw(self);
}

// Draw the weapon interface
drawWeaponGUI = function() {
	if (Paused) return;
	
	var weapon = weapon_get(getHand().weaponID);
	
	var spriteGUI = sSlotIcon2;
	var scale = Settings.graphics.guiScale;
	
	var width = sprite_get_width(spriteGUI) * scale;
	var height = sprite_get_height(spriteGUI) * scale;
	
	var drawSprite = sDefault;
	
	var marginW = (width / 2) + Style.marginGUI;
	var marginH = (height / 2) + Style.marginGUI;
	
	var xx = display_get_gui_width() - marginW;
	var yy = display_get_gui_height() - marginH;
	
	draw_sprite_ext(spriteGUI, 0, xx, yy, scale, scale, 0, c_white, 1);
	
	if (getHand().weaponID == -1) return;
	
	var sprite = weapon[getHand().weaponUpgrade].components.spriteGUI;
	
	if (sprite != -1) {
		drawSprite = sprite;
	}
	
	//draw_sprite_ext(sSlotIcon2, 0, xx - width * offset, yy - height * offset, scale, scale, 0, c_white, 1);
	
	//draw_outline(drawSprite, xx, yy, scale, c_black, scale);
	
	draw_sprite_ext(drawSprite, 0, xx, yy, scale, scale, 0, c_white, 1);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	
	var c0 = c_white;
	var ts = 1.50;
	//draw_text_ext_transformed_color(xx - width * offset, yy - height - 60, weapon[getHand().weaponUpgrade].name, 12 * ts, 100, ts, ts, 0, c0, c0, c0, c0, 1);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
}


// Unique weapon variables
singularitySplitterShotCount = 0;

minigunCooldown = 0;
minigunOverheat = 0;
minigunOverheated = false;


// Health
hpMax = 100;
hp = hpMax;
isHit = false;
hitCooldown = 0;
isDead = false;
showHitmarker = true;

showHealthbar = 0;

resetHealth = function() {
	hp = maxHp;
	isDead = false;
	hitCooldown = 0;
	isHit = false;
}

checkDead = function() {
	if (hp <= 0) {
		isDead = true;
	}
}

handleHealth = function() {
	if (hitCooldown > 0) {
		hitCooldown -= GameSpeed;
	} else {
		hitCooldown = 0;
		isHit = false;
	}
}

hit = function(damage, e, shake = 4) {
	if (isHit) return;
	
	var d = floor(damage * armor);
	
	hp -= d;
	camera_shake(shake);
	
	hitCooldown = 20;
	isHit = true;
	
	// Knockback
	var dir = point_direction(x, y, e.x, e.y);
	var knockback = 0;
	
	if (e != -1) knockback = e.knockback;
	
	force.x -= lengthdir_x(knockback, dir);
	force.y -= lengthdir_y(knockback, dir);
	
	screen_flash_set(0.6, c_gray, 0.1);
	
	showHealthbar = HEALTHBAR_TIME;
	
	hitmarker_create(d, character_get(characterID).components.color);
	
	checkDead();
}

deadMenuAlpha = 0;

drawDeadMenu = function() {
	if (!isDead) {
		deadMenuAlpha = lerp(deadMenuAlpha, 0, 0.1);
		return;
	}
	
	deadMenuAlpha = lerp(deadMenuAlpha, 1, 0.1);
	
	var alpha = deadMenuAlpha;
	
	// Draw transparent black background
	var w = window_get_width(), h = window_get_height();
	var c0 = c_black;
	
	draw_set_alpha(0.5 * alpha);
	draw_rectangle_color(0, 0, window_get_width(), window_get_height(), c0, c0, c0, c0, false);
	draw_set_alpha(1);
	
	var titleScale = 3;
	text(w / 2, 200, "You Died!", titleScale, titleScale, 0, c_white, alpha);
	
	var buttonMargin = 200;
	
	button_gui((w / 2) - buttonMargin, h / 2, 100, 64, "Retry", -1, true, Style.outlineColor, c_white, 0.1, alpha, function(){
		
		if (mouse_check_button_pressed(mb_left)) {
			Level.restart();
		}
		
	}, BUTTON_ORIGIN.MiddleCenter);
	
	button_gui((w / 2) + buttonMargin, h / 2, 100, 64, "bac", -1, true, Style.outlineColor, c_white, 0.1, alpha, function(){
		
		if (mouse_check_button_pressed(mb_left)) {
			room_goto(rmCharacterSelection);
		}
		
	}, BUTTON_ORIGIN.MiddleCenter);
	
}


// Effects
effects = [];



// Draw
color = c_white;

drawWeapon = function() {
	var w = getHand();
	
	if (getHand().weaponID == -1) return;
	
	var weapon = WeaponData[? getHand().weaponID][getHand().weaponUpgrade];
	var sprite = weapon.components.sprite;
	
	if (sprite == -1) return;
	
	var dir = point_direction(x, y, mouse_x, mouse_y);
	
	if (enemyClosest != -1 && enemyInRange) {
		
		var enemy = enemyClosest;
		dir = point_direction(x, y, enemy.x, enemy.y - sprite_get_height(enemy.sprite_index) / 2);
		
		weaponAngle = dir;
		weaponXscale = 1;
		
		if (enemy.x < x) weaponYscale = -1; else weaponYscale = 1;
		
	}
	
	weaponRecoil = lerp(weaponRecoil, 0, 0.1);
	
	var xx = x - lengthdir_x(weaponRecoil, weaponAngle);
	var yy = (y - sprite_get_height(sprite_index) / 2) - lengthdir_y(weaponRecoil, weaponAngle);
	
	surface_set_target(SurfaceHandler.surface);
	draw_sprite_ext(sprite, 0, xx, yy, weaponXscale, weaponYscale, weaponAngle, c_white, 1);
	surface_reset_target();
}

drawPlayer = true;

draw = function() {
	var character = character_get(characterID);
	var sprite = character.sprite.idle;
	
	if (hsp != 0) image_xscale = sign(hsp);
	
	if (isMoving) {
		sprite = character.sprite.move;
	}
	
	image_speed = 1;
	image_blend = color;
	sprite_index = sprite;
	
	if (drawPlayer) {
		surface_set_target(SurfaceHandler.surface);
		draw_clear_alpha(c_white, 0);
		draw_self();
		surface_reset_target();
	}
	
	//drawWeapon();
}



// Camera
with (instance_create_depth(x, y, depth, Camera)) {
	self.target = other;
}



// Gameplay
xp = 0;
xpNextLevel = 100;
xpNextLevelMultiplier = 1.18;
level = 0;
levelPrompt = false;
coins = 0;
coinMagnetRange = 20;
coinMagnetMultiplier = 1.0;

levelPromptWeapons = [];
levelPromptWeaponAmount = 2;

levelPromptSetWeapons = function(){
	var val = irandom(ds_map_size(WeaponData) - 1);
	var weapon = weapon_get(val);
	
	// Determine quantity of weapons to prompt
	if (array_length(levelPromptWeapons) == levelPromptWeaponAmount) return;
	
	// recursion if weaponID already exists in the array
	//if (array_contains(levelPromptWeapons, val)) {
	//	levelPromptSetWeapons();
	//	return;
	//}
	
	// Push NON UNIQUE weapons
	if (!weapon[0].components.isUnique)
		array_push(levelPromptWeapons, val);
	
	levelPromptSetWeapons();
};

drawLevelPrompt = function() {
	if (!levelPrompt) return;
	
	var xx = window_get_width() / 2;
	var yy = window_get_height() / 2;
	
	var ww = 1000;
	var hh = 700;
	
	var textColor = Style.textColor;
	
	//draw_sprite_ext(sPromptWindow, 0, xx, yy, windowScale, windowScale, 0, c_white, 1);
	
	rect(xx, yy, ww, hh, Style.backgroundColor);
	rect(xx, yy, ww, hh, Style.outlineColor, true);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed_color(xx, yy - 300, "YOU JUST LEVELED UP!", 3, 3, 0, textColor, textColor, textColor, textColor, 1);
	draw_text_transformed_color(xx, yy - 250, "choose a new second weapon!", 2, 2, 0, textColor, textColor, textColor, textColor, 1);
	
	var len = array_length(levelPromptWeapons);
	
	// Select random weapon
	for (var i = 0; i < len; i++) {
		var buttonX, buttonY, buttonWidth, buttonHeight, buttonPadding;
		buttonWidth = 110;
		buttonHeight = 110;
		buttonPadding = 1.1;
		
		var width = (buttonWidth * buttonPadding);
		
		buttonX = ((xx + buttonWidth / 2) - (len / 2) * width) + i * (width);
		buttonY = yy - 100;
		
		promptWeaponID = levelPromptWeapons[i];
		
		var weapon = WeaponData[? promptWeaponID][0];
		var scale = 5;
		var sprite = weapon.components.sprite;
		
		if (sprite != -1) {
			draw_sprite_ext(sprite, 0, buttonX, buttonY, scale, scale, 0, c_white, 1);
		}
		
		button_gui(
			buttonX, buttonY, buttonWidth, buttonHeight, "", -1, true, Style.outlineColor, c_white, 0.10, 1, function(){
				
				if (mouse_check_button_pressed(mb_left)) {
					setHand(1, promptWeaponID);
					
					levelPrompt = false;
				}
				
			}, BUTTON_ORIGIN.MiddleCenter
		);
	}
	
	// Upgrade second weapon
	for (var j = 0; j < 2; j++) {
		var hand = getHand(j);
		var buttonWidth2 = 300;
		var buttonHeight2 = 65;
		
		ii = j;
		
		if (hand.weaponID != -1) {
		
			maxUpgrade = (hand.weaponUpgrade >= array_length(weapon_get(hand.weaponID)) - 1);
			
			var str = "Upgrade your first weapon!";
			if (j == 1) str = "Upgrade your second weapon!";
			
			if (maxUpgrade) str = "Weapon at max. upgrade";
			
			button_gui(
				xx, buttonY + 150 + j * buttonHeight2, buttonWidth2, buttonHeight2, str, -1, true, Style.outlineColor, c_white, 0.10, 1, function(){
					if (mouse_check_button_pressed(mb_left) && !maxUpgrade) {
						
						getHand(ii).weaponUpgrade ++;
						levelPrompt = false;
						
					}
				
				}, BUTTON_ORIGIN.MiddleCenter
			);
		
		}
	}
}

tick = 0;


addConsumable(eConsumableID.Granade);

