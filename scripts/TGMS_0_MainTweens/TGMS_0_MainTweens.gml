// Feather ignore all
var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

/*
	User Functions:
		TweenFire
		TweenFireTo				-- SAFE TO DELETE
		TweenFireFrom			-- SAFE TO DELETE
		TweenCreate
		TweenPlay
		TweenPlayDelay			-- SAFE TO DELETE
		TweenMore				-- SAFE TO DELETE
		TweenScript				-- SAFE TO DELETE
		TweenMoreScript			-- SAFE TO DELETE
		TweenDefine				-- SAFE TO DELETE
		TweenDestroy
		TweenDestroySafe
		TweenDestroyWhenDone

	Support Functions:
		TGMS_TweenFire
		TGMS_TweenCreate
		TGMS_TweenPlay
		TGMS_TweenDefine		-- SAFE TO DELETE WITH TweenDefine
*/


/// @function TweenFire(target, ease, mode, delta, delay, dur, prop, start, dest, [...])
/// @param {Any} target		instance to associate with tween (id or object index)
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string (e.g. "x") or TP*() script 
/// @param {Any} start		starting value for eased property
/// @param {Any} dest		destination value for eased property
/// @param {Any} [...]		(optional) additional properties ("direction", 0, 360)
/// @return {Any}
/// @description			Tween a property between start/destination values (auto-destroyed)
function TweenFire(_target, _ease, _mode, _delta, _delay, _dur)
{
	/*
	    Info:
	        Eases a variable between a specified start and destination value over a set duration of time.
	        Additional properties can be added as optional arguments. Additional properties must use (property,start,dest) order.
    
	    Examples:
	        // Ease "x" value from (x) to (mouse_x), over 1 second
	        TweenFire(id, EaseInQuad, TWEEN_MODE_ONCE, true, 0.0, 1.0, "x", x, mouse_x);
        
	        // Ease "x" and "y" values from (x, y) to (mouse_x, mouse_y) over 60 steps with a 30 step delay.
	        // Tween will play back and forth, repeatedly.
	        TweenFire(obj_Player, EaseOutCubic, TWEEN_MODE_PATROL, false, 30, 60, x__, x, mouse_x, y__, y, mouse_y);
        
	    Note: 
	        TweenFire() is required. It's support script, TGMS_TweenFire(), is also required.  
	        However, additional *To/*From/*Create/*Play scripts can be safely deleted if desired.
	*/
	// Feather ignore all

	_target = _target.id;
	var _propCount = (argument_count-6) div 3;
	var _data;

	// ** Single Property ** //

	if (_propCount == 1)
	{   
	    var _propRaw = argument[6];
	
	    if (is_array(_propRaw)) // Advanced Properties
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        {
				// _data = DATA | START | DESTINATION
				_data = [_propRaw[1], argument[7], argument[8]];
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], _ease, _mode, _delta, _delay, _dur, 0, 1, _data);
	        }
	        else
	        {
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], _ease, _mode, _delta, _delay, _dur, argument[7], argument[8], _propRaw[1]);
	        }
	    }
	    else // Standard Properties
	    { 
			if (ds_map_exists(global.__PropertySetters__, _propRaw)) // look for optimised script
			{
				// normalized property
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) 
		        {
					// _data = START | DESTINATION
					_data = [argument[7], argument[8]];
		            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], _ease, _mode, _delta, _delay, _dur, 0, 1, _data);
		        }
		        else // optimised property
				if (ds_map_exists(global.__PropertySetters__, _propRaw)) 
		        {	
		            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], _ease, _mode, _delta, _delay, _dur, argument[7], argument[8]);
		        }
			}
			else // Dynamic Property
			{
				return TGMS_TweenFire(_target, argument[6], _ease, _mode, _delta, _delay, _dur, argument[7], argument[8]);
			}
	    }
	}

	// ** Multi Property ** //

	var _argIndex = 5, _extIndex = 0, _extData;
	_extData[_propCount*5] = 0;
	_extData[0] = _propCount; // Set first ext-data to count of properties

	repeat(_propCount)
	{
	    var _propRaw = argument[++_argIndex];

	    if (is_array(_propRaw)) // Extended Properties
	    {
	        // Track raw property function index
	        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]];
        
	        // Set property data based on standard/normalized types
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        {   // Normalized Property
	            _data = array_create(3);
	            _data[0] = _propRaw[1]; // data
	            _data[1] = argument[++_argIndex]; // real start value
	            _data[2] = argument[++_argIndex]; // real destination value
	            _extData[++_extIndex] = 0; // normalized start
	            _extData[++_extIndex] = 1; // normalized destination
	            _extData[++_extIndex] = _data; // data
	        }
	        else
	        {   // Standard Property =================
	            _extData[++_extIndex] = argument[++_argIndex]; // start
	            _extData[++_extIndex] = argument[++_argIndex]; // destination
	            _extData[++_extIndex] = _propRaw[1]; // Property Data
	        }
		
			_extData[++_extIndex] = ""; // Reserved for dynamic property
	    }
	    else // Standard Properties
	    {
			if (ds_map_exists(global.__PropertySetters__, _propRaw))
			{
				// Track raw property function index
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
		        {    
					// Normalized Property
		            _data = array_create(2);
		            _data[0] = argument[++_argIndex]; // real start value
		            _data[1] = argument[++_argIndex]; // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
		            _extData[++_extIndex] = _data; // data
		        }
		        else
		        {
					// Standard Property
		            _extData[++_extIndex] = argument[++_argIndex]; // start
		            _extData[++_extIndex] = argument[++_argIndex]; // destination
		            _extData[++_extIndex] = _target; // target
		        }
			
				_extData[++_extIndex] = "" // Reserved for dynamic property
			}
			else // Dynamic Property
			{
				// Determine instance/global property setter
				if (variable_instance_exists(_target, _propRaw))
				{
					_extData[++_extIndex] = TGMS_Variable_Instance_Set;
				}
				else
				{
					_extData[++_extIndex] = TGMS_Variable_Global_Set;
				}

		        _extData[++_extIndex] = argument[++_argIndex]; // start
		        _extData[++_extIndex] = argument[++_argIndex]; // destination
				_extData[++_extIndex] = _target; // target
				_extData[++_extIndex] = _propRaw; // variable string
			}
	    }
    
	    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
	    _extData[++_extIndex] = _propRaw;
	}

	return TGMS_TweenFire(_target, TGMS_MultiPropertySetter__, _ease, _mode, _delta, _delay, _dur, 0, 1, _extData);
}_=TweenFire;


