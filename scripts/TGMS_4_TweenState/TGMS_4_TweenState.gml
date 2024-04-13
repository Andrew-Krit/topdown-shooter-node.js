// Feather ignore all
var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

/*
	User Functions:
		TweenExists
		TweenIsPlaying		-- SAFE TO DELETE
		TweenIsActive		-- SAFE TO DELETE
		TweenIsPaused		-- SAFE TO DELETE
		TweenIsStopped		-- SAFE TO DELETE
		TweenStop			-- SAFE TO DELETE
		TweenPause			-- SAFE TO DELETE
		TweenResume			-- SAFE TO DELETE
		TweenReverse		-- SAFE TO DELETE
		TweenFinish			-- SAFE TO DELETE
		TweenFinishDelay	-- SAFE TO DELETE
		TweenGet
		TweenSet
*/


/// @function TweenExists(tween)
/// @param {Any} tween		tween id
/// @description			Checks if tween exists
function TweenExists(_tween)
{	
	/*      
	    Example:
	        if (TweenExists(tween))
			{
	            TweenStop(tween);
	        }
	*/

	SharedTweener();

	if (is_real(_tween))
	{
		_tween = global.TGMS_MAP_TWEEN[? _tween];
		
		if (is_undefined(_tween))
		{
			return false;
		}
	}
	else
	if (is_array(_tween))
	{
	    if (_tween[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
	    {
	        return false;
	    }
	}
	else
	{
	    return false;
	}
    
	if (instance_exists(_tween[TWEEN.TARGET]))
	{
	    return true;
	}

	var _target = _tween[TWEEN.TARGET];
	
	instance_activate_object(_target);

	if (instance_exists(_target))
	{
	    instance_deactivate_object(_target);
	    return true;
	}
	
	return false;
}


/// @function TweenIsPlaying(tween)
/// @param {Any} tween		tween id
/// @description			Checks if tween is currently playing
function TweenIsPlaying(_t)
{	
	/*
	    NOTE:
	        ** Will NOT return true if tween is processing a delay **
        
	    Example:
	        if (TweenIsPlaying(tween))
	        {
	            TweenPause(tween);
	        }
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	return _t[TWEEN.STATE] >= 0;
}_=TweenIsPlaying;


/// @function TweenIsActive(tween)
/// @param {Any}			tween	tween id
/// @description			Checks if tween is active
function TweenIsActive(_t) 
{	
	/*
	    INFO:
			Simliar to TweenIsPlaying but Returns true if 
			tween is playing OR actively processing a delay
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	return (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.DELAYED);
}_=TweenIsActive;


/// @function TweenIsPaused(tween)
/// @param {Any} tween		tween id
/// @description			Checks if tween is paused
function TweenIsPaused(_t)
{
	/*
	    Example:
	        if (TweenIsPaused(tween))
	        {
	            TweenResume(tween);
	        }
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	return _t[TWEEN.STATE] == TWEEN_STATE.PAUSED;
}_=TweenIsPaused;


/// @function TweenIsStopped(tween)
/// @param {Any} tween		tween id
/// @description			Checks if tween is stopped
function TweenIsStopped(_t)
{
	/*
	    Example:
	        if (TweenIsStopped(tween))
	        {
	            TweenPlay(tween);
	        }
	*/

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return false; }

	return _t[TWEEN.STATE] == TWEEN_STATE.STOPPED;
}_=TweenIsStopped;


/// @function TweenStop(tween{s})
/// @param {Any} tween{s}	tween id{s}
/// @description			Stops the selected tween{s}
function TweenStop(_t)
{
	if (is_real(_t)) { _t = TGMS_FetchTween(_t); }

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] <= TWEEN_STATE.PAUSED)
	    {
	        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
        
	        if (_t[TWEEN.DELAY] >= 0)
	        {
	            _t[@ TWEEN.DELAY] = -1;   
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_STOP_DELAY);
	        }
	        else
	        {
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_STOP);
	        }
            
	        if (_t[TWEEN.DESTROY])
	        {
	            TweenDestroy(_t);
	        }
	    }
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenStop);
	}
}


/// @function TweenPause(tween{s})
/// @param {Any} tween{s}	tween id
/// @description			Pauses the selected tween{s}
function TweenPause(_t)
{
	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] >= 0)
	    {
	        _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
	        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PAUSE);
	    }
		else
	    if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED)
	    {
	        _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
	        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PAUSE_DELAY);
	    }
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenPause);
	}
}


