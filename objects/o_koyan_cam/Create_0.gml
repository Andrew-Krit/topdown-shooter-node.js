/// @desc All System's and Variable's (V1.3.0)
// "<|-------(OPEN VARIABLE DEFINITION'S)--------|>

// "MANUEL" OF THIS CAMERA (HOW_TO_USE) ---------|> https://koyann.itch.io/koyan-camera/devlog/207735/how-to-use-detailed <|---------//
// If you have no idea what you're doing (don't) touch any of these setting's and only use (Variable Definition's) - (Global-Variable's) for your project's customization
// If (BOUNDLESS) Mode is "OFF" and your Monitor is (1920x1080) then your (global._res_multply) value's can only be (4 or 5) For Example (6 and 8) is for (4K) screen's. If you don't have a (4K) Monitor you cannot see a difference, so to be able to reduce unnecessary (Ram-Usage) camera won't let your (View or Res) be bigger than your Monitor screen

//  |---------------|
// <| Made by Koyan |>
//  |---------------|

// You can use these (Global) Variable's for Accessing the Camera Setting's from Another (Object's)
global._res_multply		= (k_RES_MULTPLY_def);	// One of the "MAIN" Variable's || Set's The (Window) and The (Surface)
global._gui_divider		= (k_GUI_DIVIDER_def);	// Use to change (Gui) Data's	|| (Bigger) means closer to the (View)
global._v_multply		= (k_VIEW_MULTPLY_def);	// Picked (_v_W && _v_H) Data's are used and Multiplied by the picked (Number) that is needed for the project || Multplied  (View) "SHOULDNT" be bigger than the actual (Room) it's in
global._cam_mode		= (k_CAMERA_MODE_def);	// For (Special) cases you can choose (Special) Camera "MODES" or you can (Trans) between them
global._fullscreen		= (k_FULL_SCREEN_def);	// "FULL_SCREEN" Control || (True-False)
global._zoom_amount     = 0;					// Function(); || For you to be able to make camera "ZOOM" you have to tick the "k_ZOOMING_def" (on) and make the target value just like others (2, 3, 4) kinda || global._zoom_amount(amount); || it can be anything like (2,3,4,5, ...)
global._screen_shake	= 0;					// Function(); || To be able to use (Screen_Shake) "EFFECT" Outside of this (Object) || global._screen_shake(magnitude, time); 
global._cam_mode_change = "";					// Function(); || For (Changing) "CAMERA_MODES" Outside of the camera object		 || global._cam_mode_change(_mode, _follow_x, _follow_y);

global._gui_W = 0;								// For (Getting) The (Width)	of the "GUI"	from another object
global._gui_H = 0;								// For (Getting) The (Height)	of the "GUI"	from another object
global._cam_X = 0;								// For (Getting) The "X"		of the (Camera)	from another object
global._cam_Y = 0;								// For (Getting) The "Y"		of the (Camera)	from another object
global._cam_W = 0;								// For (Getting) The (Width)	of the (Camera)	from another object
global._cam_H = 0;								// For (Getting) The (Height)	of the (Camera)	from another object

