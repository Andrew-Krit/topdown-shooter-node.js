if(async_load[? "size"] > 0)
{
	var _c_rec_buff = async_load[? "buffer"];
	buffer_seek(_c_rec_buff, buffer_seek_start, 0);
	var _message_id = buffer_read(_c_rec_buff, buffer_string);
	
	var _response = json_decode(_message_id);
	
	if(ds_map_find_value(_response, "type") == msgType.SET_PLAYER_STAT)
	{

	}
	
	if(ds_map_find_value(_response, "type") == msgType.GET_PLAYER_STAT)
	{
		var playerStat = ds_map_find_value(_response, "playerStat");
		var pn = ds_map_find_value(playerStat, "id");
		if(pn == playerNumber)
		{
			key_left = ds_map_find_value(playerStat, "key_left");
			key_right = ds_map_find_value(playerStat, "key_right");
			key_up = ds_map_find_value(playerStat, "key_up");
			key_down = ds_map_find_value(playerStat, "key_down");
			key_shoot = ds_map_find_value(playerStat, "key_shoot");
			
			direction = ds_map_find_value(playerStat, "direction");
			x = ds_map_find_value(playerStat, "x");
			y = ds_map_find_value(playerStat, "y");
			image_blend = ds_map_find_value(playerStat, "image_blend");
		}
	}
	
	if(ds_map_find_value(_response, "type") == msgType.SET_PLAYER_DAMAGE)
	{
		var idd = ds_map_find_value(_response, "damagedId");
		
		if(idd == playerNumber)
		{
			die_check();
		}
	}
	
	if(ds_map_find_value(_response, "type") == msgType.REFRESH_HP)
	{
		var playerStat = ds_map_find_value(_response, "playerStat");
		var pn = ds_map_find_value(playerStat, "id");
		if(pn == playerNumber)
		{
			player_health = ds_map_find_value(playerStat, "player_health");
		}
	}
}