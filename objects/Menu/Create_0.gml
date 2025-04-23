
enum MENU_PAGE {
	Home,
	LevelSelector
}

menuPage = MENU_PAGE.Home;


draw = function() {
	
	
	switch ( menuPage ) {
		case MENU_PAGE.Home:
			
			draw_text(25, 25, GameInfo.name);
			
			break;
	}
	
}

