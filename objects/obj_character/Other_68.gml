if (async_load[? "size"] > 0) {
	var buffer = async_load[? "buffer"];
	buffer_seek(buffer, buffer_seek_start, 0);
	var message_id = buffer_read(buffer, buffer_string);
	response = json_decode(message_id);
	
	if (ds_map_find_value(response, "type") == msg_type.GET_PLAYER_STAT) {
		if (global.debug) {
			show_debug_message("charactert <-- " + string(message_id));		
		}

		var player_stat = ds_map_find_value(response, "player_stat");
		var pn = ds_map_find_value(player_stat, "_id");
		
		if (pn == instance_player._id) {
			var coordinate = ds_map_find_value(player_stat, "coordinate");
			var skin = ds_map_find_value(player_stat, "skin");
			var key = ds_map_find_value(player_stat, "key");
			
			instance_player.key.up = ds_map_find_value(key, "up");
			instance_player.key.down = ds_map_find_value(key, "down");
			instance_player.key.left = ds_map_find_value(key, "left");
			instance_player.key.right = ds_map_find_value(key, "right");
			instance_player.skin.hat = ds_map_find_value(skin, "hat");
			instance_player.skin.face = ds_map_find_value(skin, "face");
			instance_player.skin.glasses = ds_map_find_value(skin, "glasses");
			
			x = ds_map_find_value(coordinate, "x");
			y = ds_map_find_value(coordinate, "y");
		}
	}
}