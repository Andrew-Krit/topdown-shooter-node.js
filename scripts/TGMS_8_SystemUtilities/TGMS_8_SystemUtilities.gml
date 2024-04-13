// Feather ignore all
var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

/*
	User Functions:
		SharedTweenerActivate		-- SAFE TO DELETE
		SharedTweenerDestroy		-- SAFE TO DELETE
		TweenSystemClearRoom		-- SAFE TO DELETE
		TweenSystemFlushDestroyed	-- SAFE TO DELETE
		TweenSystemCount			-- SAFE TO DELETE
		TweenSystemGet				-- SAFE TO DELETE
		TweenSystemSet				-- SAFE TO DELETE
*/


/// @function SharedTweenerActivate()
/// @description			Activates shared tweener instance
function SharedTweenerActivate() 
{		
	instance_activate_object(obj_SharedTweener);
}_=SharedTweenerActivate;


/// @function SharedTweenerDestroy()
/// @description			Destroys shared tweener instance
function SharedTweenerDestroy()
{	
	instance_destroy(obj_SharedTweener, true);
}_=SharedTweenerDestroy;


/// @function TweenSystemClearRoom(room_id)
/// @param {Any} room		room index or [all] keyword for all rooms
/// @description			Clears tweens in inactive persistent room(s)
function TweenSystemClearRoom(_room_id)
{
	TGMS_ClearRoom(_room_id);
}_=TweenSystemClearRoom;


/// @function TweenSystemFlushDestroyed()
/// @description			Override memory manager to immediately clear all destroyed tweens
function TweenSystemFlushDestroyed()
{
	if (instance_exists(global.TGMS_SharedTweener))
	{
	    global.TGMS_SharedTweener.flushDestroyed = true;
	}
}_=TweenSystemFlushDestroyed;


/// @function TweenSystemCount(label: "all" "playing" "paused" "stopped")
/// @param {String} [dataLabel] (optional) "all" "playing" "paused" "stopped"
/// @description			Returns count of tweens in system
function TweenSystemCount() 
{
	/*
	    INFO:
	        Returns total number of tweens in system, excluding those in inactive persistent rooms.
			Can pass optional label in for counting only specific tweens
        
		SUPPORTED DATA LABELS:
	        "all"
	        "playing"
	        "paused"
	        "stopped"
	*/
	// Feather ignore all

	if (argument_count == 0)
	{
	    return ds_list_size(SharedTweener().tweens);
	}

	var _tweens = SharedTweener().tweens;
	var _total = 0;
	var _index = -1;

	switch(argument[0])
	{
	    case "all":
	        _total = ds_list_size(_tweens);
	    break;
    
	    case "playing":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] >= 0;
	        }
	    break;
    
	    case "paused":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] == TWEEN_STATE.PAUSED;
	        }
	    break;
    
	    case "stopped":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] == TWEEN_STATE.STOPPED;
	        }
	    break;
	}

	return _total;
}_=TweenSystemCount;


/// @function TweenSystemGet(data_label)
/// @param dataLabel		Type of data to retrieve. Must be a string
/// @return {Any}
/// @description			Returns value for selected tweening system property
function TweenSystemGet(_data_label)
{
	/*
	    SUPPORTED DATA LABELS:
	        "enabled"			// is system enabled?
	        "time_scale"		// global time scale
	        "update_interval"	// how often system should update in steps (default = 1)
	        "min_delta_fps"		// minimum frame rate before delta time lags begin (default=10)
	        "auto_clean_count"	// number of tweens to check for auto-cleaning each step (default=10)
	        "delta_time"		// tweening systems internal delta time
	        "delta_time_scaled" // tweening systems scaled delta time
	*/

	var _sharedTweener = SharedTweener();

	switch(_data_label)
	{
    case "delta_time": return _sharedTweener.deltaTime; break;
    case "delta_time_scaled": return _sharedTweener.deltaTime * global.TGMS_TimeScale; break;
    case "enabled": return global.TGMS_IsEnabled; break;
    case "time_scale": return global.TGMS_TimeScale; break;
    case "update_interval": return global.TGMS_UpdateInterval; break;
    case "min_delta_fps": return global.TGMS_MinDeltaFPS; break;
    case "auto_clean_count": return global.TGMS_AutoCleanIterations; break; 
	}
}_=TweenSystemGet;


/// @function TweenSystemSet(data_label,value)
/// @param dataLabel
/// @param value
/// @description			Sets value for specified tweening system property
function TweenSystemSet(_data_label, _value)
{
	/*
	    SUPPORTED DATA LABELS:
	        "enabled"
	        "time_scale"
	        "update_interval"
	        "min_delta_fps"
	        "auto_clean_count"
	*/

	var _sharedTweener = SharedTweener();

	switch(_data_label)
	{
    case "enabled":
        _sharedTweener.isEnabled = _value;
        global.TGMS_IsEnabled = _value;
    break;

    case "time_scale":
        _sharedTweener.timeScale = _value;
        global.TGMS_TimeScale = _value;
    break;

    case "update_interval":
        _sharedTweener.updateInterval = _value;
        global.TGMS_UpdateInterval = _value;
    break;

    case "min_delta_fps":
        global.TGMS_MinDeltaFPS = _value;
        _sharedTweener.minDeltaFPS = _value;
        _sharedTweener.maxDelta = 1/_sharedTweener.minDeltaFPS;
    break;

    case "auto_clean_count":
        global.TGMS_AutoCleanIterations = _value;
        _sharedTweener.autoCleanIterations = _value;
    break; 
	}
}_=TweenSystemSet;




