function get_keymap(){
	var map = {
		
		player: {
			up: (keyboard_check(ord("W")) || keyboard_check(vk_up)),
			left: (keyboard_check(ord("A")) || keyboard_check(vk_left)),
			down: (keyboard_check(ord("S")) || keyboard_check(vk_down)),
			right: (keyboard_check(ord("D")) || keyboard_check(vk_right)),
			
			dash: (keyboard_check(vk_space)),
			run: (keyboard_check(vk_shift)),
			jump: (keyboard_check(vk_control)),
			
			interact: (keyboard_check_pressed(ord("E"))),
			switchWeapons: (keyboard_check_pressed(vk_tab)),
		}
		
	}
	
	return map;
}