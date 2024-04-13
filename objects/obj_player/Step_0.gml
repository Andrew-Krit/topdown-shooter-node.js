if(isThisOurPlayer)
{
	scr_player_inputCheck();
	scr_playerMovement();
	set_player_states();
}
else
{
	get_player_states();
}

refresh_hp();