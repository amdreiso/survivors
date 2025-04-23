function granade_throw(obj){
	with (obj) {
		var nade = instance_create_depth(x, y, depth, Granade);
		var angle = point_direction(x, y, mouse_x, mouse_y);
		var force = 10;
	
		nade.force.x = lengthdir_x(force, angle);
		nade.force.y = lengthdir_y(force, angle);
	}
}