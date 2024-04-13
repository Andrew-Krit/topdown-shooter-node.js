// Feather ignore all
var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER)

/*
	User Functions:
		TweenCalc			-- Safe to delete
		TweenCalcAmount		-- Safe to delete
		TweenCalcTime		-- Safe to delete
		TweenStep			-- Safe to delete
		TweenPath			-- Safe to delete
*/


/// @function TweenCalc(tween)
/// @param {Any} tween		tween id
/// @return {Any}
/// @description			Returns calculated value from tween's current state
function TweenCalc(_t)
{	
	/*
	    INFO:
	        Returns a calculated value using a tweens current state.
        
	    EXAMPLE:
	        // Create defined tween ... we don't have to provide any property
	        tween = TweenFire(id, EaseInOutQuint, 0, true, 0.0, 2.5);
        
	        // Calculate value of tween at its current state
	        x = TweenCalc(tween);
	*/
	// Feather ignore all

	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)){ return 0; }

	var _duration = _t[TWEEN.DURATION];

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    var _amount = script_execute(_t[TWEEN.EASE], _t[TWEEN.TIME], 0, 1, _duration);
    
	    repeat(array_length(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid else return caculated time
	        _return[_dataIndex] = _duration == 0 ? _start : lerp(_start, _dest, _amount);
	    }
		
	    return _return; 
	}
	else // SINGLE PROPERTY
	{
	    // Return start if duration is invalid
	    if (_duration == 0) { return _t[TWEEN.START]; }
	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(_t[TWEEN.TIME], 0, _duration), _t[TWEEN.START], _t[TWEEN.CHANGE], _duration);
	}
} _ = TweenCalc;


/// @function TweenCalcAmount(tween,amount)
/// @param {Any} tween		tween id
/// @param {Real} amount	relative time between 0.0 and 1.0
/// @return {Any}
/// @description			Returns calculated value using tween's state and a set amount
function TweenCalcAmount(_t, _amount)
{
	/*
	    INFO:
	        Returns a calculated value using a tweens current state
	        at a relative point in time.
        
	    EXAMPLE:
	        // Create defined tween
	        tween = TweenCreate(id, EaseInOutQuint, 0, true, 0.0, 2.5);
        
	        // Calculate value of tween at 25% through time
	        x = TweenCalcAmount(tween, 0.25);
	*/
	// Feather ignore all
	
	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return 0; }

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    _amount = script_execute(_t[TWEEN.EASE], _amount, 0, 1, 1); // Cache calculated amount
    
	    repeat(array_length(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid else return caculated time
	        return[_dataIndex] = _t[TWEEN.DURATION] == 0 ? _start : lerp(_start, _dest, _amount);
	    }
    
	    return _return;
	}
	else
	{
	    // Return start if duration is invalid
	    if (_t[TWEEN.DURATION] == 0) { return _t[TWEEN.START]; }
	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(_amount, 0, _t[TWEEN.DURATION]), _t[TWEEN.START], _t[TWEEN.CHANGE], 1);
	}
} _ = TweenCalcAmount;


/// @function TweenCalcTime(tween,time)
/// @param {Any} tween		tween id
/// @param {Real} time		specific time in steps or seconds
/// @return {Any}
/// @description			Returns calculated value using a tween's state at a set time
function TweenCalcTime(_t, _time)
{
	/*      
	    INFO:
	        Returns a calculated value using a tween's current state
	        at a specified point in time.
        
	    EXAMPLE:
	        // Create defined tween
	        tween = TweenCreate(id, EaseInOutQuint, 0, true, 0.0, 2.5);
        
	        // Calculate value of tween at 1.5 seconds through time
	        x = TweenCalcAmount(tween, 1.5);
	*/
	// Feather ignore all
	
	_t = TGMS_FetchTween(_t);
	if (is_undefined(_t)) { return 0; }

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    var _amount = script_execute(_t[TWEEN.EASE], _time, 0, 1, _t[TWEEN.DURATION]);
    
	    repeat(array_length(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid else return caculated time
	        _return[_dataIndex] = _t[TWEEN.DURATION] == 0 ? _start : lerp(_start, _dest, _amount);
	    }
    
	    return _return;
	}
	else
	{
	    // Return start if duration is invalid
	    if (_t[TWEEN.DURATION] == 0) { return _t[TWEEN.START]; }
	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(_time, 0, _t[TWEEN.DURATION]), _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]);
	}
} _ = TweenCalcTime;


