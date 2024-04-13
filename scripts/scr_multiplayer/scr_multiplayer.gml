function sendMapOverUDP(ip, port, size, map, type)
{
	network_connect_raw(global.client, ip, port);
	var player_buffer = buffer_create(size, buffer_fixed, 100);
	
	ds_map_add(map,"type", type);
	var dataJson = json_encode(map);
	ds_map_destroy(map);
	
	buffer_seek(player_buffer, buffer_seek_start, 0);
	buffer_write(player_buffer, buffer_text, dataJson);
	network_send_udp_raw(global.client, ip, port, player_buffer, buffer_tell(player_buffer));
}