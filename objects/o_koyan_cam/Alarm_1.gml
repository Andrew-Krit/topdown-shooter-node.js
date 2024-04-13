/// @desc Full_View's (Aftermath)
// Only Work, if (Full_View) is "NO LONGER" needed !!!!!!!
global._v_multply = k_VIEW_MULTPLY_def;		// (Before) Value's are (Now) Equal to there Changed (Global) Value's

// Rewind to Your (Usual) Setting's
k_pixel_perfection_checker();

// (Alert)
show_debug_message("|-| (" + string_upper(room_get_name(room_previous(room))) +") is over, converting ("+ string_upper(room_get_name(room)) + ") settings back to (Preferred) |-|");