/// @function TweenStep(tween{s}, amount)
/// @param {Any} tween{s}		tween id[s]
/// @param {Real} amount		relative amount/direction to step (1.0 = forward | -1.0 = backward)
/// @description				Steps a tween forward/backward by given amount
function TweenStep(_t, _amount)
{
	/*
	    INFO:
	        Steps a tween forward or backward by a given amount.
	        The direction can be a decimal (floating point) value.
        
	        Using 1.0 or -1.0 will step a tween 1 step in the indicated direction.
	        Lesser values, such as 0.5, will step the tween half a step foward.
	        Greater values, such as 2.0, will step a tween 2 steps forward.
	*/
	// Feather ignore all

	if (is_real(_t)) { _t = TGMS_FetchTween(_t); }

	if (is_array(_t))
	{        
	    // Cache shared tweener
	    var _sharedTweener = SharedTweener();
    
		// Cache time scales
		var _timeScale = _sharedTweener.timeScale;
		var _timeScaleDelta = _sharedTweener.timeScaleDelta;
    
	    if (_t[TWEEN.STATE] != TWEEN_STATE.STOPPED && _timeScale != 0)
	    {
	        var _keepPaused = _t[TWEEN.STATE] == TWEEN_STATE.PAUSED;
        
	        // IF tween instance exists AND delay is NOT destroyed
	        if (_t[TWEEN.DELAY] > 0)
	        { 
	            // Decrement delay timer
				_t[@ TWEEN.DELAY] -= _amount * (_t[TWEEN.DELTA] ? _timeScaleDelta : _timeScale);
            
	            // IF the delay timer has expired
	            if (_t[TWEEN.DELAY] <= 0)
	            {
	                // Indicate that delay should be removed from delay list
	                _t[@ TWEEN.DELAY] = -1; 
	                // Execute FINISH DELAY event
	                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH_DELAY);                    
	                // Update property with start value
	                _t[TWEEN.PROPERTY](_t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
	                // Execute PLAY event callbacks
	                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PLAY);
                
	                if (_keepPaused) { _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED; }
	            }
	            else
	            {
	                if (_keepPaused) { _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED; }
	                return;
	            }
	        }
                    
	        // Get updated time -- [DELTA] boolean selects between step/delta time scale
	        var _time = _t[TWEEN.TIME] + _amount * _t[TWEEN.TIME_SCALE] * (_t[TWEEN.DELTA] ? _timeScaleDelta : _timeScale)
        
	        // Cache PROPERTY and DURATION
	        var _property = _t[TWEEN.PROPERTY];
	        var _duration = _t[TWEEN.DURATION];
        
	        // IF tween is within start/destination
	        if (_time > 0 && _time < _duration)
	        {
	            // Assign updated time
	            _t[@ TWEEN.TIME] = _time;
	            // Update tweened property with eased value
	            _property(script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);    
	        }
	        else // Tween has reached start or destination
	        if (_t[TWEEN.TIME_SCALE] != 0) // Make sure time scale isn't "paused"
	        {
	            // Update tween based on its play mode -- Could put overflow wait time in here????
	            switch(_t[TWEEN.MODE])
	            {
	            case TWEEN_MODE_ONCE:
	                _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;  // Set tween's state as STOPPED
	                _t[@ TWEEN.TIME] = _duration*(_time > 0); // Update tween's time
                
	                // Update property
	                _property(_t[TWEEN.START] + _t[TWEEN.CHANGE]*(_time > 0), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                 
	                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH); // Execute FINISH event
	                if (_t[TWEEN.DESTROY]) TweenDestroy(_t);              // Destroy tween if temporary
	            break;
            
	            case TWEEN_MODE_BOUNCE:
	                if (_time > 0)
	                {
	                    _time = 2*_duration - _time;        // Update local raw time
	                    _t[@ TWEEN.TIME] = _time;           // Update tween with local raw time
	                    _time = clamp(_time, 0, _duration); // Clamp local raw time
                    
	                    // Update property
	                    _property(script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                    
	                    _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];           // Reverse direction
	                    _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];         // Invert time scale
	                    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE); // Execute BOUNCE event
	                }
	                else
	                {
	                    // Update tween's time
	                    _t[@ TWEEN.TIME] = 0;
                    
	                    // Update property
	                    _property(_t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
                    
	                    _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;              // Set tween state as STOPPED
	                    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH); // Execute FINISH event
	                    if (_t[TWEEN.DESTROY]) TweenDestroy(_t);              // Destroy tween if temporary
	                }
	            break;
            
	            case TWEEN_MODE_PATROL:
	                // Update local time with epsilon compensation
	                if (_time > 0) { _time = 2*_duration - _time; }
	                else           { _time = -_time; }
                
	                _t[@ TWEEN.TIME] = _time;           // Update with raw time value
	                _time = clamp(_time, 0, _duration); // Clamp local time
    
	                // Update property
	                _property(script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]); 
                
	                _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];           // Reverse tween direction
	                _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];         // Invert time scale
	                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE); // Execute BOUNCE event
	            break;
            
	            case TWEEN_MODE_LOOP:
	                // Update local raw time
	                if (_time > 0) { _time = _time - _duration; }
	                else           { _time = _time + _duration; }
                
	                _t[@ TWEEN.TIME] = _time;           // Update tween with local raw time
	                _time = clamp(_time, 0, _duration); // Clamp local raw time   
                
	                // Update property
	                _property(script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
	                // Execute LOOP event
	                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE);
	            break;
            
	            case TWEEN_MODE_REPEAT:
	                // Update local time and tween's starting location
	                if (_time > 0)
	                {
	                    _time = _time - _duration;
	                    _t[@ TWEEN.START] = _t[TWEEN.START] + _t[TWEEN.CHANGE];
	                }
	                else
	                {
	                    _time = _time + _duration;
	                    _t[@ TWEEN.START] = _t[TWEEN.START] - _t[TWEEN.CHANGE];
	                }
                
	                _t[@ TWEEN.TIME] = _time;           // Update tween with raw local time
	                _time = clamp(_time, 0, _duration); // Clamp local raw time
                
	                // Update property
	                _property(script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
	                // Execute LOOP event
	                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE);
	            break;
            
	            default:
	                show_error("Invalid Tween Play Mode! --> Reverting to TWEEN_MODE_ONCE", false);
					TweenSet(_t, "mode", TWEEN_MODE_ONCE);
	            }
	        }
        
	        if (_keepPaused) { _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED; }
	    }
	}
	else if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenStep, _amount);
	}
}_=TweenStep;