/// @function TweenResume(tween{s})
/// @param {Any} tween{s}	tween id
/// @description			Resumes the selected tween{s}
function TweenResume(_t)
{
	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {
	        if (_t[TWEEN.DELAY] > 0)
	        {
	            _t[@ TWEEN.STATE] = TWEEN_STATE.DELAYED;
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_RESUME_DELAY);
	        }
	        else
	        {
	            _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_RESUME);
	        }
	    }
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenResume);
	}
}


/// @function TweenReverse(tween{s})
/// @param {Any} tween{s}	tween id
/// @description			Reverses the selected tween{s}
function TweenReverse(_t)
{
	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] > 0 || _t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {
	        _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];
	        _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];
	        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_REVERSE);
	    }
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenReverse);
	}
}

/// @function TweenFinish(tween{s}, call_event)
/// @param {Any} tween{s}		tween id
/// @param {Any} call_event		execute FINISH EVENT callbacks?
/// @description				Finishes the selected tween{s}
function TweenFinish(_t, _call_event=true)
{
	/*      
	    INFO:
	        Finishes the specified tween, updating it to its destination.
	        DOES NOT affect tweens using PATROL|LOOP|REPEAT play modes.
	*/
	// Feather ignore all

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.DELAY] > 0)
	    {
	        return;
	    }
    
	    if (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
	    {
	        switch(_t[TWEEN.MODE])
	        {
            case TWEEN_MODE_ONCE: _t[@ TWEEN.TIME] = _t[TWEEN.DURATION]; break; // Update tween's time
            case TWEEN_MODE_BOUNCE: _t[@ TWEEN.TIME] = 0; break;				// Update tween's time
            default: return;
	        }
        
	        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED; // Set tween state as STOPPED
        
	        // Update property with start value
	        _t[TWEEN.PROPERTY](_t[TWEEN.START] + _t[TWEEN.CHANGE]*(_t[TWEEN.TIME] > 0), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
        
	        // Execute finish event IF set to do so
	        if (_call_event)
	        {
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH);
	        }
        
	        // IF tween is set to be destroyed
	        if (_t[TWEEN.DESTROY])
	        {
	            TweenDestroy(_t);
	        }
	    }
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenFinish, _call_event);
	}
}


/// @function TweenFinishDelay(tween{s}, call_event)
/// @param {Any} tween{s}		tween id
/// @param {Any} call_event		execute FINISH EVENT callbacks?
/// @description				Finishes delay for the selected tween{s}
function TweenFinishDelay(_t, _call_event=true)
{
	// Feather ignore all

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.DELAY] > 0)
	    {
	        _t[@ TWEEN.DELAY] = -1; // Mark delay for removal from delay list
        
	        // Execute FINISH DELAY event
	        if (_call_event)
	        {
	            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH_DELAY);
	        }
        
	        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween as active                
        
	        // Update property with start value
	        if (_call_event)
	        {
	            _t[TWEEN.PROPERTY](_t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
	        }
        
	        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PLAY); // Execute PLAY event
	    }
	}

	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenFinishDelay, _call_event);
	}
}


