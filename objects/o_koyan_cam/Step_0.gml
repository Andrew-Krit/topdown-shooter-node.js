/// @desc (Setting's)

// Set the (Local) Function to (Global) Variable so we can use this (Outside)
global._cam_mode_change = scr_cam_change;
global._screen_shake	= scr_screen_shake;
global._zoom_amount		= scr_zooming;

// Camera Pozition's (Update)
k_cam = view_get_camera(global.koyan_cam);
_v_X  = camera_get_view_x(global.koyan_cam);					// "CAMERA" (Updated-X)
_v_Y  = camera_get_view_y(global.koyan_cam);					// "CAMERA" (Updated-Y)

// (Screen_Shake) Setting's
_v_X		 += random_range(-_shake_Remain, _shake_Remain);
_v_Y		 += random_range(-_shake_Remain, _shake_Remain);
_shake_Remain = max(0, _shake_Remain - ((1 / _shake_Length) * _shake_Magnitude));

// Add Camera (Mode's) ---------------(Important)---------------//
#region (Special) Cam Mode's
	// Camera (Mod) Changing System
	switch (global._cam_mode) {																// Updated should be checked not the original one (_c_mode) for be able to go back to the original (_c_mode)
		// Main mode, it follow's the object center if there is any
		case "FOLLOW_TARGET":
			if (_target != noone && instance_exists(_target)) {								
				xto  = (_target.x); yto = (_target.y);										// If there is a (Target) Follow, "TARGET_X" and "TARGET_Y"

				_v_X = xto + offset - _v_W_Half;											// Follow "X_SPEED"
				_v_Y = yto - _v_H_Half;														// Follow "Y_SPEED"

				_target_only = true;														// (Target_Only)
			} else {break;}																	
		break;																				

		// Just Follow the Mouse Cursor														
		case "FOLLOW_MOUSE":
			xto = (mouse_x); yto = (mouse_y);												// Follow "MOUSE_X" and "MOUSE_Y"

			_v_X = (xto - _v_W_Half);														// Follow "X_SPEED"
			_v_Y = (yto - _v_H_Half);														// Follow "Y_SPEED"

			_target_only = false;															// "NOT" (Target_Only)
		break;

		// This is a mode in the other game's such as like "ENTER THE GUNGEON" etc... this allow's us to look little bit more beyond the view but not so much that it is out of the player
		case "FOLLOW_MOUSE_PEEK":
			if (_target != noone && instance_exists(_target)) {
				var _sp = 0.3;																// (Can Change) || Bigger (Faster)-Smaller (Slower)
				xto  = (mouse_x); yto = (mouse_y);											// Follow "MOUSE_X" and "MOUSE_Y"

				_v_X = lerp(_target.x, xto + offset, _sp) - _v_W_Half;						// Follow "X_SPEED" With (Lerp)
				_v_Y = lerp(_target.y, yto, _sp) - _v_H_Half;								// Follow "Y_SPEED" With (Lerp)

				_target_only = true;														// (Target_Only)
			} else {break;}
		break;

		// This mode is just like in the (Strategy) game's you can just click the mouse and drag it across in the room
		case "FOLLOW_MOUSE_DRAG":
			var mouse_xx = display_mouse_get_x();
			var mouse_yy = display_mouse_get_y();

			if (mouse_check_button(mb_left)) {												// (Can Change)
				var _sp = 0.5;																// (Can Change) || Bigger (Faster)-Smaller (Slower)
				_v_X   += (_mouse_X_pre - mouse_xx) * _sp;
				_v_Y   += (_mouse_Y_pre - mouse_yy) * _sp;
			}
																												
			_mouse_X_pre = mouse_xx;
			_mouse_Y_pre = mouse_yy;

			_target_only = false;															// "NOT" (Target_Only)
		break;

		// Move "VIEW" to the Mouse's (Pozition) When you collide with the Border of the "ROOM_VIEW"
		case "FOLLOW_MOUSE_BORDER":
			if (!point_in_rectangle(mouse_x, mouse_y, _v_X + (_v_W_Edit*0.1), _v_Y + (_v_H_Edit*0.1), _v_X + (_v_W_Edit*0.9), _v_Y + (_v_H_Edit*0.9))) {
				var _sp = 0.02;																// (Can Change) || Bigger (Faster)-Smaller (Slower)
				xto     = (mouse_x); yto = (mouse_y);										// Follow "MOUSE_X" and "MOUSE_Y"

				_v_X = lerp(_v_X, (xto - _v_W_Half), _sp);									// Follow "X_SPEED" With (Lerp)
				_v_Y = lerp(_v_Y, (yto - _v_H_Half), _sp);									// Follow "Y_SPEED" With (Lerp)

				_target_only = false;														// "NOT" (Target_Only)
			} else {break;}
		break;

		// "DELAYED" Camera Movement (Cinematic_Angle)
		case "SMOOTH_TO_TARGET":
			if (_target != noone && instance_exists(_target)) {
				var _sp = 0.2;																// (Can Change) || Bigger (Faster)-Smaller (Slower)
				xto		= (_target.x); yto = (_target.y);									// Eğer (Target) var ise Follow "X" and Follow "Y"

				_v_X = lerp(_v_X, xto + offset - _v_W_Half, _sp);							// Follow "X_SPEED" With (Lerp)
				_v_Y = lerp(_v_Y, (yto - _v_H_Half), _sp);									// Follow "Y_SPEED" With (Lerp)

				_target_only = true;														// (Target_Only)
			} else {break;}
		break;
		
		// Go to (Clicked) "MOUSE_X" and "MOUSE_Y" Pozition's
		case "MOVE_TO_CLICK":
			if (mouse_check_button_pressed(mb_left)) {
				xto = (mouse_x); yto = (mouse_y);											// Follow (Clicked) "MOUSE_X" and "MOUSE_Y" Pozition 
				x   = xto;																	// Camera (Sprite) Follow "X_TO"
				y   = yto;																	// Camera (Sprite) Follow "Y_TO"

				_v_X = (x - _v_W_Half);														// Follow (Object's) "X"
				_v_Y = (y - _v_H_Half);														// Follow (Object's) "Y"

				_target_only = false;														// "NOT" (Target_Only)
			} else {break;}
		break;

		// Go to The (Target) "X" and "Y" Pozition's with (Lerp) Function and Change The Camera (Mode)
		case "MOVE_TO_TARGET":
			if (_target != noone && instance_exists(_target)) {
				var _sp = 0.02;																// (Can Change) || Bigger (Faster)-Smaller (Slower)
				xto     = (_target.x); yto = (_target.y);									// Eğer (Target) var ise Follow "X" and Follow "Y"

				_v_X = lerp(_v_X, (xto - _v_W_Half), _sp);									// Follow "X_SPEED" With (Lerp)
				_v_Y = lerp(_v_Y, (yto - _v_H_Half), _sp);									// Follow "Y_SPEED" With (Lerp)

				// Changed the (Mode) Automatically because we are so close to the "TARGET" Object because of (Lerp)
				if (point_distance(x, y, (xto - _v_W_Half), (yto - _v_H_Half)) < 1)
					{global._cam_mode = _c_mode;}											// (Can Change)

				_target_only = true;														// (Target_Only)
			} else {break;}
		break;
	}