/// @function TweenPath(target, ease, mode, delta, delay, dur, path, absolute)
/// @param {Any} target
/// @param {Any} ease
/// @param {Any} mode
/// @param {Any} delta
/// @param {Any} delay
/// @param {Any} dur
/// @param {Any} path
/// @param {Any} absolute
/// @description	Tween instance position using a GameMaker path resource
function TweenPath(_target, _ease, _mode, _delta, _delay, _dur, _path, _absolute)
{	
	// Feather ignore all
	
	 /// ext_path__(amount,data[path|absolute|xstart|ystart|xrelative|yrelative|repeat],target)
	static _path_setter = method_get_index(function(_amount, _data, _target)
	{
		var _path = _data[0];
		var _xrelative = _data[4];
		var _yrelative = _data[5];

		with(_target)
		{
		    if (_data[6]) // REPEAT
		    {
		    	var _xstart = _data[2];
		    	var _ystart = _data[3];
	    	
		        var _xDif = path_get_x(_path, 1) - path_get_x(_path, 0); // Could cache these two??
		        var _yDif = path_get_y(_path, 1) - path_get_y(_path, 0);
            
		        if (_amount > 0)
		        {   
		            _xrelative = _xstart + _xDif * floor(_amount);
		            _yrelative = _ystart + _yDif * floor(_amount);
		            _amount = _amount mod 1;
		        }
		        else if (_amount < 0)
		        {
		            _xrelative = _xstart + _xDif * ceil(_amount-1);
		            _yrelative = _ystart + _yDif * ceil(_amount-1);
		            _amount = 1 + _amount mod 1;
		        }
		        else
		        {
		            _xrelative = _xstart;
		            _yrelative = _ystart;
		        }
        
		        x = path_get_x(_path, _amount) + _xrelative;
		        y = path_get_y(_path, _amount) + _yrelative;
		    }
		    else // NO REPEAT
		    {
		        if (_amount > 0)
		        {
		            if (path_get_closed(_path) || _amount < 1)
		            {
		                x = path_get_x(_path, _amount mod 1) + _xrelative;
		                y = path_get_y(_path, _amount mod 1) + _yrelative;
		            }
		            else
		            {
		                var _length = path_get_length(_path) * (abs(_amount)-1);
		                var _direction = point_direction(path_get_x(_path, 0.999), path_get_y(_path, 0.999), path_get_x(_path, 1), path_get_y(_path, 1));
                
		                x = path_get_x(_path, 1) + _xrelative + lengthdir_x(_length, _direction);
		                y = path_get_y(_path, 1) + _yrelative + lengthdir_y(_length, _direction);
		            }
		        }
		        else 
		        if (_amount < 0)
		        {
		            if (path_get_closed(_path))
		            {
		                x = path_get_x(_path, 1+_amount) + _xrelative;
		                y = path_get_y(_path, 1+_amount) + _yrelative;
		            }
		            else
		            {
		                var _length = path_get_length(_path) * abs(_amount);
		                var _direction = point_direction(path_get_x(_path, 0), path_get_y(_path, 0), path_get_x(_path, 0.001), path_get_y(_path, 0.001));
                
		                x = path_get_x(_path, 0) + _xrelative - lengthdir_x(_length, _direction);
		                y = path_get_y(_path, 0) + _yrelative - lengthdir_y(_length, _direction);
		            }
		        }
		        else
		        {
		            x = path_get_x(_path, 0) + _xrelative;
		            y = path_get_y(_path, 0) + _yrelative;
		        }
		    }
		}
	});
	
	static _ = TGMS_BuildProperty(_path_setter, _path_setter, function(){});
	
	var _repeat = (_mode == TWEEN_MODE_REPEAT);

	with(_target)
	{
	    // IF absolute
	    if (_absolute)
	    {
	        return TGMS_TweenFire(_target, _path_setter, _ease, _mode, _delta, _delay, _dur, 0, 1, [_path, _absolute, 0, 0, 0, 0, _repeat]);
	    }
	    else
	    {
	        var _path_xstart = path_get_x(_path, 0);
	        var _path_ystart = path_get_y(_path, 0);
			var _data = [_path, _absolute, _path_xstart, _path_ystart, x-_path_xstart, y-_path_ystart, _repeat];
	        return TGMS_TweenFire(_target, _path_setter, _ease, _mode, _delta, _delay, _dur, 0, 1, _data);
	    }
	}
}_=TweenPath;





