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

function change_skin(sprite, variant) {
	draw_sprite_ext(sprite, variant, x, y, image_xscale, 1, 0, c_white, 1);
}

change_skin(spr_hats, skin.hat);
change_skin(spr_faces, skin.face);
change_skin(spr_glasses, skin.glasses);

// TODO: Codigo para teste de troca de SKIN, apagar futuramente;
if (keyboard_check_pressed(ord("I"))) {
	skin.hat++;
}

if (keyboard_check_pressed(ord("O"))) {
	skin.face++;
}

if (keyboard_check_pressed(ord("P"))) {
	skin.glasses++;
}