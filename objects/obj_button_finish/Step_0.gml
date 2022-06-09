
if (should_host_stop && !is_host_stopped) {
	should_host_stop = false;
	data = ds_map_create();
	ds_map_add(data, "host_number", global.host_number);
	ds_map_add(data, "res", noone);
	send_map_over_udp(global.IP, global.PORT, 100, data, msg_type.STOP_HOST);
	
	alarm[0] = room_speed * 2;
}