/// @function TweenFireTo(target, ease, mode, delta, delay, dur, prop, to, [...])
/// @param {Any} target		instance to associate with tween (id or object index)
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} to			value to ease property to
/// @param {Any} [...]		(optional) additional properties ("image_angle", 360)
/// @return {Any}
/// @description			Tween a property to a destination value (auto-destroyed)
function TweenFireTo(_target, _ease, _mode, _delta, _delay, _dur) 
{
	// Feather ignore all
	/*
	    Info:
	        Eases a variable to a destination value over a set duration of time.
	        Additional properties can be added as optional arguments. Additional properties must use (property,dest) order.
    
	    Examples:
	        // Ease "x" value from (x) to (mouse_x), over 1 second
	        TweenFireTo(id, EaseInQuad, TWEEN_MODE_ONCE, true, 0.0, 1.0, "x", x, mouse_x);
        
	        // Ease "x" and "y" values to (mouse_x, mouse_y) over 60 steps with a 30 step delay.
	        // Tween will play back and forth, repeatedly.
	        TweenFireTo(id, EaseOutCubic, TWEEN_MODE_PATROL, false, 30, 60,
	            "x", mouse_x,
	            "y", mouse_y);
	*/

	_target = _target.id;
	var _propCount = (argument_count-6) div 2;
	var _data;

	// ** Single Property ** //

	if (_propCount == 1)
	{
	    var _propRaw = argument[6];
    
	    if (is_array(_propRaw)) // Advanced Property
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        { // Normalized
				_data = array_create(3);
	            _data[0] = _propRaw[1]; // data    
	            _data[1] = global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target); // start
	            _data[2] = argument[7]; // destination
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], _ease, _mode, _delta, _delay, _dur, 0, 1, _data);
	        }
	        else
	        { // Not normalized
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], _ease, _mode, _delta, _delay, _dur, global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target), argument[7], _propRaw[1]);
	        }   
	    }
	    else // Standard Property
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // Normalized Property
	        {
				_data = array_create(2);
	            _data[0] = global.__PropertyGetters__[? _propRaw](_target); // start
	            _data[1] = argument[7]; // destination
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], _ease, _mode, _delta, _delay, _dur, 0, 1, _data);
	        }
	        else
			if (ds_map_exists(global.__PropertySetters__, _propRaw)) // Optimised Property
	        {
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], _ease, _mode, _delta, _delay, _dur, global.__PropertyGetters__[? _propRaw](_target), argument[7]);
	        }
			else // Dynamic Property
			{
				var _variable = argument[6];
				var _dest;
			
				if (variable_instance_exists(_target, _variable))
				{
					_dest = variable_instance_get(_target, _variable);
				}
				else
				{
					_dest = variable_global_get(_variable);
				}
			
				return TGMS_TweenFire(_target, _variable, _ease, _mode, _delta, _delay, _dur, _dest, argument[7]);
			}
	    }
	}

	// ** Multi Property ** //

	var _argIndex = 5, _extIndex = 0, _extData;
	_extData[_propCount*5] = 0;
	_extData[0] = _propCount; // Set first ext-data to count of properties

	repeat(_propCount)
	{
	    var _propRaw = argument[++_argIndex];

	    if (is_array(_propRaw)) // Extended Properties
	    {
	        // Track raw property function index
	        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]]; // Raw property Script?
        
	        // Set property data based on standard/normalized types
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        {   // Normalized Property
	            _data = array_create(3);
	            _data[0] = _propRaw[1]; // data
	            _data[1] = argument[++_argIndex]; // real start value
	            _data[2] = argument[++_argIndex]; // real destination value
	            _extData[++_extIndex] = 0; // normalized start
	            _extData[++_extIndex] = 1; // normalized destination
	            _extData[++_extIndex] = _data; // data
	        }
	        else
	        {   // Standard Property =================
	            _extData[++_extIndex] = global.__PropertyGetters__[? _propRaw[0]]( _propRaw[1], _target); // start
	            _extData[++_extIndex] = argument[++_argIndex]; // destination
	            _extData[++_extIndex] = _propRaw[1]; // Property Data
	        }
		
			_extData[++_extIndex] = ""; // Reserved for dynamic property
	    }
	    else // Standard Properties
	    {
			if (ds_map_exists(global.__PropertySetters__, _propRaw))
			{
				// Track raw property
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
		        {    
					// Normalized Property
		            _data = array_create(2);
		            _data[0] = global.__PropertyGetters__[? _propRaw](_target); // real start value
		            _data[1] = argument[++_argIndex]; // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
		            _extData[++_extIndex] = _data; // data
		        }
		        else
		        {
					// Standard Property
		            _extData[++_extIndex] = global.__PropertyGetters__[? _propRaw](_target); // start
		            _extData[++_extIndex] = argument[++_argIndex]; // destination
		            _extData[++_extIndex] = _target; // target
		        }
			
				_extData[++_extIndex] = "" // Reserved for dynamic property
			}
			else // Dynamic Property
			{
				// Determine instance/global property setter
				if (variable_instance_exists(_target, _propRaw))
				{
					_extData[++_extIndex] = TGMS_Variable_Instance_Set;
					_extData[++_extIndex] = variable_instance_get(_target, _propRaw); // start
				}
				else
				{
					_extData[++_extIndex] = TGMS_Variable_Global_Set;
					_extData[++_extIndex] = variable_global_get(_propRaw); // start
				}

		        _extData[++_extIndex] = argument[++_argIndex]; // destination
				_extData[++_extIndex] = _target; // target
				_extData[++_extIndex] = _propRaw; // variable string
			}
	    }
    
	    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
	    _extData[++_extIndex] = _propRaw;
	}

	return TGMS_TweenFire(_target, TGMS_MultiPropertySetter__, _ease, _mode, _delta, _delay, _dur, 0, 1, _extData);
}_=TweenFireTo;


