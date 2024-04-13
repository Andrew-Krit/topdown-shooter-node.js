draw_set_halign(fa_center);

draw_sprite_ext(spr_player,image_index, x, y, 1, 1, 0, image_blend, image_alpha);
draw_text(x,y-55,"HP: " + string(player_health));
depth = -y;