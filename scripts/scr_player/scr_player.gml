function input_check() {
	instance_player.key.up = keyboard_check(ord("W"));
	instance_player.key.down = keyboard_check(ord("S"));
	instance_player.key.left = keyboard_check(ord("A"));
	instance_player.key.right = keyboard_check(ord("D"));
	instance_player.key.discart = keyboard_check_released(ord("G"));
	instance_player.key.pickup = keyboard_check_released(ord("E"));
	instance_player.key.shot = mouse_check_button(mb_left);
}

#region //NETWORK
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
	
	data[? "coordinate"] = { x: x, y: y	};
	data[? "key"] = instance_player.key;
	data[? "skin"] = instance_player.skin;
	data[? "equipment"] = instance_player.equipment;
	
	ds_map_add(data, "host", global.host);
	ds_map_add(data, "_id", global._id);
	
	if (global.debug) {
		show_debug_message("ENVIANDO STATES DO PLAYER");
	}

	send_map_over_udp(global.IP, global.PORT, 1000, data, msg_type.SET_PLAYER_STAT);
}
#endregion

#region //MOVEMENT
function movements() {
	h_character_speed = (instance_player.key.right - instance_player.key.left) * CHARACTER.walk_speed;
	v_character_speed = (instance_player.key.down - instance_player.key.up) *  CHARACTER.walk_speed;
	
	collision_object_detector("x", collision_object_state); 
	collision_object_detector("y", collision_object_state);
 
	x += h_character_speed;
	y += v_character_speed;
}
#endregion

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

#region //WEAPON

function character_weapon() {
	if (instance_player.equipment.gun) {
		attack();
		weapon_follow_player();
		discard_weapon();
	}
	pickup_weapon();
}

function attack() {
	var _shooting = instance_player.key.shot;
	instance_player.equipment.gun.is_shooting = _shooting;
}

function weapon_follow_player() {
	var _direction = point_direction(x, y, mouse_x, mouse_y);
	var _x = x + lengthdir_x(sprite_height / 5, _direction);
	var _y = y + lengthdir_y((sprite_width) / 5, _direction);
		
	instance_player.equipment.gun.x = _x;
	instance_player.equipment.gun.y = _y + 15;
	instance_player.equipment.gun.image_angle = _direction;
}

function can_i_discard_weapon(collision_objects) {
	var has_objects_in_contact = false;
	
	with(instance_player.equipment.gun) {
		for (var i = 0; i < array_length(collision_objects); ++i) {
			var find = place_meeting(x + hspeed, y, collision_objects[i]);
			if (find) { has_objects_in_contact = true; }
		}
	}
		
	return !has_objects_in_contact;
}

function discard_weapon() {
	var can_discard = can_i_discard_weapon(global.COLLISION_OBJECTS.character);
	if (instance_player.key.discart && can_discard) {
		instance_player.equipment.gun.speed = 5;
		instance_player.equipment.gun.direction = instance_player.equipment.gun.image_angle;
		instance_player.equipment.gun.is_being_carried = noone;
		instance_player.equipment.gun.target = noone;
		instance_player.equipment.gun = noone;
	}
}

function pickup_weapon() {
	if (instance_player.key.pickup) {
		var pickup_list = ds_list_create();
		var pickup_count = collision_circle_list(x, y, instance_player.pickup_radius, obj_gun_default, false, true, pickup_list, true);
		
		if (pickup_count > 0) {
			if (instance_player.equipment.gun == noone) {
				instance_player.equipment.gun = pickup_list[| 0];
				
				instance_player.equipment.gun.target = instance_player._id;
				instance_player.equipment.gun.is_being_carried = true;
			} 
		}
		
		ds_list_destroy(pickup_list);
	}
}
#endregion