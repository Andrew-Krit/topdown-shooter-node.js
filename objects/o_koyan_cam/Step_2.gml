/// @desc "X" Offset Setting's
if (instance_exists(_target)) {var previous = sign(_target.x-_target.xprevious);} else {var previous = 0;}
if (previous != 0)			  {p_offset     = previous;}

offset   = (_x_offset * p_offset);	// "X" Offset Shortcut Local Variable