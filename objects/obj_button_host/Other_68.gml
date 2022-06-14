if (async_load[? "size"] > 0) {
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var message_id = buffer_read(buffer, buffer_string);
	
	response = json_decode(message_id);
	
	if (ds_map_find_value(response, "type") == msg_type.CREATE_HOST) {
		if (global.debug) {
			show_debug_message("button_host <-- " + string(message_id));
		}

		var host = ds_map_find_value(response, "host");			
		var _id = ds_map_find_value(response, "_id");
		
		if (global.debug) {
			show_debug_message("O server " + string(host) + " foi criado! " + " O numero do seu jogador é " + string(_id));
		}

		global.host = host;
		global._id = _id;
		
		room_goto(rm_map1);
	}
}