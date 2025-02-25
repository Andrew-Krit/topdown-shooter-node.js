/// @desc (Stabilizing) - (Updating_Process)

// (Before) Value's are (Now) Equal to there Changed (Global) Value's
_f_screen	= global._fullscreen;
_v_multply  = global._v_multply;
_r_multply  = global._res_multply;
_gui_divide = global._gui_divider;

// "DELAYED" (Gui) Check for Change's
global._gui_W = round(_ideal_W / _gui_divide);				 // (Default)
global._gui_H = round(_ideal_H / _gui_divide);				 // (Default)
display_set_gui_size(global._gui_W, global._gui_H);			 // (Default)

aspect_ratio = (display_get_width() / display_get_height()); // (Default)

_port_width  = (_ideal_W * (_r_multply));					 // (Can_Change)
_port_height = (_ideal_H * (_r_multply));					 // (Can_Change)

// "DELAYED" (Window's) Settings and (Alarm) Setup
if (_f_screen) {window_set_fullscreen(true);}
else {
	window_set_fullscreen(false);
	window_set_size(_port_width, _port_height);
	alarm[3] = (_delay);
}

// Unless "BOUNDLESS" Mode is (Active) "NEVER" let the "RESOLUTION" Become Bigger Then The "DISPLAY" of the Monitor Screen
if (!_freedom && ((_ideal_W * _r_multply) > _display_W || (_ideal_H * _r_multply) > _display_H)) {
	_ideal_W = _display_W;									  // Set "RESOLUTION" to "MAX" (Display_Width)
	_ideal_H = _display_H;									  // Set "RESOLUTION" to "MAX" (Display_Height)

	// (Surface) and (Window) "START" Setup's
	surface_resize(application_surface, _ideal_W, _ideal_H);
} else {
	// Calculate New (Ideal Width)
	_ideal_W = round(_ideal_H * aspect_ratio);
	_ideal_H = round(_ideal_W / aspect_ratio);

	_ideal_W = round(_ideal_W);
	_ideal_H = round(_ideal_H);

	// Check to make sure our ideal width and height isn't an odd number, as that's usually not good.
	if (_ideal_W & 1) {_ideal_W++;}
	if (_ideal_H & 1) {_ideal_H++;}

	// (Surface) and (Window) "START" Setup's
	surface_resize(application_surface, (_ideal_W * _r_multply), (_ideal_H * _r_multply));
}

// "DELAYED" Camera Setting's
camera_set_view_size(global.koyan_cam, _v_W_Edit, _v_H_Edit);	// "CAMERA" (View) "SIZE"
camera_set_view_speed(global.koyan_cam, _v_X, _v_Y);			// "CAMERA" (View) "SPEED"
view_set_camera(_view_port, global.koyan_cam);

// For Changed (Variable's) Print (Debug_Output) About It || (Can_Change)
show_debug_message("\n|---------------------| UPTADED |-----------------------|");
show_debug_message("-Updated_ROOM		 = (" + string(room_get_name(room))	+ ")");
show_debug_message("-Updated_FULL_Screen = (" + string(_f_screen)			+ ")");
show_debug_message("-Updated_VW_Multply  = (" + string(_v_multply)			+ ")");
show_debug_message("-Updated_RES_Multply = (" + string(_r_multply)			+ ")");
show_debug_message("-Updated_GUI_Divider = (" + string(_gui_divide)			+ ")");
show_debug_message("-Updated_FULL_Rooms  = (" + string(_full_v_of_room)		+ ")");
show_debug_message("-Updated_CAM_Mode    = (" + string(_c_mode)				+ ")");
show_debug_message("-Updated_UI_Mode     = (" + string(_debug_ui)			+ ")");
show_debug_message("-----------------------------------------------------------");
show_debug_message("-Updated_VIEW_Width  = (" + string(_v_W_Edit)			+ ")");
show_debug_message("-Updated_VIEW_Height = (" + string(_v_H_Edit)			+ ")");
show_debug_message("-Updated_GUI_Width   = (" + string(global._gui_W)		+ ")");
show_debug_message("-Updated_GUI_Height  = (" + string(global._gui_H)		+ ")");
show_debug_message("|-----------------------------------------------------------|\n");

// Alarm[0] "LOOPS" start working when itself is finished
pass = true;