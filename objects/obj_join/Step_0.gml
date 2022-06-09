if (!did_we_received_hosts && should_i_try_get_hosts) {
	should_i_try_get_hosts = false;
	alarm[0] = room_speed * 3;
	
	data = ds_map_create();
	ds_map_add(data, "hosts", noone);
	send_map_over_udp(global.IP, global.PORT, 100, data, msg_type.GET_HOSTS);
}  