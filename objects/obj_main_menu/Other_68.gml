if(async_load[? "size"] > 0)
{
	var _c_rec_buff = async_load[? "buffer"];
	buffer_seek(_c_rec_buff, buffer_seek_start, 0);
	var _message_id = buffer_read(_c_rec_buff, buffer_string);
	
	var _response = json_decode(_message_id);
	
	if(ds_map_find_value(_response, "type") == msgType.CREATE_HOST)
	{
		is_host_stopped = false;
		should_host_stop = false;
		var _hostNumber = ds_map_find_value(_response, "hostNumber");
		var _playerNumber = ds_map_find_value(_response, "id");
		
		global.hostNumber = _hostNumber;
		global.playerNumber = _playerNumber
		window_set_caption("HOST: " + global.userName);
		room_goto(r_game_field);
	}
	
	if(ds_map_find_value(_response, "type") == msgType.STOP_HOST)
	{
		var _res = ds_map_find_value(_response, "res");
		
		if(_res == "stopped")
		{
			is_host_stopped = true;
			TweenStop(tweenHostStop);
			current_page = main_menu;
		}
	}
	
	
	if(ds_map_find_value(_response, "type") == msgType.GET_HOSTS)
	{
		var _hosts = ds_map_find_value(_response, "hosts");
		number_of_hosts = ds_list_size(_hosts);
		join_menu = [];
		
		for(var i = 0; i < number_of_hosts; i++)
		{
			var _host = ds_list_find_value(_hosts,i);
			var players = ds_map_find_value(_host,"players");
			number_of_players = ds_list_size(players);
			var _hostData = ds_list_find_value(players, 0);
			array_push(join_menu,	[ds_map_find_value(_hostData, "userName") +":" + string(number_of_players), function(){should_i_try_to_join = true}]);
			TweenStop(tweenGetHosts);
		}
		array_push(join_menu, 	["BACK", function()
		{
			current_page = main_menu;
		}]);

		current_page = join_menu;
	}
	
	if(ds_map_find_value(_response, "type") == msgType.JOIN_HOST)
	{
		should_i_try_to_join = false;
		TweenStop(tweenJoin);
		
		var _hostNumber = ds_map_find_value(_response, "hostNumber");
		var _playerNumber = ds_map_find_value(_response, "id");
		
		global.hostNumber = _hostNumber;
		global.playerNumber = _playerNumber;
		window_set_caption("JOINED: " + global.userName);
		room_goto(r_game_field);
	}
}
