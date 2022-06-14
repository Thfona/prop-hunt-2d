if (should_i_try_to_check_new_player) {
	should_i_try_to_check_new_player = false;
	
	alarm[0] = room_speed * 3;
	
	data = ds_map_create();
	ds_map_add(data, "host", global.host);
	ds_map_add(data, "players", noone);
		
	if (global.debug) {
		show_debug_message("RECUPERANDO TODOS OS PLAYERS");
	}

	send_map_over_udp(global.IP, global.PORT, 200, data, msg_type.GET_NEW_PLAYERS);	
}