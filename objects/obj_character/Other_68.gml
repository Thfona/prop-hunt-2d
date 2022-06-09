if (async_load[? "size"] > 0) {
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var message_id = buffer_read(buffer, buffer_string);
	response = json_decode(message_id);
	
	if (ds_map_find_value(response, "type") == msg_type.GET_PLAYER_STAT) {
		show_debug_message("charactert <-- " + string(message_id));		
		
		var player_stat = ds_map_find_value(response, "player_stat");
		var pn = ds_map_find_value(player_stat, "player_number");
		
		if (pn == player_number) {
			up = ds_map_find_value(player_stat, "up");
			down = ds_map_find_value(player_stat, "down");
			left = ds_map_find_value(player_stat, "left");
			right = ds_map_find_value(player_stat, "right");
			x = ds_map_find_value(player_stat, "x");
			y = ds_map_find_value(player_stat, "y");
		}
	}
}