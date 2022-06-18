#region // STATES

mutation_state = spr_index == 0;
collision_object_state = mutation_state
	? global.COLLISION_OBJECTS.character
	: global.COLLISION_OBJECTS.mutated;

#endregion

#region // START FN
if (is_this_our_player) {
	input_check();
	set_player_states();
	character_weapon();
	instance_player._id = global._id;
} else {
	get_player_states();	
}

movements();

#endregion

#region // ANIMATION

var has_horizontal_speed = h_character_speed != 0;
var has_vertical_speed = v_character_speed != 0;

if (has_horizontal_speed) {
	xscale = sign(h_character_speed);
}

if (has_horizontal_speed || has_vertical_speed) {
	sprite_index = spr_character_moviment;
} else {
	sprite_index = spr_character;
}

//image_xscale = xscale * (-1);

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

if keyboard_check_pressed(vk_tab) {
	global.debug = !global.debug;
}
