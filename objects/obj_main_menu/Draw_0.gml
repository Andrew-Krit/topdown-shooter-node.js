if(array_length(current_page) > 0)
{
	for (var i = 0; i < array_length(current_page); i++)
	{
		var _color = "[#FFFFFF]";
	
		if(selected_option_index == i)
		{
			_color = "[#FF0000]";
		}
	
		var _option = scribble(_color + "[scale,3][fnt_arial]" + current_page[i][0]);
		_option.align(fa_center);
		_option.draw(room_width/2, room_height/2-200 + i*100);
	}
}
