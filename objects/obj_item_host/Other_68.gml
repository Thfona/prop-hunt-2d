if (async_load[? "size"] > 0) {
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var message_id = buffer_read(buffer, buffer_string);
	
	response = json_decode(message_id);
	
	if (ds_map_find_value(response, "type") == msg_type.JOIN_HOST) {
		show_debug_message("< " + message_id);
		global.player_number = ds_map_find_value(response, "player_number");
		global.host_number = ds_map_find_value(response, "host_number");
		did_we_joined = true;
		
		room_goto(rm_map1);
	}
}