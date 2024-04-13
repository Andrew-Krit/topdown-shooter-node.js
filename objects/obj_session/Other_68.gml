if(async_load[? "size"] > 0)
{
	var _c_rec_buff = async_load[? "buffer"];
	buffer_seek(_c_rec_buff, buffer_seek_start, 0);
	var _message_id = buffer_read(_c_rec_buff, buffer_string);
	
	var _response = json_decode(_message_id);
	//show_message(_message_id);
	if(ds_map_find_value(_response, "type") == msgType.GET_NEW_PLAYERS)
	{
		var players =  ds_map_find_value(ds_map_find_value(_response, "players"),"players");

		number_players_in_session = instance_number(obj_player);
		
		if(number_players_in_session > 0)
		{
			for(var i = 0; i < number_players_in_session; i++)
			{
				var exist_player = instance_find(obj_player, i);
				var number_of_players = ds_list_size(players);
				
				for(var j = 0; j < number_of_players; j++)
				{
					var player = ds_list_find_value(players, j);
					var pn = ds_map_find_value(player, "id");
					
					if(pn == exist_player.playerNumber)
					{
						ds_list_delete(players, j);
					
 						number_of_players = ds_list_size(players);	
					}
				}
			}
		}
		
		var number_of_players_remain = ds_list_size(players);
		
		for(var i = 0; i < number_of_players_remain; i++)
		{
			var player = ds_list_find_value(players, i);
			
			var xx = ds_map_find_value(player, "x");
			var yy = ds_map_find_value(player, "y");
			
			new_player = instance_create_layer(xx, yy, "Instances", obj_player);
			
			new_player.isThisOurPlayer = false;
			new_player.playerNumber = ds_map_find_value(player, "id");
		}
	}	
	
	if(ds_map_find_value(_response, "type") == msgType.GET_BULLETS)
	{
		var bullets = ds_map_find_value(_response, "bullets");
		
		number_bullets_in_session = instance_number(obj_bullet);
		var bullets_to_delete = ds_list_create();
		
		if(number_bullets_in_session > 0)
		{
			for(var i = 0; i < number_bullets_in_session; i++)
			{
				var exist_bullet = instance_find(obj_bullet, i);
				var number_of_bullets = ds_list_size(bullets);
				var nonExistBullet = true;
				
				for(var j = 0; j < number_of_bullets; j++)
				{
					var bullet = ds_list_find_value(bullets, j);
					var bulletId = ds_map_find_value(bullet, "id");
					
					if(bulletId == exist_bullet.bulletId)
					{
						ds_list_delete(bullets, j);
						nonExistBullet = false;
	 					number_of_bullets = ds_list_size(bullets);	
					}
				}
				
				if(nonExistBullet)
				{
					ds_list_add(bullets_to_delete, exist_bullet);
				}
			}
			
			for(var z = 0; z < ds_list_size(bullets_to_delete); z++)
			{
				var bullet = ds_list_find_value(bullets_to_delete, z);
				instance_destroy(bullet);
			}
		}
		
		var number_of_bullets_remain = ds_list_size(bullets);
		
		for(var i = 0; i < number_of_bullets_remain; i++)
		{
			var bullet = ds_list_find_value(bullets, i);
			
			var xx = ds_map_find_value(bullet, "x");
			var yy = ds_map_find_value(bullet, "y");
			var dir = ds_map_find_value(bullet, "direction");
			var spd = ds_map_find_value(bullet, "speed");
			var own = ds_map_find_value(bullet, "ownerId");
			var indeficator = ds_map_find_value(bullet, "id");
			
			new_bullet = instance_create_layer(xx, yy, "Instances", obj_bullet);
			new_bullet.initialize(indeficator, dir, spd, own);

		}
		
	}
}

