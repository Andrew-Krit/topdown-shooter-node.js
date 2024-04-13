if(owner != undefined)
{
	if(owner.playerNumber == global.playerNumber)
	{
		x = owner.x;
		y = owner.y;
		direction = point_direction(x, y, mouse_x, mouse_y);
		set_weapon_states();
	}
}

get_weapon_states();

//for(var i = 0; i < instance_number(obj_weapon); i++)
//{
//	show_debug_message(instance_find(obj_weapon,i).weaponIDD);
//	show_debug_message(instance_find(obj_weapon,i).owner);
//}