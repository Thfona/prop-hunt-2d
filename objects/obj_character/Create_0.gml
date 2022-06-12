// VARIABLES
is_this_our_player = true;
player_number = 0;

up = -1;
down = -1;
left = -1;
right = -1;

skin = {
	glasses: 0,
	face: 0,
	hat: 0
}

h_character_speed = 0;
v_character_speed = 0;

xscale = 1;
spr_index = 0;

enum PLAYER_STATES {
	walk,
	run,
	idle,
	idle_shoot,
	run_shoot
}

CHARACTER = {
	walk_speed: 6
}

COLLISION_OBJECTS = {
	character: [obj_wall, obj_can_of_soda, obj_table],
	mutated: [obj_wall]
};
MUTABLE_OBJECTS = [obj_can_of_soda, obj_table];

global.mutable_objects = [];

// DEV
global.debug = 0;
