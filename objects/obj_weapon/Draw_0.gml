image_angle = direction;

if(owner != undefined)
{
	draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, c_white, image_alpha);
	depth = owner.depth-10;
}
else
{
	draw_self();

	image_angle += 5;
}


