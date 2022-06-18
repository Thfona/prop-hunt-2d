function weapon() {
	time_to_shoot--;
	if (recoil_pressure > 0) { recoil_pressure--; }
	if (is_being_carried && is_shooting)  {
		shoot();
		weapon_recoil();
	}
	slowing_down();
}

function shoot() {
	if (time_to_shoot <= 0) {
		recoil_pressure = recoil;
		time_to_shoot = firing_delay * room_speed;
			
		if (ammunition) {
			var _x = lengthdir_x(sprite_height, image_angle);
			var _y = lengthdir_y(sprite_width, image_angle);
			var _shot = instance_create_layer(x + _x, y + _y, layer, shot);

			_shot.speed = firing_speed;
			_shot.direction = image_angle + random_range(-precision, precision);
			
			ammunition--;
		}
	}
}

function weapon_recoil() {
	x -= lengthdir_x(recoil_pressure, image_angle);
	y -= lengthdir_y(recoil_pressure, image_angle);
}

function reflect(collision_objects) {
	var len = array_length(collision_objects);
	
	for (var i = 0; i < len; ++i) {
	    if (place_meeting(x + hspeed, y, collision_objects[i])) {
			hspeed *= -1;
		}
		
		if (place_meeting(x, y + vspeed, collision_objects[i])) {
			vspeed *= -1;
		}
	}
}

function slowing_down() {
	if (speed > 0) {
		reflect(global.COLLISION_OBJECTS.character);
		speed *= 0.9;
		if (speed <= 0.1 ) { speed = 0; } 
	}
}