/// @function TweenFireFrom(target, ease, mode, delta, delay, dur, prop, from, [...])
/// @param {Any} target	instance to associate with tween (id or object index)
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} from		value to ease property from
/// @param {Any} [...]		(optional) additional properties ("image_angle", 360)
/// @return {Any}
/// @description			Tween a property from a start value (auto-destroyed)
function TweenFireFrom(_target, _ease, _mode, _delta, _delay, _dur)
{
	// Feather ignore all
	/*
	    Info:
	        Eases a variable from a starting position over a set duration of time.
	        Additional properties can be added as optional arguments. Additional properties must use (property,start) order.
    
	    Examples:
	        // Ease "x" value from (mouse_x), over 1 second
	        TweenFireFrom(id, EaseInQuad, TWEEN_MODE_ONCE, true, 0.0, 1.0, "x", mouse_x);
        
	        // Ease "x" and "y" values from (mouse_x, mouse_y) over 60 steps with a 30 step delay.
	        // Tween will play back and forth, repeatedly.
	        TweenFireFrom(id, EaseOutCubic, TWEEN_MODE_PATROL, false, 30, 60,
	            "x", mouse_x,
	            "y", mouse_y);
	*/

	_target = _target.id;
	var _propCount = (argument_count-6) div 2;
	var _data;

	// ** Single Property ** //

	if (_propCount == 1)
	{
	    var _propRaw = argument[6];
    
	    if (is_array(_propRaw)) // Advanced Property
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        { // Normalized
				_data = array_create(3);
	            _data[0] = _propRaw[1]; // data    
				_data[1] = argument[7]; // start
	            _data[2] = global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target); // destination
            
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], _ease, _mode, _delta, _delay, _dur, 0, 1, _data);
	        }
	        else
	        { // Not normalized
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw[0]], _ease, _mode, _delta, _delay, _dur, argument[7], global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target), _propRaw[1]);
	        }   
	    }
	    else // Standard Property
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // Normalized Property
	        {
				_data = array_create(2);
				_data[0] = argument[7]; // start
	            _data[1] = global.__PropertyGetters__[? _propRaw](_target); // destination
            
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], _ease, _mode, _delta, _delay, _dur, 0, 1, _data);
	        }
	        else
			if (ds_map_exists(global.__PropertySetters__, _propRaw)) // Optimised Property
	        {
	            return TGMS_TweenFire(_target, global.__PropertySetters__[? _propRaw], _ease, _mode, _delta, _delay, _dur, argument[7], global.__PropertyGetters__[? _propRaw](_target));
	        }
			else // Dynamic Property
			{
				var _variable = argument[6];
				var _dest
			
				if (variable_instance_exists(_target, _variable))
				{
					_dest = variable_instance_get(_target, _variable);
				}
				else
				{
					_dest = variable_global_get(_variable);
				}
			
				return TGMS_TweenFire(_target, _variable, _ease, _mode, _delta, _delay, _dur, argument[7], _dest);
			}
	    }
	}

	// ** Multi Property ** //

	var _argIndex = 5, _extIndex = 0, _extData;
	_extData[_propCount*5] = 0;
	_extData[0] = _propCount; // Set first ext-data to count of properties

	repeat(_propCount)
	{
	    var _propRaw = argument[++_argIndex];

	    if (is_array(_propRaw)) // Extended Properties
	    {
	        // Track raw property function index
	        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]]; // Raw property Script?
        
	        // Set property data based on standard/normalized types
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        {   // Normalized Property
	            _data = array_create(3);
	            _data[0] = _propRaw[1]; // data
	            _data[1] = argument[++_argIndex]; // real start value           // :: THIS SEEMS WRONG TO ME -- NORMALIZED ADVANCED PROPERTY
	            _data[2] = argument[++_argIndex]; // real destination value
	            _extData[++_extIndex] = 0; // normalized start
	            _extData[++_extIndex] = 1; // normalized destination
	            _extData[++_extIndex] = _data; // data
	        }
	        else
	        {   // Standard Property =================
				_extData[++_extIndex] = argument[++_argIndex]; // start
				_extData[++_extIndex] = global.__PropertyGetters__[? _propRaw[0]](_propRaw[1], _target); // dest
	            _extData[++_extIndex] = _propRaw[1]; // Property Data
	        }
		
			_extData[++_extIndex] = ""; // Reserved for dynamic property
	    }
	    else // Standard Properties
	    {
			if (ds_map_exists(global.__PropertySetters__, _propRaw))
			{
				// Track raw property
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
		        {    
					// Normalized Property
		            _data = array_create(2);
					_data[0] = argument[++_argIndex]; // real start value
		            _data[1] = global.__PropertyGetters__[? _propRaw](_target); // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
		            _extData[++_extIndex] = _data; // data
		        }
		        else
		        {
					// Standard Property
					_extData[++_extIndex] = argument[++_argIndex]; // start
		            _extData[++_extIndex] = global.__PropertyGetters__[? _propRaw](_target); // destination
		            _extData[++_extIndex] = _target; // target
		        }
			
				_extData[++_extIndex] = "" // Reserved for dynamic property
			}
			else // Dynamic Property
			{
				// Determine instance/global property setter
				if (variable_instance_exists(_target, _propRaw))
				{
					_extData[++_extIndex] = TGMS_Variable_Instance_Set;
					_extData[++_extIndex] = argument[++_argIndex]; // start
					_extData[++_extIndex] = variable_instance_get(_target, _propRaw); // dest
				}
				else
				{
					_extData[++_extIndex] = TGMS_Variable_Global_Set;
					_extData[++_extIndex] = argument[++_argIndex]; // start
					_extData[++_extIndex] = variable_global_get(_propRaw); // dest
				}

				_extData[++_extIndex] = _target; // target
				_extData[++_extIndex] = _propRaw; // variable string
			}
	    }
    
	    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
	    _extData[++_extIndex] = _propRaw;
	}

	return TGMS_TweenFire(_target, TGMS_MultiPropertySetter__, _ease, _mode, _delta, _delay, _dur, 0, 1, _extData);
}_=TweenFireFrom;


