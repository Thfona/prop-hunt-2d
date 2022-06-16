time_to_shoot = 0;
can_shoot = false;

function shotting() {
	if (can_shoot)  {
		time_to_shoot--;		
		if (time_to_shoot <= 0) {
			time_to_shoot = firing_delay * room_speed;
			
			var _x = lengthdir_x(sprite_height, image_angle);
			var _y = lengthdir_y(sprite_width, image_angle);
			
			var _shot = instance_create_layer(x + _x, y + _y, layer, shot);
			_shot.speed = firing_speed;
			_shot.direction = image_angle;
		}
	}
}

function slowing_down() {
	if (speed > 0) {
		speed *= 0.9;
		if (speed <= 0.1 ) { speed = 0; } 
	}
}