function scr_player_inputCheck()
{
	key_left = input_check("left");
	key_right = input_check("right");
	key_up = input_check("up");
	key_down = input_check("down");
	
	key_shoot = input_check_pressed("shoot");
	key_pickup = input_check_pressed("pickup");
	key_reload = input_check_pressed("reload");
}


function scr_playerMovement()
{
	XAxis = key_right - key_left;
	YAxis = key_down - key_up;
	
	if(key_pickup)
	{
		var _potentialWeapon = instance_nearest(x, y, obj_weapon);
		
		if(weapon == undefined)
		{
			if(place_meeting(x, y, _potentialWeapon) && _potentialWeapon.owner == undefined)
			{
				d = ds_map_create();
				ds_map_add(d, "hostNumber", global.hostNumber);
				ds_map_add(d, "weaponId", _potentialWeapon.weaponIDD);	
				ds_map_add(d, "ownerId", global.playerNumber);
				ds_map_add(d, "ammoInClip", _potentialWeapon.weaponData.ammoInClip)
				sendMapOverUDP("127.0.0.1", 8080, 300, d, msgType.WEAPON_PICKUP);
				
				audio_play_sound(snd_pickup, 0, 0, 1);
			}
		}
		else
		{
			d = ds_map_create();
			ds_map_add(d, "hostNumber", global.hostNumber);
			ds_map_add(d, "weaponId", _potentialWeapon.weaponIDD);	
			ds_map_add(d, "ownerId", undefined);
			sendMapOverUDP("127.0.0.1", 8080, 300, d, msgType.WEAPON_PICKUP);
			audio_play_sound(snd_drop, 0, 0, 1);
		}
		
	}
	
	if(key_shoot && weapon != undefined)
	{
		weapon.shoot();
	}
	
	if(key_reload && weapon.isOnReloading != true && weapon != undefined)
	{
		weapon.reload();
	}
	
	hAxis = XAxis * playerValues.moveSpeed;
	vAxis = YAxis * playerValues.moveSpeed;
	
	if(place_meeting(x+hAxis, y, obj_collision))
	{
	    while (!place_meeting(x+sign(hAxis), y ,obj_collision))
		{
	        x += sign(hAxis);
	    }
	    hAxis = 0;
	}
	
	if (place_meeting(x, y+vAxis, obj_collision))
	{
	    while (!place_meeting(x, y+sign(vAxis) ,obj_collision))
		{
	        y += sign(vAxis);
	    }
	    vAxis = 0;
	}
	
	x += hAxis;
	y += vAxis;
}