/// @function TweenCreate(target, [ease, mode, delta, delay, dur, prop, start, dest, ...]);
/// @param {Any} target		instance to associate with tween (id or object index)
/// @param {Any} [ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} start		starting value for eased property
/// @param {Any} dest]		destination value for eased property
/// @param {Any} ...		additional properties -- e.g. ("direction", 0, 360)
/// @return {Any}
/// @description			Create a tween to be started with TweenPlay*() (not auto-destroyed)
function TweenCreate()
{
	/*
		Creates and returns a new tween. The tween does not start right away, but must
		be played with the TweenPlay*() scripts.
		Unlike TwenFire*(), tweens created with TweenCreate() will exist in memory until their
		target instance is destroyed or TweenDestroy(tween) is called.
		You can set them to auto-destroy with TweenDestroyWhenDone():
	
		Defining a tween at creation is optional. Both of the following are valid:
			tween1 = TweenCreate(id);
			tween2 = TweenCreate(id, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
			TweenDestroyWhenDone(tween2, true); // Have tween auto-destroy when finished
	*/
	// Feather ignore all

	if (argument_count == 1)
	{
	    return TGMS_TweenCreate(argument[0].id);
	}

	var _target = argument[0].id;
	var _propCount = (argument_count-6) div 3;
	var _data;

	// ** Single Property ** //

	if (_propCount == 1)
	{   
	    var _propRaw = argument[6];
    
	    if (is_array(_propRaw)) // Advanced Properties
	    {
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        {
				_data = array_create(3);
	            _data[0] = _propRaw[1]; // data
	            _data[1] = argument[7]; // start
	            _data[2] = argument[8]; // destination
	            return TGMS_TweenCreate(_target, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
	        }
	        else
	        {
	            return TGMS_TweenCreate(_target, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8], _propRaw[1]);
	        }
	    }
	    else // Standard Properties
	    { 
			if (ds_map_exists(global.__PropertySetters__, _propRaw)) // look for optimised script
			{
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // normalized property
		        {
					_data = array_create(2);
		            _data[0] = argument[7];
		            _data[1] = argument[8];
		            return TGMS_TweenCreate(_target, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
		        }
		        else
				if (ds_map_exists(global.__PropertySetters__, _propRaw)) // optimised property
		        {
		            return TGMS_TweenCreate(_target, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
		        }
			}
			else // Dynamic Property
			{
				return TGMS_TweenCreate(_target, argument[6], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
			}
	    }
	}

	// ** Multi Property ** //

	var _argIndex = 5, _extIndex = 0, _extData;
	_extData[_propCount*5] = 0;
	_extData[0] = _propCount; // Set first ext-data to count of properties

	repeat(_propCount)
	{
	    var _propRaw = argument[++_argIndex];

	    if (is_array(_propRaw)) // Extended Properties
	    {
	        // Track raw property function index
	        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]]; // Raw property Script?
        
	        // Set property data based on standard/normalized types
	        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
	        {   // Normalized Property
	            _data = array_create(3);
	            _data[0] = _propRaw[1]; // data
	            _data[1] = argument[++_argIndex]; // real start value
	            _data[2] = argument[++_argIndex]; // real destination value
	            _extData[++_extIndex] = 0; // normalized start
	            _extData[++_extIndex] = 1; // normalized destination
				_extData[++_extIndex] = _data; // data
	        }
	        else
	        {   // Standard Property =================
	            _extData[++_extIndex] = argument[++_argIndex]; // start
	            _extData[++_extIndex] = argument[++_argIndex]; // destination
	            _extData[++_extIndex] = _propRaw[1]; // Property Data
	        }
		
			_extData[++_extIndex] = ""; // Reserved for dynamic property
	    }
	    else // Standard Properties
	    {
			if (ds_map_exists(global.__PropertySetters__, _propRaw))
			{
				// Track raw property function index
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
		        {    
					// Normalized Property
		            _data = array_create(2);
		            _data[0] = argument[++_argIndex]; // real start value
		            _data[1] = argument[++_argIndex]; // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
		            _extData[++_extIndex] = _data; // data
		        }
		        else
		        {
					// Standard Property
		            _extData[++_extIndex] = argument[++_argIndex]; // start
		            _extData[++_extIndex] = argument[++_argIndex]; // destination
		            _extData[++_extIndex] = _target; // target
		        }
			
				_extData[++_extIndex] = "" // Reserved for dynamic property
			}
			else // Dynamic Property
			{
				// Determine instance/global property setter
				if (variable_instance_exists(_target, _propRaw))
				{
					_extData[++_extIndex] = TGMS_Variable_Instance_Set;
				}
				else
				{
					_extData[++_extIndex] = TGMS_Variable_Global_Set;
				}

		        _extData[++_extIndex] = argument[++_argIndex]; // start
		        _extData[++_extIndex] = argument[++_argIndex]; // destination
				_extData[++_extIndex] = _target; // target
				_extData[++_extIndex] = _propRaw; // variable string
			}
	    }
    
	    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
	    _extData[++_extIndex] = _propRaw;
	}

	return TGMS_TweenCreate(_target, TGMS_MultiPropertySetter__, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _extData);
}


/// @function TweenPlay(tween, [ease, mode, delta, delay, dur, prop, start, dest, ...])
/// @param {Any} tween		tween{s} id of previously created tween
/// @param {Any} [ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} start		starting value for eased property
/// @param {Any} dest]		destination value for eased property
/// @param {Any} ...		(optional) additional properties ("direction", 0, 360)
/// @return {Any}
/// @description			Plays a tween previously created with TweenCreate()
function TweenPlay()
{
	/*
		Plays a tween or selected tweens previously created with TweenCreate*()
	
		Defining a tween at creation is optional. Both of the following are valid:
		
			tween1 = TweenCreate(id);
			tween2 = TweenCreate(id, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
			TweenPlay(tween1, EaseInQuad, 0, true, 0, 1.0, "a", 0, 100);
			TweenPlay(tween2);
	*/
	// Feather ignore all

	var _t = argument[0];

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
		var _tID = _t[TWEEN.ID];

		if (argument_count == 1)
		{
		    return TGMS_TweenPlay(_tID);
		}

		var _target = _t[TWEEN.TARGET];
		var _propCount = (argument_count-6) div 3;
		var _data;

		// ** Single Property ** //

		if (_propCount == 1)
		{   
		    var _propRaw = argument[6];
    
		    if (is_array(_propRaw)) // Advanced Properties
		    {
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
		        {
					// _data = DATA | START | DESTINATION
					_data = [_propRaw[1], argument[7], argument[8]];
		            return TGMS_TweenPlay(_tID, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
		        }
		        else
		        {
		            return TGMS_TweenPlay(_tID, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8], _propRaw[1]);
		        }
		    }
		    else // Standard Properties
		    { 
				if (ds_map_exists(global.__PropertySetters__, _propRaw)) // look for optimised script
				{
			        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // normalized property
			        {
						// _data = START | DESTINATION
						_data = [argument[7], argument[8]];
			            return TGMS_TweenPlay(_tID, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
			        }
			        else // optimised property
					if (ds_map_exists(global.__PropertySetters__, _propRaw))
			        {
			            return TGMS_TweenPlay(_tID, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
			        }
				}
				else // Dynamic Property
				{
					return TGMS_TweenPlay(_tID, argument[6], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
				}
		    }
		}

		// ** Multi Property ** //

		var _argIndex = 5, _extIndex = 0, _extData;
		_extData[_propCount*5] = 0;
		_extData[0] = _propCount; // Set first ext-data to count of properties

		repeat(_propCount)
		{
		    var _propRaw = argument[++_argIndex];

		    if (is_array(_propRaw)) // Extended Properties
		    {
		        // Track raw property function index
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
		        {   // Normalized Property
		            _data = array_create(3);					
		            _data[0] = _propRaw[1]; // data
		            _data[1] = argument[++_argIndex]; // real start value
		            _data[2] = argument[++_argIndex]; // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
		            _extData[++_extIndex] = _data; // data
		        }
		        else
		        {   // Standard Property =================
		            _extData[++_extIndex] = argument[++_argIndex]; // start
		            _extData[++_extIndex] = argument[++_argIndex]; // destination
		            _extData[++_extIndex] = _propRaw[1]; // Property Data
		        }
		
				_extData[++_extIndex] = ""; // Reserved for dynamic property
		    }
		    else // Standard Properties
		    {
				if (ds_map_exists(global.__PropertySetters__, _propRaw))
				{
					// Track raw property function index
			        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw];
        
			        // Set property data based on standard/normalized types
			        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
			        {    
						// Normalized Property
			            _data = array_create(2);
			            _data[0] = argument[++_argIndex]; // real start value
			            _data[1] = argument[++_argIndex]; // real destination value
			            _extData[++_extIndex] = 0; // normalized start
			            _extData[++_extIndex] = 1; // normalized destination
			            _extData[++_extIndex] = _data; // data
			        }
			        else
			        {
						// Standard Property
			            _extData[++_extIndex] = argument[++_argIndex]; // start
			            _extData[++_extIndex] = argument[++_argIndex]; // destination
			            _extData[++_extIndex] = _target; // target
			        }
			
					_extData[++_extIndex] = "" // Reserved for dynamic property
				}
				else // Dynamic Property
				{
					// Determine instance/global property setter
					if (variable_instance_exists(_target, _propRaw))
					{
						_extData[++_extIndex] = TGMS_Variable_Instance_Set;
					}
					else
					{
						_extData[++_extIndex] = TGMS_Variable_Global_Set;
					}

			        _extData[++_extIndex] = argument[++_argIndex]; // start
			        _extData[++_extIndex] = argument[++_argIndex]; // destination
					_extData[++_extIndex] = _target; // target
					_extData[++_extIndex] = _propRaw; // variable string
				}
		    }
    
		    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
		    _extData[++_extIndex] = _propRaw;
		}

		return TGMS_TweenPlay(_tID, TGMS_MultiPropertySetter__, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _extData);
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenPlay);
	}

	return undefined;
}


/// @function TweenPlayDelay(tween{s}, delay)
/// @param {Any} tween{s}	id of previously created/defined tween{s}
/// @param {Any} delay		amount of time to delay start
/// @description			Plays tween{s} defined with TweenCreate*() after a set delay
function TweenPlayDelay(_t, _delay)
{
	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    _t[@ TWEEN.DELAY_START] = _delay;
	    TweenPlay(_t[TWEEN.ID]);
	}
    
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenPlayDelay, _delay);
	}
}


