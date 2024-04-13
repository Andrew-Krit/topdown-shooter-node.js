ownerId = undefined;
bulletId = undefined;

initialize = function(indeficator, dir, spd, own)
{
	bulletId = indeficator;
	direction = dir;
	image_angle = direction;
	speed = spd;
	ownerId = own;
}

set_bullet_stat = function()
{
	data = ds_map_create();
	
	ds_map_add(data, "x", x);
	ds_map_add(data, "y", y);
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "id", bulletId);

	
	sendMapOverUDP("127.0.0.1", 8080, 1000, data, msgType.SET_BULLET_STAT);
}

get_bullet_stat = function()
{
	data = ds_map_create();
	
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "id", bulletId);
	ds_map_add(data, "bulletStat", noone);
	
	
	sendMapOverUDP("127.0.0.1", 8080, 300, data, msgType.GET_BULLET_STAT);
}


bullet_destroy = function()
{
	data = ds_map_create();
	
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "id", bulletId);
	
	
	sendMapOverUDP("127.0.0.1", 8080, 300, data, msgType.BULLET_DESTROY);

}
