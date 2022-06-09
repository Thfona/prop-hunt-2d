if (async_load[? "size"] > 0) {
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var message_id = buffer_read(buffer, buffer_string);
	
	response = json_decode(message_id);
	
	if (ds_map_find_value(response, "type") == msg_type.GET_NEW_PLAYERS) {
		show_debug_message("obj_level1  <-- " + string(message_id));
		var players = ds_map_find_value(response, "players");			
		
		number_oof_player_already_in_level = instance_number(obj_character);
		
		if (number_oof_player_already_in_level > 0) {
			for (var i = 0; i < number_oof_player_already_in_level; ++i) {
			    var ext_player = instance_find(obj_character, i);
				var number_of_players = ds_list_size(players);
				
				for (var j = 0; j < number_of_players; ++j) {
					var player = ds_list_find_value(players, j);
					var pn = ds_map_find_value(player, "player_number");
				   
					if (pn == ext_player.player_number) {
						ds_list_delete(players, j);
						number_of_players = ds_list_size(players);
					} 
				}
			}
		}
		
		var number_of_player_remain = ds_list_size(players);
		
		for (var i = 0; i < number_of_player_remain; ++i) {
		    var player = ds_list_find_value(players, i);
			var xx = ds_map_find_value(player, "x");
			var yy = ds_map_find_value(player, "y");
			new_player = instance_create_layer(xx, yy, "Instances", obj_character);
			new_player.is_this_our_player = false;
			new_player.player_number = ds_map_find_value(player, "player_number");
		}
	}	
}