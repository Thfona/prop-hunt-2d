/// @description Insert description here
// You can write your code in this editor

draw_self();

function write_the_characters_name() {
	var _x = x - (sprite_width / 2);
	var _y = y - ((sprite_height / 2) + 13);

	draw_text(_x, _y, "player " + string(instance_player._id));
}

function field_of_vision() {
	draw_set_colour(c_yellow);
	draw_circle(x, y, 100, true);
}

if (global.debug) {
	field_of_vision();
}

function change_skin(sprite, variant) {
	draw_sprite_ext(sprite, variant, x, y, image_xscale, 1, 0, c_white, 1);
}

change_skin(spr_hats, instance_player.skin.hat);
change_skin(spr_faces, instance_player.skin.face);
change_skin(spr_glasses, instance_player.skin.glasses);

write_the_characters_name();

// TODO: Codigo para teste de troca de SKIN, apagar futuramente;
if (keyboard_check_pressed(ord("I"))) {
	instance_player.skin.hat++;
}

if (keyboard_check_pressed(ord("O"))) {
	instance_player.skin.face++;
}

if (keyboard_check_pressed(ord("P"))) {
	instance_player.skin.glasses++;
}