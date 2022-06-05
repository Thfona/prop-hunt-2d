/// @description Character - Step

#region // STATES

mutation_state = spr_index == 0;
collision_object_state = mutation_state ? COLLISION_OBJECTS.character : COLLISION_OBJECTS.mutated;
mutable_objects_state = 0;

#endregion

#region // MOVEMENTS
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));

h_character_speed = (right - left) * CHARACTER_SPEED;
v_character_speed = (down - up) * CHARACTER_SPEED;
#endregion

#region // COLLISION
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

collision_object_detector("x", collision_object_state);
collision_object_detector("y", collision_object_state);

x += h_character_speed;
y += v_character_speed;
#endregion

#region // ANIMATION

if (h_character_speed != 0) {
	xscale = sign(h_character_speed);
}

image_xscale = xscale;

#endregion

#region // MUTATION

function mutate_character(spr_i) {
	spr_index = spr_i;
	sprite_index = mutable_objects[spr_i];
}

function are_there_items_nearby() {
	return true;
}

function change_item() {
	show_message(string(global.mutable_objects));
	//return spr_index == 0 ? 1 : 0;
	return 0;
}

function mutation() {
	if (are_there_items_nearby()) {
		var item = change_item();
		mutate_character(item);
	}
}

mutable_objects = [spr_character, spr_can_of_soda, spr_table];

if keyboard_check_pressed(vk_space) {
	mutation();
}

#endregion

#region //RADAR

function save_detected_object(arr) {
	//var len = array_length(arr);
	//for (var i = 0; i < len; ++i) {
	//	mutable_objects_state[i] = arr[i];
	//}
	
	//array_resize(mutable_objects_state, len);
	
	global.mutable_objects = arr;
}

function mutable_object_detector() {
	var mutable_objects_detected = [];

	for (var i = 0; i < array_length(MUTABLE_OBJECTS); ++i) {
	     var find = collision_circle(x, y, 100, MUTABLE_OBJECTS[i], 0, 1);
		 if (find) {
			 array_push(mutable_objects_detected, MUTABLE_OBJECTS[i]);
	    }
	}
	
	save_detected_object(mutable_objects_detected);
}

mutable_object_detector();

#endregion

if keyboard_check_pressed(vk_tab) {
	global.debug = !global.debug;
}
