// VARIABLES
up = -1;
down = -1;
left = -1;
right = -1;

h_character_speed = 0;
v_character_speed = 0;

xscale = 1;
spr_index = 0;

CHARACTER_SPEED = 4;
COLLISION_OBJECTS = {
	character: [obj_wall, obj_can_of_soda, obj_table],
	mutated: [obj_wall]
};
MUTABLE_OBJECTS = [obj_can_of_soda, obj_table];

// DEV
global.debug = 0;
