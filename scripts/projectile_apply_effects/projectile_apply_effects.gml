function projectile_apply_effects(proj, arr) {
	with (proj) {
		for (var i = 0; i < array_length(arr); i++) {
			var e = arr[i];
			effect_add(e[0], e[1]);
		}
	}
}