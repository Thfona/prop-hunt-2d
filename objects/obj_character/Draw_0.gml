/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_text(x, y,"player " + string(player_number));

function field_of_vision() {
	draw_set_colour(c_yellow);
	draw_circle(x, y, 100, true);
}

if (global.debug) {
	field_of_vision();
}