#region (FIRST) READ THE (OBJECT-COMMENT'S) THEN OPEN THIS REGION ---------------------------------//

	// (Camera) Variable's -------------------------// (View) and (Multply) Variable's	|| You can (Customize) this for your own project's to get the (Perfect) result's
	_v_W = (k_VIEW_AND_RES_BASE_def[0]);			// (480|384|320)		 || View "BASE" (Width)  || All (Rooms) Width  can only be "MINIMUM" value of (_v_W) Otherwise (Screen-Glitch) can happen
	_v_H = (k_VIEW_AND_RES_BASE_def[1]);			// (270|216|180)		 || View "BASE" (Height) || All (Rooms) Height can only be "MINIMUM" value of (_v_H) Otherwise (Screen-Glitch) can happen
	_v_X = 0;										// Camera's Current "X" Pozition || This values will get redefined below
	_v_Y = 0;										// Camera's Current "Y" Pozition || This values will get redefined below

	_r_multply   = global._res_multply;				// (Dont Touch-Default) || For Easier "CONTROL" we are gonna (Convert) to (Local-Variable) for debug purposes
	_gui_divide  = global._gui_divider;				// (Dont Touch-Default) || For Easier "CONTROL" we are gonna (Convert) to (Local-Variable) for debug purposes
	_v_multply	 = global._v_multply				// (Dont Touch-Default) || For Easier "CONTROL" we are gonna (Convert) to (Local-Variable) for debug purposes
	_f_screen    = global._fullscreen;				// (Dont Touch-Default) || For Easier "CONTROL" we are gonna (Convert) to (Local-Variable) for debug purposes
	_c_mode		 = global._cam_mode					// (Dont Touch-Default) || For (Remembering) If we change it, so we can (Comeback) to this mode again

	_debug_ui		= (k_DEBUG_UI_def);				// Camera's (Data) can be shown in the (Debug) Panele If this is || (True-False)
	_freedom		= (k_FREEDOM_MODE_def);			// If its "ACTIVE" Make's a (Boundless) "VIEW" and with that you can move (Freely)
	_optimize		= (k_OPTIMIZE_MODE_def);		// If you have "BIG" (Rooms) or so many (Objects) you can (Activate) this mode and witness a significant "FPS" increase || This mode is needed a little customization for your project bc this mode works with (Layers) so you gotta add your own (Special) layer's in step event to work perfectly
	_x_offset		= (k_CAM_X_OFFSET_def);			// Add a Offset to the camera for better perspective on the Target object
	_picked_delay	= (k_DELAY_TIME_def);			// Your own "TIME" choice can be made with this variable for your project
	_full_v_of_room = (k_FULL_VIEW_def);			// Picked (Special-Room) when Camera is in that (Room), (View) will be equal to that (Rooms) Width and Height || I (Cannot) guarantee that camera, will still be (Pixel-Perfect)
	_pixel_perfect  = (k_IS_GAME_PIXEL_def);		// (Pixel_Perfect)	|| "BOOLEAN" || System Forces Camera to be (Pixel_Perfect)
	_db_color		= (k_UI_COLOR_def);				// "UI" Color Picker can change from other objects

	xto			 = xstart;							// (Dont Touch-Default)
	yto			 = ystart;							// (Dont Touch-Default)
	offset		 = 0;								// (Dont Touch-Default)
	p_offset	 = 1;								// (Dont Touch-Default)
	_target		 = (k_TARGET_def);					// Select Camera's Target (Object)
	_target_only = true;							// (Target_Only) or (Not) || Only for Target (Needed) Cam Mode's

	_view_port   = (0);								// (Default) "VIEW_PORT" || (Can_Change)
	_port_width  = (0);								// (View_Port) Width	 || Doesnt Matter, We Will Adjust This (Below)
	_port_height = (0);								// (View_Port) Height	 || Doesnt Matter, We Will Adjust This (Below)

	_ideal_W = 0;									// (Dont Touch-Default) || Window (Width)  || Doesnt matter were gonna calculate this (Auto)
	_ideal_H = (k_VIEW_AND_RES_BASE_def[1]);		// (270|216|180)		|| Window (Height) || One of the Most important Variable that will be used to find (Resolution) ve (Surface) "START" Data

	_zoom_amount = 1;								// (Dont Touch-Default)
	_zoom_target = k_ZOOM_MULTPLY_def;				// (Dont Touch-Default)	|| (Open-Close) Zooming System's

	_game_sp = game_get_speed(gamespeed_fps);		// Game's "FPS" Based (Speed) for the Camera delays and such

	// Beginning (Setup's)
	#region Delay Timer (Setup's)
		switch (_picked_delay) {
			case "VERY_SLOW": _delay = (_game_sp / 0.5);	break;
			case "SLOW":	  _delay = (_game_sp / 1.5);	break;
			case "NORMAL":	  _delay = (_game_sp /   3);	break;
			case "FAST":	  _delay = (_game_sp /   6);	break;
			case "INSTANT":	  _delay = (_game_sp /  10);	break;
		}
	#endregion
	#region Setting's that will "DEPEND" on (Pixel-Perfect) mode's (On-Off) form "MULTPLY", "WIDTH" and "HEIGHT" If options are not right then (Auto) correct all or make the value's there (Default) form's
		k_pixel_perfection_checker = function() {	// (global._v_multply) If "NOT" (Pixel-Perfect) Desired Value's can work without making them convert to there (Default) form
			switch (_pixel_perfect) {
				// (global._v_multply) value to be (Pixel-Perfect) "GUARANTEE" value's must only be (Even Numbers or 1 or 0.5)
				case true:
					// For Pixel-Art game's for (Pixelating) the edges of the sprites
					if (k_OPTIMIZE_MODE_def) {display_reset(0, false);}
					else					 {display_reset(2, true);}

					if ((global._v_multply % 2) == 0 || global._v_multply == 1 || global._v_multply == 0.5) {		
						_v_W_Edit = _v_W * global._v_multply;			// (Dont Touch) || Camera (Width)  || This is a (Crucial) "VALUE" for The (Systems)
						_v_H_Edit = _v_H * global._v_multply;			// (Dont Touch) || Camera (Height) || This is a (Crucial) "VALUE" for The (Systems)
					} else {
						global._v_multply = 2;							// "NECESSARY" (Auto_Default)

						_v_W_Edit		  = _v_W * global._v_multply;	// "NECESSARY" (Auto_Default) || Camera (Width)  
						_v_H_Edit		  = _v_H * global._v_multply;	// "NECESSARY" (Auto_Default) || Camera (Height) 
					}
				break;

				// If it's "NOT" (Pixel-Perfect), Use (Default) Value's
				case false:
					// For Vectorel game's for (Rounding) the edges of the sprite's
					if (k_OPTIMIZE_MODE_def && display_aa < 12) {display_reset(4, false);}
					else										{display_reset(8, true);}

					_v_W_Edit = _v_W * global._v_multply;				// (Dont Touch) || Camera (Width)  || This is a (Crucial) "VALUE" for The (Systems)
					_v_H_Edit = _v_H * global._v_multply;				// (Dont Touch) || Camera (Height) || This is a (Crucial) "VALUE" for The (Systems)
				break;
			}
		}
		k_pixel_perfection_checker();	// Summon the function
	#endregion
	#region Camera (Setup's) - (Aspect_Ratio) and "DISPLAY" Setting's
		_display_W   = display_get_width();
		_display_H	 = display_get_height();
		aspect_ratio = (_display_W / _display_H);

		// Unless "BOUNDLESS" Mode is (Active) "NEVER" let the "RESOLUTION" Become Bigger Then The "DISPLAY" of the Monitor Screen
		if (!_freedom && ((_ideal_W * _r_multply) > _display_W || (_ideal_H * _r_multply)  > _display_H)) {
			_ideal_W = _display_W;						// Set "RESOLUTION" to "MAX" (Display_Width)
			_ideal_H = _display_H;						// Set "RESOLUTION" to "MAX" (Display_Height)

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

		// Create The Camera (Manuely) ------------(VERY_Important)-------------//
		global.koyan_cam = camera_create_view(0, 0, _v_W_Edit, _v_H_Edit, 0, -1, -1, -1, 0, 0);

		_v_W_Half = (camera_get_view_width(global.koyan_cam)  / 2);				// (Default-Dont Touch) || "CAMERA" (Standard-Width)  "HALF"
		_v_H_Half = (camera_get_view_height(global.koyan_cam) / 2);				// (Default-Dont Touch) || "CAMERA" (Standard-Height) "HALF"

		_v_X = camera_get_view_x(global.koyan_cam);								// (Default-Dont Touch) || "CAMERA" (Standard-X) "LEFT"
		_v_Y = camera_get_view_y(global.koyan_cam);								// (Default-Dont Touch) || "CAMERA" (Standard-Y) "TOP"

		// All (Rooms) Automatic Set-Ups -----------(VERY_Important)------------//
		_port_width  = (_ideal_W * (_r_multply));								// (Can_Change)
		_port_height = (_ideal_H * (_r_multply));								// (Can_Change)

		for (var i = 1; i <= room_last; i++) {
			if (room_exists(i)) {
				room_set_view_enabled(i, true);												// For "ALL" (Room's) Open  a (View)
				room_set_viewport(i, _view_port, true, 0, 0, _port_width, _port_height);	// For "ALL" (Room's) Setup a (Window) 
				room_set_camera(i, _view_port, global.koyan_cam);							// For "ALL" (Room's) Setup a (Kamera)
				
				view_set_camera(_view_port, global.koyan_cam);

				if (!view_enabled)				   {view_enabled = true;}					// (Force) "VIEW" to be (Active)
				if (!view_get_visible(_view_port)) {view_set_visible(_view_port, true);}	// (Force) "VIEW" to be (Visible)
			}
		}

		// Use the Correct (Camera) and (View)
		k_cam = view_get_camera(global.koyan_cam);
		view_set_camera(_view_port, global.koyan_cam);
	#endregion

	// (Script's) for Outside Usage
	#region Script that finds the Camera Spec's (Function)
		k_cam_display_specs = function(value) {

		// (Local) Variable's
		var g_width  = display_get_gui_width();
		var g_height = display_get_gui_height();
		var w_width  = window_get_width();
		var w_height = window_get_height();
		var s_width  = surface_get_width(application_surface);
		var s_height = surface_get_height(application_surface);
		var c_width  = camera_get_view_width(global.koyan_cam);
		var c_height = camera_get_view_height(global.koyan_cam);

		// Display (Enum's)
		enum k_display {_screen, _window, _gui, _app_surface, _view}

		// (Hesapla) ve (Yazdır)
		var str = "";
		switch(value) {
			case k_display._screen:		 str = "Monitor: "	+ string(_display_W) +"x"+ string(_display_H) +" ("+ string(_display_W / _display_H) +")";	break;
			case k_display._app_surface: str = "App_Sfc: "	+ string(s_width)	 +"x"+ string(s_height)	  +" ("+ string(s_width    / s_height) +")";	break;
			case k_display._window:		 str = "Window: "	+ string(w_width)	 +"x"+ string(w_height)	  +" ("+ string(w_width	   / w_height) +")";	break;
			case k_display._view:	     str = "View: "		+ string(c_width)	 +"x"+ string(c_height)	  +" ("+ string(c_width    / c_height) +")";	break;
			case k_display._gui:         str = "Gui: "		+ string(g_width)	 +"x"+ string(g_height)	  +" ("+ string(g_width    / g_height) +")";	break;
		}
		return str;
	}
	#endregion
	#region Better Visualizing for "FPS" Spec's (Function)
		k_fps_specs = function(value) {
			var performance = "";
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_alpha(1);

			// "FPS" Duruma göre (Renklendirme)
			if		(fps_real <  _game_sp)						{draw_set_color(c_red);		performance = "B A D";}		// "BAD"	  (Performance)
			else if (fps_real == _game_sp)						{draw_set_color(c_white);	performance = "STANDARD";}	// "STANDARD" (Performence)
			else if (fps_real  > _game_sp && fps_real < 1000)	{draw_set_color(c_lime);	performance = "G O O D;"}	// "GOOD"	  (Performance)
			else if (fps_real >= 1000)							{draw_set_color(c_yellow);	performance = "U L T R A";}	// "ULTRA"	  (Performance)
			else												{draw_set_color(c_black);	performance = "ERROR";}		// (Error) Color

			// "FPS" Yazdırmak
			draw_text(12, 24, "FPS: (" + string(floor(fps_real)) + ") " + string(performance));
		}
	#endregion
	#region Cam Mode "CHANGE"					(Function)
		global._cam_mode_change = function scr_cam_change(_mode, _followed_object) {

			// Only These "MODES" Need There Variable's Setup Again
			_c_mode = _mode;

			switch (_c_mode) {
				case "FOLLOW_TARGET":
				case "MOVE_TO_TARGET":
					_target = _followed_object;
				break;
			}
		}
	#endregion
	#region Screen_Shake						(Function)
		// (Magnitude) sets the strengh of the shake (radius in pixels)
		// (Frames)    sets the length of the shake in frames (60 = 1 second at 60 fps)
		global._screen_shake = function scr_screen_shake(_magnitude, _length) {
			if (_magnitude > _shake_Remain) {
				_shake_Magnitude = _magnitude;
				_shake_Remain	 = _magnitude;
				_shake_Length	 = _length;
			}
		}
	#endregion
	#region Zooming								(Function)
		global._zoom_amount = function scr_zooming(_target_amount) {_zoom_target = _target_amount;}
	#endregion

	// (Gui) System's ----------------(Important)-------------------//
	global._gui_W = round(_ideal_W / _gui_divide);					// (Default-Dont Touch)
	global._gui_H = round(_ideal_H / _gui_divide);					// (Default-Dont Touch)
	display_set_gui_size(global._gui_W, global._gui_H);				// (Default)

	// (Screen_Shake) Variable's
	_shake_Length	 = 0;
	_shake_Remain	 = 0;
	_shake_Magnitude = 0;

	// Mouse (Previous) Coordinate's
	_mouse_X_pre = -1;
	_mouse_Y_pre = -1;

	// (Resolution) Restriction
	_max_res = floor(abs((_display_W / _ideal_W) * (_display_H / _ideal_H)));		

	// Setup (Special) Alarm's -------------------------------------//
	pass = false;
	if (alarm[0] == -1)		 {alarm[0] = (_delay);}					// For (Checking)	 || (Dont_Touch)
	if (k_OPTIMIZE_MODE_def) {alarm[2] = (_delay);}					// For (Optimizing)	 || (Dont_Touch)

	// (Setup) Beginning of the Camera Setting's -------------------//
	camera_set_view_pos(global.koyan_cam, _v_X, _v_Y);				// "CAMERA" (View) "POZITION"
	camera_set_view_speed(global.koyan_cam, _v_X, _v_Y);			// "CAMERA" (View) "SPEED"
	camera_set_view_size(global.koyan_cam, _v_W_Edit, _v_H_Edit);	// "CAMERA" (View) "SIZE"

	// Print The (Start) Form of the Value's
	show_debug_message("\n|-----------------------| START |-------------------------|");
	show_debug_message("-Start_ROOM		   = ("	+ string(room_get_name(room))	+ ")");
	show_debug_message("-Start_FULL_Screen = ("	+ string(_f_screen)				+ ")");
	show_debug_message("-Start_VW_Multply  = ("	+ string(_v_multply)			+ ")");
	show_debug_message("-Start_RES_Multply = ("	+ string(_r_multply)			+ ")");
	show_debug_message("-Start_GUI_Divider = ("	+ string(_gui_divide)			+ ")");
	show_debug_message("-Start_FULL_Room   = (" + string(_full_v_of_room)		+ ")");
	show_debug_message("-Start_CAM_Mode    = ("	+ string(_c_mode)				+ ")");
	show_debug_message("-Start_UI_Mode     = (" + string(_debug_ui)				+ ")");
	show_debug_message("-----------------------------------------------------------");
	show_debug_message("-Start_VIEW_Width  = (" + string(_v_W_Edit)				+ ")");
	show_debug_message("-Start_VIEW_Height = (" + string(_v_H_Edit)				+ ")");
	show_debug_message("-Start_GUI_Width   = (" + string(global._gui_W)			+ ")");
	show_debug_message("-Start_GUI_Height  = (" + string(global._gui_H)			+ ")");
	show_debug_message("|---------------------------------------------------------|\n");
#endregion