/// @function TweenMore(tween, target, ease, mode, delta, delay, dur, prop, start, dest, [...])
/// @param {Any} tween		tween id
/// @param {Any} target		instance to associate with tween (id or object index)
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} start		starting value for eased property
/// @param {Any} dest		destination value for eased property
/// @param {Any} [...]		(optional) additional properties ("direction", 0, 360)
/// @return {Any}
/// @description			Allows chaining of tweens by adding tween to be fired after indicated tween finishes
function TweenMore(_tween, _target)
{
	/*
	    Info:
			Allows for chaining of tweens by adding a tween to be fired after the indicated tween finishes.
			Multiple new tweens can be added to the same tween, allowing for branching chains.
			Tween is automatically destroyed when finished, stopped, or if its associated target instance is destroyed.
			Returns unique tween id.   
    
	    Examples:
	        // Chain various tweens to fire one after another
			tween1 = TweenFire(id, EaseOutBounce, 0, true, 0, 1.0, "y", -100, y);
			tween2 = TweenMore(tween1, id, EaseInOutQuad, 0, true, 0, 0.5, "image_yscale", 1, 0.25);
			tween3 = TweenMore(tween1, id, EaseInOutSine, 0, true, 0, 1.0, "image_angle", 0, 360);
			tween4 = TweenMore(tween3, id, EaseInOutQuad, 0, true, 0, 2.0, "image_xscale", 1, 0.5);
	*/

	var _newTween;

	switch((argument_count-7) div 3)
	{
		case 1:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
		case 2:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
		case 3:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15]); break;
		case 4:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18]); break;
		case 5:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21]); break;
		case 6:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24]); break;
		case 7:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27]); break;
		case 8:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27], argument[28], argument[29], argument[30]); break;
		case 9:  _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27], argument[28], argument[29], argument[30], argument[31], argument[32], argument[33]); break;
		case 10: _newTween = TweenCreate(_target, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20], argument[21], argument[22], argument[23], argument[24], argument[25], argument[26], argument[27], argument[28], argument[29], argument[30], argument[31], argument[32], argument[33], argument[34], argument[35], argument[36]); break;
		// If you really need more cases, you can extend this as needed.
		default: show_error("TweenMore() -> Max argument count exceeded!", false);
	}

	TweenAddCallback(_tween, TWEEN_EV_FINISH, _target, TweenPlay, _newTween);
	TweenDestroyWhenDone(_newTween, true); // Have tween auto-destroy
	return _newTween;
}


/// @function TweenScript(target, delta, dur, script, [arg0,...])
/// @param {Any} target		target instance
/// @param {Any} delta		use seconds timing? (true=seconds | false = steps)
/// @param {Any} dur		duration of time before script is called
/// @param {Any} script		script to execute when timer expires
/// @param {Any} [arg0...]	(optional) additional arguments to pass to script
/// @return {Any}
/// @description			Schedules a script to be executed after a set duration of time
function TweenScript()
{
	/*
	    Info:
	        Schedules a script to be executed after a set duration of time.
	        Since this uses the tweening system, the returned tween script works with any regular tweening scripts,
			such as TweenPause(), TweenResume(), TweenMore(), etc...
    
	    Examples:
			// Display a message after 1 second
	        ts = TweenScript(id, true, 1.0, ShowMessage, "Hello, World!");
		
			// Schedule another script to be fired 2 seconds after first one finishes
			ts = TweenMoreScript(ts, id, true, 2.0, ShowMessage, "Goodbye, World!");
		
			// Fire a tween after showing second message
			t = TweenMore(ts, id, EaseInOutQuad, 0, true, 0.0, 1.0, "image_scale", 1.0, 0.0); 
	*/
	// Feather ignore all

	static _null = method_get_index(function(){});
	
	var _t = TweenFire(argument[0], _null, 0, argument[1], 0, argument[2]);

	switch(argument_count-4)
	{
		case 0:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3]); break;
		case 1:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4]); break;
		case 2:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5]); break;
		case 3:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6]); break;
		case 4:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7]); break;
		case 5:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]); break;
		case 6:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
		case 7:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
		case 8:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
		case 9:  TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
		case 10: TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
		case 11: TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14]); break;
		case 12: TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15]); break;
		case 13: TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16]); break;
		case 14: TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17]); break;
		case 15: TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18]); break;
		case 16: TweenAddCallback(_t, TWEEN_EV_FINISH, argument[0], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19]); break;
	}

	return _t;
}_=TweenScript;


/// @function TweenMoreScript(tween, target, delta, dur, script, [arg0, ...])
/// @param {Any} tween		tween id
/// @param {Any} target		target instance
/// @param {Any} delta		use seconds timing? (true=seconds | false = steps)
/// @param {Any} dur		duration of time before script is called
/// @param {Any} script		script to execute when timer expires
/// @param {Any} [arg0...]	(optional) additional arguments to pass to script
/// @return {Any}
/// @description			Allows for the chaining of script scheduling
function TweenMoreScript()
{
	/*
	    Info:
	        Allows for the chaining of script scheduling.
	        Since this uses the tweening system, the returned tween script works with any regular tweening scripts,
			such as TweenPause(), TweenResume(), TweenMore(), etc...
    
	    Examples:
			// Display a message after 1 second
	        ts = TweenScript(id, true, 1.0, ShowMessage, "Hello, World!");
		
			// Schedule another script to be fired 2 seconds after first one finishes
			ts = TweenMoreScript(ts, id, true, 2.0, ShowMessage, "Goodbye, World!");
		
			// Fire a tween after showing second message
			t = TweenMore(ts, id, EaseInOutQuad, 0, true, 0.0, 1.0, "image_scale", 1.0, 0.0); 
	*/

	static _null = method_get_index(function(){});

	var _t = argument[0];
	var _target = argument[1];
	var _newTween = TweenCreate(_target, _null, 0, argument[2], 0, argument[3]);
	TweenDestroyWhenDone(_newTween, true);
	TweenAddCallback(_t, TWEEN_EV_FINISH, _target, TweenPlay, _newTween);

	switch(argument_count-5)
	{
		case 0:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4]); break;
		case 1:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5]); break;
		case 2:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6]); break;
		case 3:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7]); break;
		case 4:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8]); break;
		case 5:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
		case 6:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
		case 7:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
		case 8:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
		case 9:  TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
		case 10: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14]); break;
		case 11: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15]); break;
		case 12: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16]); break;
		case 13: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17]); break;
		case 14: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18]); break;
		case 15: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19]); break;
		case 16: TweenAddCallback(_newTween, TWEEN_EV_FINISH, _target, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15], argument[16], argument[17], argument[18], argument[19], argument[20]); break;
	}

	return _newTween;
}_=TweenMoreScript;


