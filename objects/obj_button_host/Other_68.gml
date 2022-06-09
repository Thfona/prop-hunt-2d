if (async_load[? "size"] > 0) {
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var message_id = buffer_read(buffer, buffer_string);
	
	response = json_decode(message_id);
	
	if (ds_map_find_value(response, "type") == msg_type.CREATE_HOST) {
		show_debug_message("button_host <-- " + string(message_id));
		var host_number = ds_map_find_value(response, "host_number");			
		var player_number = ds_map_find_value(response, "player_number");
		show_debug_message("O server " + string(host_number) + " foi criado! " + " O numero do seu jogador é " + string(player_number));
		
		global.host_number = host_number;
		global.player_number = player_number;
		
		room_goto(rm_map1);
	}
}