/// @function TweenGet(tween, dataLabel)
/// @param {Any} tween			tween id
/// @param {Any} dataLabel		data "label" string -- see script details
/// @return {Any}
/// @description				Returns value for data type of specified tween
function TweenGet(_t, _data_label)
{
	/*
	    Supported Data Labels:
	        "group"         -- Group which tween belongs to
	        "time"          -- Current time of tween in steps or seconds
	        "time_amount"   -- Sets the tween's time by a relative amount between 0.0 and 1.0 
	        "time_scale"    -- How fast a tween updates : Default = 1.0
	        "duration"      -- How long a tween takes to fully animate in steps or seconds
	        "ease"          -- The easing algorithm used by the tween
	        "mode"          -- The play mode used by the tween (ONCE, BOUNCE, PATROL, LOOP
	        "target"        -- Target instance associated with tween
	        "delta"         -- Toggle timing between seconds(true) and steps(false)
	        "delay"         -- Current timer of active delay
	        "delay_start"   -- The starting duration for a delay timer
	        "start"         -- Start value of the property or properties
	        "destination"   -- Destination value of the property or properties
	        "property"      -- Property or properties effected by the tween
        
	        e.g.
	            tween = TweenFire(id, EaseLinear, 0, true, 0, 1, "x", 0, 100);
	            duration = TweenGet(tween, "duration");
            
	    ***	The following labels can return multiple values as an array for multi-property tweens:
        
				"start"    
				"destination"
				"property"
        
	        e.g.
	            tween = TweenFire(id, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100);
	            startValues = TweenGet(tween, "start");
	            xStart = startValues[0];
	            yStart = startValues[1];
	*/
	// Feather ignore all
	
	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return undefined; }

	_data_label = global.TGMS_TweenDataIndexes[? _data_label];

	switch(_data_label)
	{
    case TWEEN.PROPERTY:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
			var _data = _t[TWEEN.DATA];
            var _return = array_create(array_length(_data) div 5);
            var _dataIndex = -1;
        
            repeat(array_length(_return))
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[5 + 5*_dataIndex];
            }
        
            return _return;
        }
        else
        {
            return _t[TWEEN.PROPERTY_RAW];
        }
    break;

    case TWEEN.DESTINATION:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
			var _data = _t[TWEEN.DATA];
            var _return = array_create(array_length(_data) div 5);
            var _dataIndex = -1;
        
            repeat(array_length(_return))
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[3 + 5*_dataIndex];
            }
        
            return _return;
        }
        else
        {
            return _t[TWEEN.START] + _t[TWEEN.CHANGE];
        }
    break;

    case TWEEN.START:
        if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
        {
			var _data = _t[TWEEN.DATA];
            var _return = array_create(array_length(_data) div 5);
            var _dataIndex = -1;
        
            repeat(array_length(_return))
            {
                ++_dataIndex;
                _return[_dataIndex] = _data[2 + 5*_dataIndex];
            }
        
            return _return;
        }
        else
        {
            return _t[TWEEN.START];
        }
    break;

    case TWEEN.DELAY:
        if (_t[TWEEN.DELAY] <= 0) { return 0; }
        else            		  { return _t[TWEEN.DELAY]; }
    break;

    case TWEEN.TIME_SCALE:
        return _t[TWEEN.TIME_SCALE] * _t[TWEEN.DIRECTION];
    break;

    default: // Directly access tween index
        return _t[_data_label]
	}
}_=TweenGet;


