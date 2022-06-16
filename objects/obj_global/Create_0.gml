global.client = network_create_socket(network_socket_udp);

//global.IP = "ec2-3-86-250-91.compute-1.amazonaws.com";
global.IP = "127.0.0.1";
global.PORT = "3000";

global.host= noone;
global._id = noone;

enum msg_type {
	CREATE_HOST,
	JOIN_HOST,
	STOP_HOST,
	SET_PLAYER_STAT,
	GET_PLAYER_STAT,
	GET_HOSTS,
	GET_NEW_PLAYERS
}

// DEV
global.debug = 0;