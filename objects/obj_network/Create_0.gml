global.client = network_create_socket(network_socket_udp);
global.hostNumber = undefined;
global.playerNumber = undefined;
randomize();
global.userName = "User" + string(irandom_range(0,10000));

enum msgType
{
	CREATE_HOST,
	JOIN_HOST,
	STOP_HOST,	
	GET_NEW_PLAYERS,
	GET_HOSTS,
	SET_PLAYER_STAT,
	GET_PLAYER_STAT,
	SET_WEAPON_STAT,
	GET_WEAPON_STAT,
	WEAPON_PICKUP,
	WEAPON_SHOOT,
	WEAPON_RELOAD,
	GET_BULLETS,
	SET_BULLET_STAT,
	GET_BULLET_STAT,
	BULLET_DESTROY,
	SET_PLAYER_DAMAGE,
	REFRESH_HP
}
