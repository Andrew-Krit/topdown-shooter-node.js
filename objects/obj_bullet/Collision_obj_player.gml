if(other.playerNumber != ownerId)
{
	data = ds_map_create();
	
	ds_map_add(data, "x", x);
	ds_map_add(data, "y", y);
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "id", bulletId);
	ds_map_add(data, "ownerId", ownerId);
	ds_map_add(data, "damagedId", other.playerNumber);
		
	
	sendMapOverUDP("127.0.0.1", 8080, 1000, data, msgType.SET_PLAYER_DAMAGE);
	bullet_destroy();
}
