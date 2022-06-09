if (async_load[? "size"] > 0) {
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var message_id = buffer_read(buffer, buffer_string);
	
	response = json_decode(message_id);
	
	if (ds_map_find_value(response, "type") == msg_type.STOP_HOST) {
		show_debug_message("< " + message_id);
		
		var res = ds_map_find_value(response, "res");
		
		if (res == "stoped") {
			is_host_stopped = true;
			room_goto(rm_menu);
		}
	}	
}