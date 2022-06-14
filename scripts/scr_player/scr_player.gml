// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function input_check() {
	instance_player.key.up = keyboard_check(ord("W"));
	instance_player.key.down = keyboard_check(ord("S"));
	instance_player.key.left = keyboard_check(ord("A"));
	instance_player.key.right = keyboard_check(ord("D"));	
}

function get_player_states() {
	data = ds_map_create();	
	
	ds_map_add(data, "host", global.host);
	ds_map_add(data, "_id", instance_player._id)
	ds_map_add(data, "player_stat", noone);
	
	if (global.debug) {
		show_debug_message("RECUPERANDO STATES DO PLAYER");
	}

	send_map_over_udp(global.IP, global.PORT, 100, data, msg_type.GET_PLAYER_STAT);
}

function set_player_states() {
	data = ds_map_create();
	
	data[? "coordinate"] = {
		x: x,
		y: y
	}
	
	data[? "key"] = {
		up: instance_player.key.up,
		down: instance_player.key.down,
		left: instance_player.key.left,
		right: instance_player.key.right,
	}
	
	data[? "skin"] = {
		hat: instance_player.skin.hat,
		glasses: instance_player.skin.glasses,
		face: instance_player.skin.face
	}
	
	ds_map_add(data, "host", global.host);
	ds_map_add(data, "_id", global._id);
	
	if (global.debug) {
		show_debug_message("ENVIANDO STATES DO PLAYER");
	}

	send_map_over_udp(global.IP, global.PORT, 1000, data, msg_type.SET_PLAYER_STAT);
}

function movements() {
	h_character_speed = (instance_player.key.right - instance_player.key.left) * CHARACTER.walk_speed;
	v_character_speed = (instance_player.key.down - instance_player.key.up) *  CHARACTER.walk_speed;
	
	collision_object_detector("x", collision_object_state); 
	collision_object_detector("y", collision_object_state);
 
	x += h_character_speed;
	y += v_character_speed; 
}

#region //COLLISION
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