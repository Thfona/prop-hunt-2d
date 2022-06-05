function received_packet(buffer){
	msg_id = buffer_read(buffer, buffer_u8);

	switch(msg_id) {
		case network.player_connect:
			create_player(buffer, "character");

			break;

		case network.player_joined:
			create_player(buffer, "shadow");

			break;

		case network.player_disconnect:
			var _socket = buffer_read(buffer, buffer_u8);
			var _player = ds_map_find_value(socket_to_instance_id, _socket);

			with(_player) {
				instance_destroy();
			}

			ds_map_delete(socket_to_instance_id, _socket);

			break;

		case network.move:
			var _socket = buffer_read(buffer, buffer_u8);
			var x_value = buffer_read(buffer, buffer_u16);
			var y_value = buffer_read(buffer, buffer_u16);
			
			var _player = ds_map_find_value(socket_to_instance_id, _socket);

			_player.x = x_value;
			_player.y = y_value;

			break;
	}
}
