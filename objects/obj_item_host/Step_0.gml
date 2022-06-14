if (should_i_try_to_join && !did_we_joined) {
	should_i_try_to_join = false;
	alarm[0] = 2 * room_speed;
	
	data = ds_map_create();
	ds_map_add(data, "host", local_host_number);
	ds_map_add(data, "_id", noone);
	send_map_over_udp(global.IP, global.PORT, 100, data, msg_type.JOIN_HOST);
}