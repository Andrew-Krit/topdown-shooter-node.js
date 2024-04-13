if(async_load[? "size"] > 0)
{
	var _c_rec_buff = async_load[? "buffer"];
	buffer_seek(_c_rec_buff, buffer_seek_start, 0);
	var _message_id = buffer_read(_c_rec_buff, buffer_string);
	
	var _response = json_decode(_message_id);

	if(ds_map_find_value(_response, "type") == msgType.WEAPON_RELOAD)
	{
		var weaponStat = ds_map_find_value(_response, "weaponStat");
		var weaponId = ds_map_find_value(_response, "weaponId");
		
		if(weaponId == weaponIDD)
		{
			weaponData.ammoInClip = ds_map_find_value(weaponStat, "ammoInClip");
			isOnReloading = false;
		}	
	}
	
	if(ds_map_find_value(_response, "type") == msgType.WEAPON_SHOOT)
	{
		var weaponStat = ds_map_find_value(_response, "weaponStat");
		var weaponId = ds_map_find_value(_response, "weaponId");
		
		
		var weaponType = ds_map_find_value(weaponStat, "type");
		if(weaponId == weaponIDD)
		{	
			weaponData.ammoInClip = ds_map_find_value(weaponStat, "ammoInClip");
			
			audio_play_sound(weaponData.sound, 0, 0, 1, 0, 1);
		}
	}
	
	if(ds_map_find_value(_response, "type") == msgType.GET_WEAPON_STAT)
	{
		var weaponStat = ds_map_find_value(_response, "weaponStat");
		var weaponId = ds_map_find_value(_response, "weaponId");
		
		if(weaponId == weaponIDD)
		{
			direction = ds_map_find_value(weaponStat, "direction");
			x = ds_map_find_value(weaponStat, "x");
			y = ds_map_find_value(weaponStat, "y");
			
			var playersAmount = instance_number(obj_player);
			var ownerId = ds_map_find_value(weaponStat, "ownerId");
			
			if (ownerId != undefined)
			{
				for(var i = 0; i < playersAmount; i++)
				{
					var curPlayer = instance_find(obj_player, i);
					if(curPlayer.playerNumber == ownerId)
					{
						break;
					}
				}
				
				owner = curPlayer;
			}
			else
			{
				owner = undefined;
			}
		}
	}
	
	if(ds_map_find_value(_response, "type") == msgType.WEAPON_PICKUP)
	{
		var weaponStat = ds_map_find_value(_response, "weaponStat");
		var weaponId = ds_map_find_value(_response, "weaponId");
		var ownerId = ds_map_find_value(weaponStat, "ownerId");
		var previousOwnerId = ds_map_find_value(_response, "previousOwnerId");
		
		var playersAmount = instance_number(obj_player);
	
		if(previousOwnerId != undefined)
		{
			for(var i = 0; i < playersAmount; i++)
			{
				var curPlayer = instance_find(obj_player, i);
				if(curPlayer.playerNumber == previousOwnerId)
				{
					break;
				}
			}
			
			if(weaponIDD == weaponId)
			{
				curPlayer.weapon = undefined;
				owner = undefined;
			}
		}
		else
		{
			for(var i = 0; i < playersAmount; i++)
			{
				var curPlayer = instance_find(obj_player, i);
				if(curPlayer.playerNumber == ownerId)
				{
					break;
				}
			}

			if(weaponIDD == weaponId)
			{
				curPlayer.weapon = id;
				
				owner = curPlayer;
			}
		}
	}
}
