should_i_try_to_check_new_players = false;

tweenCheckNewPlayers = TweenCreate(id, EaseInOutQuart, TWEEN_MODE_ONCE, true, 0.3, 0, "should_i_try_to_check_new_players", should_i_try_to_check_new_players, true);

TweenPlay(tweenCheckNewPlayers);

get_bullets = function()
{
	d = ds_map_create();
	
	ds_map_add(d, "hostNumber", global.hostNumber);
	ds_map_add(d, "bullets", noone);
	
	sendMapOverUDP("127.0.0.1", 8080, 300, d, msgType.GET_BULLETS);
}