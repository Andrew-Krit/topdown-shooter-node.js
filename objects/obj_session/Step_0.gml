if(should_i_try_to_check_new_players)
{
	should_i_try_to_check_new_players = false;
	TweenPlay(tweenCheckNewPlayers);

	data = ds_map_create();
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "players", noone);
	sendMapOverUDP("127.0.0.1", 8080, 200, data, msgType.GET_NEW_PLAYERS);
}

get_bullets();