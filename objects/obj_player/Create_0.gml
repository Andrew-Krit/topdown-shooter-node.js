
HUD = instance_create_layer(x, y, "HUD", obj_HUD);
HUD.owner = id;
image_blend = make_color_rgb(irandom(255),irandom(255),irandom(255));

playerValues = 
{
	moveSpeed : 5,
}

XAxis = 0;
YAxis = 0;
	
isThisOurPlayer = true;

playerNumber = global.playerNumber;

key_left = 0;
key_right = 0;
key_up = 0;
key_down = 0;
key_shoot = 0;
player_score = 0;
player_health = 100;

set_player_states = function()
{
	data = ds_map_create();

	ds_map_add(data, "key_left", key_left);
	ds_map_add(data, "key_right", key_right);
	ds_map_add(data, "key_up", key_up);
	ds_map_add(data, "key_down", key_down);
	ds_map_add(data, "key_shoot", key_shoot);
	ds_map_add(data, "x", x);
	ds_map_add(data, "y", y);
	ds_map_add(data, "direction", direction);
	ds_map_add(data, "image_blend", image_blend);
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "id", global.playerNumber);
	
	sendMapOverUDP("127.0.0.1", 8080, 1000, data, msgType.SET_PLAYER_STAT);
}

get_player_states = function()
{
	data = ds_map_create();
	
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "id", playerNumber);
	ds_map_add(data, "playerStat", noone);
	
	
	sendMapOverUDP("127.0.0.1", 8080, 300, data, msgType.GET_PLAYER_STAT);
}

die_check = function()
{
	if(player_health <= 0)
	{
		weapon.owner = undefined;
		instance_deactivate_object(id);
	}
}

refresh_hp = function()
{
	data = ds_map_create();
	
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "id", playerNumber);
	ds_map_add(data, "playerStat", noone);
	
	
	sendMapOverUDP("127.0.0.1", 8080, 300, data, msgType.REFRESH_HP);
}


weapon = undefined;
