function send_movement_event(x_value, y_value){
	buffer_seek(conn_client.client_buffer, buffer_seek_start, 0);

	buffer_write(conn_client.client_buffer, buffer_u8, network.move);

	buffer_write(conn_client.client_buffer, buffer_u16, x_value);
	buffer_write(conn_client.client_buffer, buffer_u16, y_value);

	network_send_packet(conn_client.client, conn_client.client_buffer, buffer_tell(conn_client.client_buffer));
}
