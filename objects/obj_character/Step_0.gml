/// @description Character - Step

#region // FUNCTIONS
function will_collide(axis, collision_obj) {
	return axis == "x"
		? place_meeting(x + h_character_speed, y, collision_obj)
		: place_meeting(x, y + v_character_speed, collision_obj);
}

function is_colliding(axis, collision_obj) {
	return axis == "x"
		? place_meeting(x + sign(h_character_speed), y, collision_obj)
		: place_meeting(x, y + sign(v_character_speed), collision_obj);
}

function detect_collision(axis, collision_obj) {
	if will_collide(axis, collision_obj) {
		while !is_colliding(axis, collision_obj) {
			if axis == "x" {
				x += sign(h_character_speed);	
			} else {
				y += sign(v_character_speed);
			}
		}

		if axis == "x" {
			h_character_speed = 0;
		} else {
			v_character_speed = 0;
		}
	}
}

function collision_object_detector(axis, collision_objects) {
	var len = array_length(collision_objects);
	var i = len - 1;
	repeat(len) {
	   detect_collision(axis, collision_objects[i]);
	   i -= 1;
	}
}
#endregion

#region // MAIN
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));

h_character_speed = (right - left) * CHARACTER_SPEED;

collision_objects = [obj_wall, obj_can_of_soda, obj_table];

collision_object_detector("x", collision_objects);

x += h_character_speed;

v_character_speed = (down - up) * CHARACTER_SPEED;

collision_object_detector("y", collision_objects);

y += v_character_speed;
#endregion

