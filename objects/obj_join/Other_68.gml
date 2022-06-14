if (async_load[? "size"] > 0) {
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var message_id = buffer_read(buffer, buffer_string);
	
	response = json_decode(message_id);
	
	if (ds_map_find_value(response, "type") == msg_type.GET_HOSTS) {	
		if (global.debug) {
			show_debug_message("< " + message_id);
		}
		var hosts = ds_map_find_value(response, "hosts");
		number_of_hosts = ds_list_size(hosts);
		
		for (var i = 0; i < number_of_hosts; ++i) {
		    host = ds_list_find_value(hosts, i);
			number_of_players = ds_list_size(host);
			
			host_item = instance_create_layer(10, 64 + (i * 64) + (i * 10), "Instances", obj_item_host);
			host_item.local_host_number = i;
			host_item.local_number_of_player = number_of_players;
			did_we_received_hosts = true;
		}
	}	
} 