#endregion

// (Region RE-Activate System) -----------(Important)-----------//
// If (Optimize) "ON" then object's that go (Inside) of "VIEW" region get's "ACTIVATED"
if (_optimize) {
	instance_activate_region(_v_X, _v_Y, _v_W_Edit, _v_H_Edit, true);

	instance_activate_object(o_koyan_cam);						// (Don't Touch-Guarantee)
	instance_activate_object(_target);							// (Don't Touch-Guarantee)

	instance_activate_layer("Instances");						// (Can Change) || (Can Add More) || Special (Layer's) you dont want to close while in "OPTIMIZE" Mode like "PERSISTENT" object's (Layer)
	//instance_activate_layer("Instances_2");					// (   Like this)
	//instance_activate_layer("Instances_3");					// (Or Like this)

	if (alarm[2] == -1) {alarm[2] = _delay;}					// (Loop) || (Can_Change)
}

// If There is a "BLACK_BAR" Issue Make It More Obvious To The (Admin) || Camera (Debug_UI) Panel "VISIBLITY" (On-Off)
if (_debug_ui) {visible = true;  window_set_color(c_red);}
else		   {visible = false; window_set_color(c_black);}

// If there is a (Special-Room) picked that (Room's) "WIDTH" and "HEIGHT" changes Camera's (View) Value's With Its Own ----(VERY_Important)----//
if (_full_v_of_room != noone) {
	for (var i = 0; i < array_length(k_FULL_VIEW_def); i++) {
		if (room_exists(k_FULL_VIEW_def[i]) && room == k_FULL_VIEW_def[i]) {	// If "ROOMS" Exists Do Below		|| If we are in one of those "ROOMS" Work Below
			global._v_multply = floor(room_width / _v_W);						// (Can Change) || We Forcefully making the (View_Multply) Value's (Compatible) with the (Room) Value's
			_v_W_Edit		  = (global._v_multply * _v_W);						// (Can Change) || Camera (Width)	|| This is a (Crucial) "VALUE" for The (Systems)
			_v_H_Edit		  = (global._v_multply * _v_H);						// (Can Change) || Camera (Height)	|| This is a (Crucial) "VALUE" for The (Systems)
			alarm[1]		  = (_delay / 2);									// (Can Change) || For (Standard-Rooms) Setup an Alarm that will convert these to (Prefered) Setting's
		}
	}
}

