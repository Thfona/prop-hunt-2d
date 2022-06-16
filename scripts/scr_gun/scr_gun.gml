function shotting() {
	if (is_being_carried && is_shooting)  {
		time_to_shoot--;
		if (time_to_shoot <= 0) {
			time_to_shoot = firing_delay * room_speed;
			
			var _x = lengthdir_x(sprite_height, image_angle);
			var _y = lengthdir_y(sprite_width, image_angle);
			
			var _shot = instance_create_layer(x + _x, y + _y, layer, shot);
			_shot.speed = firing_speed;
			_shot.direction = image_angle;
			
			knockback()
		}
	}
}

function knockback () {
	if (target) {
		target.h_character_speed = 10;
		target.v_character_speed = 0;
	}
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