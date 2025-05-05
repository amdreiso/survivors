

// Init functions
randomize();
load_enums();
load_macros();
fovy();


// Game info
globalvar GameInfo;
GameInfo = {
	name: "jogo de matar em round",
	version: [0, 0],
	build: "indev",
	author: "company",
}


// Globals
globalvar Paused; Paused = false;
globalvar GameSpeed; GameSpeed = 1;

globalvar Settings; Settings = {
	graphics: {
		maxParticlesOnScreen: 200,
		cameraShakeIntensity: 1.0,
		guiScale: 2.0,
	},
	
	audio: {},
};

globalvar Keymap; Keymap = get_keymap();
globalvar ScreenFlash; ScreenFlash = {
	alpha: 0,
	color: c_white,
	time: 0.1,
};

globalvar Seed; Seed = irandom_range(2000, 2000000);
globalvar Style; Style = {
	backgroundColor: $ff080808,
	outlineColor: c_gray,
	iconColor: c_ltgray,
	iconColorSelected: $ff181818,
	rainbow: $ff,
	textColor: $fffcfcfc,
	marginGUI: 10,
};


rainbowTick = 0;
rainbowSpeed = 1;
rainbowSaturation = 220;
rainbowValue = 220;


// Data
weapon_data();
character_data();
effect_data();
item_data();
consumable_data();


// Init
char_init();
weapon_init();
effect_init();
item_init();
consumable_init();


// Gameplay
setCharacterID = -1;

setPlayerCharacter = function() {
	if (setCharacterID == -1) return;
	if (!instance_exists(Player)) return;
	
	Player.setCharacter(setCharacterID);
	setCharacterID = -1;
}