// (Zooming) Lerp the variables and Setting's --------------------------//
if (k_ZOOM_MULTPLY_def != 0 && k_ZOOM_MULTPLY_def != 1) {				// If it's above or below (0-1) Work bc Multply with either of these will only give the same value's
	var rate   = 0.10;
	var _viewW = camera_get_view_width(global.koyan_cam);
	var _viewH = camera_get_view_height(global.koyan_cam);

	_zoom_amount = lerp(_zoom_amount, _zoom_target, rate);

	var new_w = lerp(_viewW, _zoom_amount * _v_W_Edit, rate);
	var new_h = lerp(_viewH, _zoom_amount * _v_H_Edit, rate);

	_v_X -=  (new_w - _viewW);											// New "X" Pozition of the Camera
	_v_Y -=  (new_h - _viewH);											// New "Y" Pozition of the Camera

	camera_set_view_size(global.koyan_cam, new_w, new_h);				// Set these "SIZE" value's to our camera
}

// If These Variable's are "CHANGED" in (Anyway) or (Anywhere) Only Then Start the (Stabilizing-Alarm) ----(VERY_Important)----//
if (pass && (global._v_multply == _v_multply && global._res_multply == _r_multply && global._gui_divider == _gui_divide && global._fullscreen == _f_screen))
	{alarm[0] = _delay;}

// "FORCE" Room's to Use Our Camera || For "ALL" (Room's) ViewPort, etc ----(VERY_Important)----//
if (room_get_camera(room, _view_port) != k_cam) {
	view_set_camera(_view_port, global.koyan_cam);
	room_set_viewport(room, _view_port, true, 0, 0, _port_width, _port_height);
	room_set_camera(room, _view_port, global.koyan_cam);

	if (!view_enabled)				   {view_enabled = true;}									// (Force) "VIEW" to be (Active)
	if (!view_get_visible(_view_port)) {view_set_visible(_view_port, true);}					// (Force) "VIEW" to be (Visible)

	show_debug_message("|-| Forced 'ROOM' and 'CAMERA' Connection |-|");
}

// (Boundless) Clamp (Variable's) and (Setting's) ----------------------------------------------//
if (!_freedom) {
	// (Keep) The Camera "CENTER" Inside the Room With Using "BUFF"
	_v_X = clamp(_v_X, 0, (room_width  - _v_W_Edit));											// (Can Change) || "X" (Buff)
	_v_Y = clamp(_v_Y, 0, (room_height - _v_H_Edit));											// (Can Change) || "Y" (Buff)

	// Test Edilmiş (View) ve (Resolution) Oranlarına (Kilitle)
	_max_res			= floor(abs((_display_W / _ideal_W) * (_display_H / _ideal_H)));		// (Don't Touch) || (Resolution) Restriction
	global._v_multply   = clamp(global._v_multply,   0.10, 8);									// (Don't Touch) || "VIEW" (Multply)
	global._res_multply = clamp(global._res_multply, 1,	   _max_res);							// (Can Change)  || "RESOLUTION" Cannot go beyond his best condition for the (Monitor)
	global._gui_divider = clamp(global._gui_divider, 0.10, 6);									// (Can Change)  || "GUI"		 Cannot go beyond his best condition for the (Viewer)
} else {_pixel_perfect  = false;}																// (Don't Touch) || (De-Activate) Forced (Pixel-Perfection) if we are in "BOUNDLESS" Mode !!

// Global's (Update) for the access from another objects || So they can just use (Global) variable's rather than (Local) ones
global._cam_X = _v_X;
global._cam_Y = _v_Y;
global._cam_W = _v_W_Edit;
global._cam_H = _v_H_Edit;

// Camera's "POZITION" Setting's (Update) -----(Very_Important)-----// This (Should) be Always The "LAST" Setup and in should be in a (Loop)
camera_set_view_pos(global.koyan_cam, _v_X, _v_Y);					// "CAMERA" (View) "POZITION"