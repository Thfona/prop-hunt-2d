function create_player(buffer, type){
	var _socket = buffer_read(buffer, buffer_u8);
	var x_value = buffer_read(buffer, buffer_u16);
	var y_value = buffer_read(buffer, buffer_u16);

	var player_object = type == "character" ? obj_character : obj_shadow;

	var layer_id = layer_get_id("Foreground_Instances");

	var _player = instance_create_layer(x_value, y_value, layer_id, player_object);
	_player.socket = _socket;

	ds_map_add(socket_to_instance_id, _socket, _player);
}
