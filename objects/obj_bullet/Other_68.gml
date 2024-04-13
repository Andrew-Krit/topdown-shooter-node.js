if(async_load[? "size"] > 0)
{
	var _c_rec_buff = async_load[? "buffer"];
	buffer_seek(_c_rec_buff, buffer_seek_start, 0);
	var _message_id = buffer_read(_c_rec_buff, buffer_string);
	
	var _response = json_decode(_message_id);

	if(ds_map_find_value(_response, "type") == msgType.SET_BULLET_STAT)
	{
		
	}
	
	if(ds_map_find_value(_response, "type") == msgType.GET_BULLET_STAT)
	{
		var bullet = ds_map_find_value(_response, "bulletStat");
		var xx = ds_map_find_value(bullet, "x");
		var yy = ds_map_find_value(bullet, "y");
		var dir = ds_map_find_value(bullet, "direction");
		var spd = ds_map_find_value(bullet, "speed");
		var indeficator =  ds_map_find_value(bullet, "id");
		
		if(bulletId == indeficator)
		{
			x = xx;
			y = yy;
			direction = dir;
			speed = spd;
		}
	}
	
	if(ds_map_find_value(_response, "type") == msgType.BULLET_DESTROY)
	{

	}
}