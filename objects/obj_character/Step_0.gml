/// @description Character - Step

up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));

function will_collide(axis, collision_obj) {
	return axis == "x"
		? place_meeting(x + hCharacterSpeed, y, collision_obj)
		: place_meeting(x, y + vCharacterSpeed, collision_obj);
}

function is_colliding(axis, collision_obj) {
	return axis == "x"
		? place_meeting(x + sign(hCharacterSpeed), y, collision_obj)
		: place_meeting(x, y + sign(vCharacterSpeed), collision_obj);
}

function detect_collision(axis, collision_obj) {
	if will_collide(axis, collision_obj) {
		while !is_colliding(axis, collision_obj) {
			if axis == "x" {
				x += sign(hCharacterSpeed);	
			} else {
				y += sign(vCharacterSpeed);
			}
		}

		if axis == "x" {
			hCharacterSpeed = 0;
		} else {
			vCharacterSpeed = 0;
		}
	}
}

hCharacterSpeed = (right - left) * characterSpeed;

detect_collision("x", obj_wall);

x += hCharacterSpeed;

vCharacterSpeed = (down - up) * characterSpeed;

detect_collision("y", obj_wall);

y += vCharacterSpeed;