/// @function TweenSet(tween{s}, dataLabel, value, [...])
/// @param {Any} tween{s}		tween id[s]
/// @param {Any} dataLabel		data "label" string
/// @param {Any} value			value to apply to set data type
/// @param {Any} [...]			(optional) additional values for modifying multi-property tweens
/// @description				Sets the data type for the selected tween{s}
function TweenSet(_t, _data_label, _value)
{
	/*
	    Supported Data Labels:
	        "group"         -- Group which tween belongs to
	        "time"          -- Current time of tween in steps or seconds
	        "time_amount"   -- Sets the tween's time by a relative amount between 0.0 and 1.0 
	        "time_scale"    -- How fast a tween updates : Default = 1.0
	        "duration"      -- How long a tween takes to fully animate in steps or seconds
	        "ease"          -- The easing algorithm used by the tween
	        "mode"          -- The play mode used by the tween (ONCE, BOUNCE, PATROL, LOOP
	        "target"        -- Target instance associated with tween
	        "delta"         -- Toggle timing between seconds(true) and steps(false)
	        "delay"         -- Current timer of active delay
	        "delay_start"   -- The starting duration for a delay timer
	        "start"         -- Start value of the property or properties
	        "destination"   -- Destination value of the property or properties
	        "property"      -- Property or properties effected by the tween
        
	        e.g.
	            tween = Tween(id, EaseLinear, 0, true, 0, 1, "x", 0, 100);
	            TweenSet(tween, "duration", 2.5);
            
	    *** The following labels can update multiple properties by supplying
			values in the same order the properties were first assigned:
        
	        "start"
	        "destination"
	        "property"
        
	        e.g.
	            tween = Tween(id, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100); // multi-property tween (x/y)
	            TweenSet(tween, "start", mouse_x, mouse_y); // update to x/y mouse coordinates
           
	    // The keyword [undefined] can be used to leave a property value unchanged
	        e.g.
	            TweenSet(tween, "start", undefined, mouse_y); // update "y" but leave "x" unchanged
	*/
	// Feather ignore all

	if (is_real(_t)) { _t = TGMS_FetchTween(_t); }

	_data_label = global.TGMS_TweenDataIndexes[? _data_label];

	if (is_array(_t))
	{   
	    switch(_data_label)
	    {
        case TWEEN.TIME_SCALE:
            _t[@ TWEEN.TIME_SCALE] = _value * _t[TWEEN.DIRECTION];
        break;
    
        case TWEEN.TIME:
        case TWEEN.EASE:
            _t[@ _data_label] = _value;
            TweenForcePropertyUpdate(_t);
        break;
    
        case TWEEN.TIME_AMOUNT:
            _t[@ TWEEN.TIME] = _t[TWEEN.DURATION] * _value;
            TweenForcePropertyUpdate(_t);
        break;
     
        case TWEEN.DELAY:
            if (_t[TWEEN.DELAY] > 0)
            {
                _t[@ TWEEN.DELAY] = _value;
            }
        break;
    
        case TWEEN.START:
            if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
            {
                var _data = _t[TWEEN.DATA];
                var _argIndex = 0;
            
                repeat(argument_count-2)
                {
                    var _dataIndex = 2 + 5*_argIndex; // Note: first index is property count
                    var _start = argument[++_argIndex+1];
                
                    if (!is_undefined(_start))
                    {
                        _data[@ _dataIndex] = _start;
                    }
                }
            }
            else
            if (!is_undefined(_value))
            {
                _t[@ TWEEN.CHANGE] = (_t[TWEEN.START] + _t[TWEEN.CHANGE]) - _value; // change = (destination) - new_start
                _t[@ TWEEN.START] = _value;
            }
        break;
    
        case TWEEN.DESTINATION:
            if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
            {
                var _data = _t[TWEEN.DATA];
                var _argIndex = 0;
            
                repeat(argument_count-2)
                {
                    var _dataIndex = 3 + 5*_argIndex; // Note: first index is property count
                    var _dest = argument[++_argIndex+1];
                
                    if (!is_undefined(_dest))
                    {
                        _data[@ _dataIndex] = _dest;
                    }
                }
            }
            else // SINGLE PROPERTY
            if (!is_undefined(_value))
            {
                _t[@ TWEEN.CHANGE] = _value -_t[TWEEN.START];
            }
        break;
    
        case TWEEN.TARGET:
            if (_t[TWEEN.TARGET] != noone)
            {
                var _target = _value.id;
                _t[@ TWEEN.TARGET] = _target;
            
                if (_t[TWEEN.STATE] >= 0)
                {
                    _t[@ TWEEN.STATE] = _target; // active state
                }
            
                if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
                {
                    var _data = _t[TWEEN.DATA];
                    var _argIndex = -1;
                
                    repeat((array_length(_data)-1) div 5)
                    {
                        var _dataIndex = ++_argIndex*5; // Note: first index is property count
                    
                        if (is_real(_data[_dataIndex+5]))
                        {   // Raw Property
                            _data[@ _dataIndex+4] = _target; // Override data with target id
                        }
                    }
                }
                else // SINGLE PROPERTY
                if (is_real(_t[TWEEN.PROPERTY_RAW]))
                {
                    _t[@ TWEEN.DATA] = _target;
                }
            }
        break;
    
        case TWEEN.PROPERTY:
            if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
            {
                var _data = _t[TWEEN.DATA];
                var _argIndex = 0;
                repeat(argument_count-2)
                {
                    var _dataIndex = 1 + _argIndex*5; // Note: first index is property count
                    var _property = argument[++_argIndex+1];
                
                    // :: Need to normalize
                
                    if (!is_undefined(_property))
                    {
                        if (is_array(_property))
                        {   // Extended Property
                            _data[@ _dataIndex] = _property[0] // script
                            _data[@ _dataIndex+4] = _property[1]; // data
                        }
                        else // IS STRING
                        {  
                            // Get raw property setter script
                            var _propRaw = global.__PropertySetters__[? _property];
                            _data[@ _dataIndex] = _propRaw; // script
                            _data[@ _dataIndex+4] = _propRaw; // data
                        }  
                    }
                }
            }
            else // SINGLE PROPERTY
            {
                _t[@ TWEEN.PROPERTY_RAW] = _value; // store raw property
            
                if (is_real(_value))
                { // Standard property
                    _t[@ TWEEN.PROPERTY] = _value; // script
                    _t[@ TWEEN.DATA] = _t[TWEEN.TARGET]; // data
                }  
                else
                if (is_array(_value))
                { // Extended Property
                    _t[@ TWEEN.DATA] = _value[1]; // script
                    _t[@ TWEEN.PROPERTY] = _value[0]; // data
                }
            }
        break;
    
    	// DEFAULT: DIRECTLY SET TWEEN DATA INDEX
        default: _t[@ _data_label] = _value; break;
	    }
	}
	else
	if (is_string(_t))
	{
	    switch(argument_count)
	    {
        case 3: TGMS_TweensExecute(_t, TweenSet, _data_label, _value); break;
        case 4: TGMS_TweensExecute(_t, TweenSet, _data_label, _value, argument[3]); break;
	    }
	}
}

