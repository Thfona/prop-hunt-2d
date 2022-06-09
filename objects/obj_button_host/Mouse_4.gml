show_debug_message("Clicked");

data = ds_map_create();

show_debug_message("PEDINDO PARA CRIAR O SERVIDOR");
send_map_over_udp(global.IP, global.PORT, 100, data, msg_type.CREATE_HOST);
