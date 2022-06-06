function follow() {
	character = obj_character;
	
	var x_intended = character.x;
	var y_intended = character.y - 50;
	var speed_intended =  global.CHARACTER_SPEED;
	
	var distance = point_distance(x, y, x_intended, y_intended);
		
	if distance > speed_intended {
		//show_debug_message(string(distance));
	    move_towards_point(x_intended, y_intended, speed_intended + (distance * .1));
	} else {
		speed = 0;
	}
}

follow();
