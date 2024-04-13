//audio_play_sound(mp3_op,0,1,0.1,4,0.8);
cursor_sprite = spr_crosshair;
main_menu =
[
	["HOST", function()
	{
		current_page = host_menu;
	}],
	["JOIN", function()
	{
		should_i_try_to_get_hosts = true;
		
	}],
	["USERNAME: " + global.userName, function()
	{
		
	}],
	["QUIT GAME", function()
	{
		game_end();
	}],
];

host_menu =
[
	["HOST", function()
	{
		data = ds_map_create();
		ds_map_add(data, "hostNumber", undefined);
		ds_map_add(data, "id", undefined);
		ds_map_add(data, "userName", global.userName);
		sendMapOverUDP("127.0.0.1", 8080, 100, data, msgType.CREATE_HOST);
	}],
	["BACK", function()
	{
		should_host_stop = true;
	}]
];

join_menu =
[
	["BACK", function()
	{
		current_page = main_menu;
	}]
];

is_host_stopped = false;
should_host_stop = false;

should_i_try_to_get_hosts = false;
should_i_try_to_join = false;

current_page = main_menu;
selected_option_index = 0;

local_host_number = noone;
local_number_of_player = noone;


tweenHostStop = TweenCreate(id, EaseInOutQuart, TWEEN_MODE_ONCE, true, 2, 0, "should_host_stop", should_host_stop, true);
tweenGetHosts = TweenCreate(id, EaseInOutQuart, TWEEN_MODE_ONCE, true, 3, 0, "should_i_try_to_get_hosts", should_i_try_to_get_hosts, true);
tweenJoin = TweenCreate(id, EaseInOutQuart, TWEEN_MODE_ONCE, true, 2, 0, "should_i_try_to_join", should_i_try_to_join, true);