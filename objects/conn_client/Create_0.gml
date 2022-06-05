enum network {
	player_connect,
	player_joined,
	move
}

client = network_create_socket(network_socket_tcp);

network_connect(client, "127.0.0.1", 30000);

client_buffer = buffer_create(1024, buffer_fixed, 1);

socket_to_instance_id = ds_map_create();
