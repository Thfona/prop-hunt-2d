global.client = network_create_socket(network_socket_udp);
global.IP = "127.0.0.1";
global.PORT = 8080;

global.host_number = noone;
global.player_number = noone;

enum msg_type {
	CREATE_HOST,
	JOIN_HOST,
	STOP_HOST,
	SET_PLAYER_STAT,
	GET_PLAYER_STAT,
	GET_HOSTS,
	GET_NEW_PLAYERS
}
