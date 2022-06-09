#region // STATES

mutation_state = spr_index == 0;
collision_object_state = mutation_state ? COLLISION_OBJECTS.character : COLLISION_OBJECTS.mutated;

#endregion

#region // START FN
if (is_this_our_player) {
	input_check();
	set_player_states();
	player_number = global.player_number;
} else {
	get_player_states();	
}

movements();

#endregion

#region // MOVEMENTS

if up || down || left || right {
	//send_information_to_the_server();
}

#endregion

#region // ANIMATION

if (h_character_speed != 0) {
	xscale = sign(h_character_speed);
}

image_xscale = xscale * (-1);

#endregion

#region // MUTATION

function mutate_character(spr_i) {
	spr_index = spr_i;
	sprite_index = mutable_objects[spr_i];
}

function are_there_items_nearby() {
	return array_length(global.mutable_objects) > 0;
}

function change_item() {
	show_debug_message(string(global.mutable_objects));
	return 0;
}

function mutation() {
	if (are_there_items_nearby()) {
		var item = change_item();
		mutate_character(item);
	} else {
		show_debug_message("Não tem ninguem: " + string(global.mutable_objects));	
	}
}

mutable_objects = [spr_character, spr_can_of_soda, spr_table];

if keyboard_check_pressed(vk_space) {
	mutation();
}

#endregion

#region //RADAR

function save_detected_object(arr) {
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

#region //NETWORK

function set_data() {
	var data = ds_map_create();
	var coordinate = { "x": x, "y": y };
	ds_map_add(data, "id", id);
	ds_map_add(data, "coordinate", coordinate);
	ds_map_add(data, "image_xscale", image_xscale);
	return data;
}

function send_information_to_the_server() {
	var data = set_data();
	show_debug_message("data" + string(data));
	send_map_over_udp(global.IP, global.PORT, 100, data, msg_type.SET_PLAYER_STAT);
}

#endregion

if keyboard_check_pressed(vk_tab) {
	global.debug = !global.debug;
}