/// @function TweenDefine(tween, ease, mode, delta, delay, dur, prop, start, dest, [...])
/// @param tween	tween id of previously created tween
/// @param ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param delta	whether or not to use delta(seconds) timing -- false will use step timing
/// @param delay	amount of time to delay tween before playing
/// @param dur		duration of time to play tween
/// @param prop		property setter string or TP*() script
/// @param start	starting value for eased property
/// @param dest		destination value for eased property
/// @param [...]	(optional) additional properties ("direction", 0, 360)
/// @return {Any}
/// @description	Defines a tween previously created with TweenCreate()
function TweenDefine()
{
	
	/*
		[INFO]
			Defines a previously created tween.
		
		[EXAMPLE]
			tween = TweenCreate(id);
			TweenDefine(tween, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
			TweenPlay(tween);
	*/

	var _t = argument[0];

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
		var _tID = _t[TWEEN.ID];
		var _target = _t[TWEEN.TARGET];
		var _propCount = (argument_count-6) div 3;
		var _data;

		// ** Single Property ** //

		if (_propCount == 1)
		{   
		    var _propRaw = argument[6];
    
		    if (is_array(_propRaw)) // Advanced Properties
		    {
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
		        {
					// _data = DATA | START | DESTINATION
					_data = [_propRaw[1], argument[7], argument[8]];
		            return TGMS_TweenDefine(_tID, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
		        }
		        else
		        {
		            return TGMS_TweenDefine(_tID, global.__PropertySetters__[? _propRaw[0]], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8], _propRaw[1]);
		        }
		    }
		    else // Standard Properties
		    { 
				if (ds_map_exists(global.__PropertySetters__, _propRaw)) // look for optimised script
				{
			        if (ds_map_exists(global.__NormalizedProperties__, _propRaw)) // normalized property
			        {
			            // _data = START | DESTINATION
						_data = [argument[7], argument[8]];
			            return TGMS_TweenDefine(_tID, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _data);
			        }
			        else // optimised property
					if (ds_map_exists(global.__PropertySetters__, _propRaw))
			        {
			            return TGMS_TweenDefine(_tID, global.__PropertySetters__[? _propRaw], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
			        }
				}
				else // Dynamic Property
				{
					return TGMS_TweenDefine(_tID, argument[6], argument[1], argument[2], argument[3], argument[4], argument[5], argument[7], argument[8]);
				}
		    }
		}

		// ** Multi Property ** //

		var _argIndex = 5, _extIndex = 0, _extData;
		_extData[_propCount*5] = 0;
		_extData[0] = _propCount; // Set first ext-data to count of properties

		repeat(_propCount)
		{
		    var _propRaw = argument[++_argIndex];

		    if (is_array(_propRaw)) // Extended Properties
		    {
		        // Track raw property function index
		        _extData[++_extIndex] = global.__PropertySetters__[? _propRaw[0]];
        
		        // Set property data based on standard/normalized types
		        if (ds_map_exists(global.__NormalizedProperties__, _propRaw[0]))
		        {   // Normalized Property
		            _data = array_create(3);
		            _data[0] = _propRaw[1]; // data
		            _data[1] = argument[++_argIndex]; // real start value
		            _data[2] = argument[++_argIndex]; // real destination value
		            _extData[++_extIndex] = 0; // normalized start
		            _extData[++_extIndex] = 1; // normalized destination
					_extData[++_extIndex] = _data; // data
		        }
		        else
		        {   // Standard Property =================
		            _extData[++_extIndex] = argument[++_argIndex]; // start
		            _extData[++_extIndex] = argument[++_argIndex]; // destination
		            _extData[++_extIndex] = _propRaw[1]; // Property Data
		        }
		
				_extData[++_extIndex] = ""; // Reserved for dynamic property
		    }
		    else // Standard Properties
		    {
				if (ds_map_exists(global.__PropertySetters__, _propRaw))
				{
					// Get raw property setter script
					_propRaw = global.__PropertySetters__[? _propRaw];
		
					// Track raw property
			        _extData[++_extIndex] = _propRaw;
        
			        // Set property data based on standard/normalized types
			        if (ds_map_exists(global.__NormalizedProperties__, _propRaw))
			        {    
						// Normalized Property
			            _data = array_create(2);
			            _data[0] = argument[++_argIndex]; // real start value
			            _data[1] = argument[++_argIndex]; // real destination value
			            _extData[++_extIndex] = 0; // normalized start
			            _extData[++_extIndex] = 1; // normalized destination
			            _extData[++_extIndex] = _data; // data
			        }
			        else
			        {
						// Standard Property
			            _extData[++_extIndex] = argument[++_argIndex]; // start
			            _extData[++_extIndex] = argument[++_argIndex]; // destination
			            _extData[++_extIndex] = _target; // target
			        }
			
					_extData[++_extIndex] = "" // Reserved for dynamic property
				}
				else // Dynamic Property
				{
					// Determine instance/global property setter
					if (variable_instance_exists(_target, _propRaw))
					{
						_extData[++_extIndex] = TGMS_Variable_Instance_Set;
					}
					else
					{
						_extData[++_extIndex] = TGMS_Variable_Global_Set;
					}

			        _extData[++_extIndex] = argument[++_argIndex]; // start
			        _extData[++_extIndex] = argument[++_argIndex]; // destination
					_extData[++_extIndex] = _target; // target
					_extData[++_extIndex] = _propRaw; // variable string
				}
		    }
    
		    // This is needed for getting raw property information with TweenGet() -- Thanks past self!
		    _extData[++_extIndex] = _propRaw;
		}

		return TGMS_TweenDefine(_tID, TGMS_MultiPropertySetter__, argument[1], argument[2], argument[3], argument[4], argument[5], 0, 1, _extData);
	}

	return undefined;
}_=TweenDefine;


/// @function TweenDestroy(tween{s})
/// @param {Any} tween{s}	tween id[s]
/// @description Manually destroys the selected tween{s}
// --> NOTE: Tweens are always automatically destroyed when their target instance is destroyed.
function TweenDestroy(_t)
{	
	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
	    {
	        return undefined;
	    }
    
	    // Invalidate tween handle
	    if (ds_map_exists(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]))
	    {
	        ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]);
	    }
    
	    _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
	    _t[@ TWEEN.ID] = undefined; // Nullify self reference
    
	    // Invalidate tween target or destroy target instance depending on destroy mode
	    if (_t[TWEEN.DESTROY] != 2)
	    { 
	        _t[@ TWEEN.TARGET] = noone; // Invalidate target instance
	    }
	    else
	    { // Destroy Target Instance
	        var _target = _t[TWEEN.TARGET]; // Get target to destroy
        
	        if (instance_exists(_target))
	        {
	            with(_target) instance_destroy();
	        }
	        else
	        {
	            instance_activate_object(_target); // Attempt to activate target by chance it was deactivated
	            with(_target) instance_destroy(); // Attempt to destroy target
	        } 
	    }
    
	    return undefined;
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenDestroy);
	}

	return undefined;
}


/// @function TweenDestroySafe(tween{s})
/// @param {Any} tween{s} tween id(s)
/// @description Safely destroys a tween without error, even if it doesn't exist
function TweenDestroySafe(_t) 
{
	if (is_array(_t))
	{
	    return TweenDestroy(_t);
	}

	if (is_real(_t))
	{
	    if (ds_map_exists(global.TGMS_MAP_TWEEN, _t))
	    {
	        return TweenDestroy(_t);
	    }
    
	    return undefined;
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenDestroySafe);
	}

	return undefined;
}


/// @function TweenDestroyWhenDone(tween{s}, destroy, [kill_target])
/// @param	{Any} tween{s}			tween id(s)
/// @param	{Any} destroy?			destroy tween{s} when finished or stopped?
/// @param	{Any} [kill_target?]	(optional) destroy target when tween finished or stopped?
/// @description					Forces a tween to be destroyed when finished or stopped
function TweenDestroyWhenDone()
{
	var _t = argument[0];

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (argument_count == 2)
	    {
	        _t[@ TWEEN.DESTROY] = argument[1];
	    }
	    else
	    {
			var _doDestroy = argument[1];
	        _t[@ TWEEN.DESTROY] = (_doDestroy+argument[2])*_doDestroy;
	    }
	}

	if (is_string(_t))
	{
	    if (argument_count == 2)
	    {
	        TGMS_TweensExecute(_t, TweenDestroyWhenDone, argument[1]);
	    }
	    else
	    {
	        TGMS_TweensExecute(_t, TweenDestroyWhenDone, argument[1], argument[2]);
	    }
	}
}




