if(should_host_stop && !is_host_stopped)
{
	should_host_stop = false;
	data = ds_map_create();
	ds_map_add(data, "hostNumber", global.hostNumber);
	ds_map_add(data, "res", noone);
	sendMapOverUDP("127.0.0.1", 8080, 100, data, msgType.STOP_HOST);
	TweenPlay(tweenHostStop);
}

if(should_i_try_to_get_hosts)
{
	should_i_try_to_get_hosts = false;
	TweenPlay(tweenGetHosts);
	
	data = ds_map_create();
	ds_map_add(data, "hosts", noone);
	sendMapOverUDP("127.0.0.1", 8080, 100, data, msgType.GET_HOSTS);
}

if(should_i_try_to_join)
{
	should_i_try_to_join = false;
	
	TweenPlay(tweenJoin);
	
	data = ds_map_create();
	ds_map_add(data, "hostNumber", selected_option_index);
	ds_map_add(data, "id", noone);
	ds_map_add(data, "userName", global.userName);
	
	sendMapOverUDP("127.0.0.1", 8080, 100, data, msgType.JOIN_HOST);
}

if(input_check_pressed("up"))
{
	selected_option_index--;
	selected_option_index = clamp(selected_option_index, 0, array_length(current_page)-1);
}
if(input_check_pressed("down"))
{
	selected_option_index++;
	selected_option_index = clamp(selected_option_index, 0,  array_length(current_page)-1);
}

if(input_check_pressed("action"))
{
	current_page[selected_option_index][1]();
	
	if(should_i_try_to_join)
	{
		
	}
	else
	{
		selected_option_index = 0;
	}
}