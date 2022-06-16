// VARIABLES
is_this_our_player = true;

instance_player = {
	_id: 0,
	pickup_radius: 50,
	key: {
		up: -1,
		down: -1, 
		left: -1,
		right: -1,
		shot: -1,
		discart: -1,
		pickup: -1
	},
	skin: {
		glasses: 0,
		face: 0,
		hat: 0
	},
	equipment: {
		gun: noone
	}
}

h_character_speed = 0;
v_character_speed = 0;

xscale = 1;
spr_index = 0;

CHARACTER = {
	walk_speed: 4
}

MUTABLE_OBJECTS = [obj_can_of_soda, obj_table];

global.mutable_objects = [];