//=========================================
// - THE FOLLOWING ARE SUPPORT FUNCTIONS -
// - PLEASE DO NOT CALL THESE FUNCTIONS! -
//=========================================

/// @function TGMS_TweenFire(target,prop,ease,mode,delta,delay,dur,start,dest,[...])
/// @param {Any} target		instance to associate with tween (id or object index)
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} start		starting value for eased property
/// @param {Any} dest		destination value for eased property
/// @param {Any} [...]		(optional) For extended properties
/// @description			Base script for TweenFire* scripts -- DO NOT USE DIRECTY!!
/// @ignore
function TGMS_TweenFire()
{
	// Feather ignore all
	
	var _sharedTweener = SharedTweener();
	var _tID = ++global.TGMS_INDEX_TWEEN;							 // Get new tween id
	var _t  = array_create(TWEEN.DATA_SIZE);						 // Create new tween array
	array_copy(_t, 0, global.TGMS_TweenDefault, 0, TWEEN.DATA_SIZE); // Copy default tween
	
	_t[TWEEN.ID] = _tID;							// Assign new tween id
	_t[TWEEN.TARGET] = argument[0];					// Set target to instance
	_t[TWEEN.EASE] = argument[2];					// Set tween's ease algorithm
	_t[TWEEN.MODE] = argument[3];					// Set tween play mode
	_t[TWEEN.DELTA] = argument[4];					// Set delta
	_t[TWEEN.DURATION] = argument[6];				// Set tween's duration
	_t[TWEEN.START] = argument[7];					// Set start value
	_t[TWEEN.CHANGE] = argument[8]-_t[TWEEN.START]; // Calculate change value (dest-start)

	var _property;

	if (argument_count == 9) // Regular property
	{
	    _property = argument[1];
	    _t[TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	
		if (is_string(_property)) // Dynamic Property
		{
			_t[TWEEN.VARIABLE] = _property;
		
			if (variable_instance_exists(_t[TWEEN.TARGET], _property))
			{
				_t[TWEEN.PROPERTY] = TGMS_Variable_Instance_Set; // Set tween's property setter script
				_property = TGMS_Variable_Instance_Set;
			}
			else
			{
				_t[TWEEN.PROPERTY] = TGMS_Variable_Global_Set;
				_property = TGMS_Variable_Global_Set;
			}
		}
		else // Optimised property
		{
			_t[TWEEN.PROPERTY] = _property; // Set tween's property setter script
		}
    
	    _t[TWEEN.DATA] = argument[0];       // Set tween's data as target id
	}
	else // Extended property
	{
		// Set extended property setter script
		// override target data with data
		_property = [argument[1], argument[9]];
	    _t[TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	    _t[TWEEN.DATA] = _property[1];		// Set tween's data to extended arguments
	    var _script = _property[0];			// Cache script to use as property setter
	    _property = _script;				// Update cached property setter
	    _t[TWEEN.PROPERTY] = _script;		// Set tween's property setter script   
	}

	if (argument[5] <= 0) // If no delay set  
	{ 
	    _t[TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween state as playing
		_property(_t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
	}
	else // Delay is set
	{
	    _t[TWEEN.STATE] = TWEEN_STATE.DELAYED; // Set state as delayed
	    _t[TWEEN.DELAY] = argument[5]; // Assign delay list reference to tween
	    _t[TWEEN.DELAY_START] = argument[5]; // Set starting delay time
	    ds_list_add(_sharedTweener.delayedTweens, _t); // Add tween to global delayed list   
	}

	ds_list_add(_sharedTweener.tweens, _t); // Add tween to global tweens list
	global.TGMS_MAP_TWEEN[? _tID] = _t; // Associate tween with global id
	return _tID; // Return tween id
}


/// @function TGMS_TweenCreate(target, [prop, ease, mode, delta, delay, dur, start, dest, ...])
/// @param {Any} target	instance to associate with tween (id or object index)
/// @param {Any} [prop		property setter string or TP*() script
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} start		starting value for eased property
/// @param {Any} dest		destinationsss value for eased property
/// @param {Any} ...]		(optional) additional properties ("direction", 0, 360)
/// @description Create a tween to be started with TweenPlay*() (not auto-destroyed)
/// @ignore
function TGMS_TweenCreate()
{
	/*
		Creates and returns a new tween. The tween does not start right away, but must
		be played with the TweenPlay*() scripts.
		Unlike TwenFire*(), tweens created with TweenCreate() will exist in memory until their
		target instance is destroyed or TweenDestroy(tween) is called.
		You can set them to auto-destroy with TweenDestroyWhenDone():
	
		Defining a tween at creation is optional. Both of the following are valid:
			tween1 = TweenCreate(id);
			tween2 = TweenCreate(id, EaseLinear, TWEEN_MODE_ONCE, true, 0, 1, "x", 0, 100);
		
			TweenDestroyWhenDone(tween2, true); // Have tween auto-destroy when finished
	*/
	// Feather ignore all
	
	var _sharedTweener = SharedTweener();
	var _tID = ++global.TGMS_INDEX_TWEEN;								// Get new unique tween id
	var _t  = array_create(TWEEN.DATA_SIZE);							// Create new tween array
	array_copy(_t, 0, global.TGMS_TweenDefault, 0, TWEEN.DATA_SIZE);	// Copy default tween
	_t[TWEEN.ID] = _tID;												// Store tween index handle inside tween
	_t[TWEEN.TARGET] = argument[0].id;									// Set tween target
	_t[TWEEN.DESTROY] = 0;												// Make persistent
	
	var _property;

	// Set tween property
	if (argument_count > 1)
	{   
	    _t[TWEEN.EASE] = argument[2];
	    _t[TWEEN.MODE] = argument[3];
	    _t[TWEEN.DELTA] = argument[4];
	    _t[TWEEN.DELAY_START] = argument[5];
	    _t[TWEEN.DURATION] = argument[6];
	    _t[TWEEN.START] = argument[7];
	    _t[TWEEN.CHANGE] = argument[8]-_t[TWEEN.START];
          
	    if (argument_count == 9) // Regular property
		{
		    _property = argument[1];
		    _t[TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	
			if (is_string(_property)) // Dynamic Property
			{
				_t[TWEEN.VARIABLE] = _property;
		
				if (variable_instance_exists(_t[TWEEN.TARGET], _property))
				{
					_t[TWEEN.PROPERTY] = TGMS_Variable_Instance_Set; // Set tween's property setter script
					_property = TGMS_Variable_Instance_Set;
				}
				else
				{
					_t[TWEEN.PROPERTY] = TGMS_Variable_Global_Set;
					_property = TGMS_Variable_Global_Set;
				}
			}
			else // Optimised property
			{
				_t[TWEEN.PROPERTY] = _property;	// Set tween's property setter script
			}
    
		    _t[TWEEN.DATA] = argument[0];		// Set tween's data as target id
		}
		else // Extended property
		{
		    _property[0] = argument[1]; // Set extended property setter script
		    _property[1] = argument[9]; // override target data with data
		    _t[TWEEN.PROPERTY_RAW] = _property; // Store raw property data
		    _t[TWEEN.DATA] = _property[1];  // Set tween's data to extended arguments
		    var _script = _property[0];     // Cache script to use as property setter
		    _property = _script;            // Update cached property setter
		    _t[TWEEN.PROPERTY] = _script;   // Set tween's property setter script   
		}
	}

	global.TGMS_MAP_TWEEN[? _tID] = _t; // Assign tween handle to map
	ds_list_add(_sharedTweener.tweens, _t); // Add new tween to tweening list
	return _tID; // Return unique tween id
}


/// @function TGMS_TweenPlay(tween{s}, [prop, ease, mode, delta, delay, dur, start, dest, ...])
/// @param {Any} tween{s}	tween{s} id of previously created tween
/// @param {Any} [prop]		property setter string or TP*() script
/// @param {Any} [ease]		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} [mode]		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} [delta]	whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} [delay]	amount of time to delay tween before playing
/// @param {Any} [dur]		duration of time to play tween
/// @param {Any} [start]	starting value for eased property
/// @param {Any} [dest]		destination value for eased property
//  @param {Any} [...]		(optional) additional properties ("direction", 0, 360)
/// @description			Create a tween to be started with TweenPlay*() (not auto-destroyed)
/// @ignore
function TGMS_TweenPlay()
{
	// Feather ignore all

	var _tID = argument[0];

	var _t = TGMS_FetchTween(_tID);
	if (is_undefined(_t)) { return 0; }

	_t[@ TWEEN.TIME] = 0;
	_t[@ TWEEN.DIRECTION] = 1;
	_t[@ TWEEN.TIME_SCALE] = abs(_t[TWEEN.TIME_SCALE]);

	var _property;

	if (argument_count > 1)
	{
	    _t[@ TWEEN.EASE] = argument[2];
	    _t[@ TWEEN.MODE] = argument[3];
	    _t[@ TWEEN.DELTA] = argument[4];
	    _t[@ TWEEN.DELAY_START] = argument[5];
	    _t[@ TWEEN.DURATION] = argument[6];
	    _t[@ TWEEN.START] = argument[7];
	    _t[@ TWEEN.CHANGE] = argument[8]-_t[TWEEN.START];
          
	    if (argument_count == 9) // Regular property
		{
		    _property = argument[1];
		    _t[@ TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	
			if (is_string(_property)) // Dynamic Property
			{
				_t[@ TWEEN.VARIABLE] = _property;
		
				if (variable_instance_exists(_t[TWEEN.TARGET], _property))
				{
					_t[@ TWEEN.PROPERTY] = TGMS_Variable_Instance_Set; // Set tween's property setter script
					_property = TGMS_Variable_Instance_Set;
				}
				else
				{
					_t[@ TWEEN.PROPERTY] = TGMS_Variable_Global_Set;
					_property = TGMS_Variable_Global_Set;
				}
			}
			else // Optimised property
			{
				_t[@ TWEEN.PROPERTY] = _property; // Set tween's property setter script
			}
    
			_t[@ TWEEN.DATA] = _t[TWEEN.TARGET]; // Set tween's data as target id
		}
		else // Extended property
		{
		    _property[0] = argument[1]; // Set extended property setter script
		    _property[1] = argument[9]; // override target data with data
		    _t[@ TWEEN.PROPERTY_RAW] = _property; // Store raw property data
		    _t[@ TWEEN.DATA] = _property[1];  // Set tween's data to extended arguments
		    var _script = _property[0];     // Cache script to use as property setter
		    _property = _script;            // Update cached property setter
		    _t[@ TWEEN.PROPERTY] = _script;   // Set tween's property setter script   
		}
	}
	else
	{
	    _property = _t[TWEEN.PROPERTY];   
	}

	if (_t[TWEEN.DELAY_START] <= 0)
	{   
		if (SharedTweener().inUpdateLoop)
		{
			ds_queue_enqueue(SharedTweener().stateChanger, _t, _t[TWEEN.TARGET]);
		}
		else
		{
			_t[@ TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween as active
		}
	
		_t[@ TWEEN.DELAY] = -1; // Set delay as invalid
	    _property(_t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]); // Update property with start value
	    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PLAY); // Execute "On Play" event
	}
	else
	{
	    _t[@ TWEEN.STATE] = TWEEN_STATE.DELAYED; // Set tween as waiting  
	    _t[@ TWEEN.DELAY] = _t[TWEEN.DELAY_START]; // Set delay to set delay value
	    ds_list_add(SharedTweener().delayedTweens, _t); // Add tween to delay list
	}
}


/// @function TGMS_TweenDefine(tween, ease, mode, detal, dur, prop, start, dest, [...])
/// @param {Any} tween		tween id of previously created tween
/// @param {Any} ease		easing script index id (e.g. EaseInQuad, EaseLinear)
/// @param {Any} mode		tween mode (0=ONCE, 1=BOUNCE, 2=PATROL, 3=LOOP, 4=REPEAT)
/// @param {Any} delta		whether or not to use delta(seconds) timing -- false will use step timing
/// @param {Any} delay		amount of time to delay tween before playing
/// @param {Any} dur		duration of time to play tween
/// @param {Any} prop		property setter string or TP*() script
/// @param {Any} start		starting value for eased property
/// @param {Any} dest		destination value for eased property
/// @param {Any} [...]		(optional) additional properties ("direction", 0, 360)
/// @description			Defines a tween previously created with TweenCreate()
/// @ignore
function TGMS_TweenDefine() 
{
	// Required by TweenDefine() script
	// Don't call this directly!
	// Feather ignore all

	var _tID = argument[0];
	var _t = TGMS_FetchTween(_tID);
	if (is_undefined(_t)) { return 0; }

	_t[@ TWEEN.TIME] = 0;
	_t[@ TWEEN.EASE] = argument[2];
	_t[@ TWEEN.MODE] = argument[3];
	_t[@ TWEEN.DELTA] = argument[4];
	_t[@ TWEEN.DELAY_START] = argument[5];
	_t[@ TWEEN.DURATION] = argument[6];
	_t[@ TWEEN.START] = argument[7];
	_t[@ TWEEN.CHANGE] = argument[8]-_t[@ TWEEN.START];
      
	var _property;
	  
	if (argument_count == 9) // Regular property
	{
		_property = argument[1];
		_t[@ TWEEN.PROPERTY_RAW] = _property; // Store raw property data
	
		if (is_string(_property)) // Dynamic Property
		{
			_t[@ TWEEN.VARIABLE] = _property;
		
			if (variable_instance_exists(_t[TWEEN.TARGET], _property))
			{
				_t[@ TWEEN.PROPERTY] = TGMS_Variable_Instance_Set; // Set tween's property setter script
				_property = TGMS_Variable_Instance_Set;
			}
			else
			{
				_t[@ TWEEN.PROPERTY] = TGMS_Variable_Global_Set;
				_property = TGMS_Variable_Global_Set;
			}
		}
		else // Optimised property
		{
			_t[@ TWEEN.PROPERTY] = _property; // Set tween's property setter script
		}
    
		_t[@ TWEEN.DATA] = _t[TWEEN.TARGET]; // Set tween's data as target id
	}
	else // Extended property
	{
		_property[0] = argument[1]; // Set extended property setter script
		_property[1] = argument[9]; // override target data with data
		_t[@ TWEEN.PROPERTY_RAW] = _property; // Store raw property data
		_t[@ TWEEN.DATA] = _property[1];  // Set tween's data to extended arguments
		var _script = _property[0];     // Cache script to use as property setter
		_property = _script;            // Update cached property setter
		_t[@ TWEEN.PROPERTY] = _script;   // Set tween's property setter script   
	}
}



