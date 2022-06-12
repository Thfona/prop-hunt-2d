// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function send_map_over_udp(ip, port, size, map, type) {
	network_connect_raw(global.client, ip, port);
	var player_buffer = buffer_create(size, buffer_fixed, size);
	
	ds_map_add(map, "type", type)
	var dataJson = json_encode(map);

	show_debug_message("ENVIANDO PARA O SERVER --> " + dataJson);

	ds_map_destroy(map);

	buffer_seek(player_buffer, buffer_seek_start, 0);	
	buffer_write(player_buffer, buffer_text, dataJson);
	network_send_udp_raw(global.client, ip, port, player_buffer, buffer_tell(player_buffer));
}