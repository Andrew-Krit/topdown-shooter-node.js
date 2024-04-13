// Feather ignore all
var _;

/*
	User Functions:
		TGMS_BuildProperty
		TGMS_BuildPropertyNormalize
		TPNull			-- SAFE TO DELETE
		TPExt			-- SAFE TO DELETE
		TPInst			-- SAFE TO DELETE
		TPStruct		-- SAFE TO DELETE
		TPArray			-- SAFE TO DELETE
		TPList			-- SAFE TO DELETE
		TPGrid			-- SAFE TO DELETE
		TPMap			-- SAFE TO DELETE
		TPUser			-- SAFE TO DELETE
		
	Support Functions:
		TGMS_DefaultProperties
		TGMS_Variable_Global_Set
		TGMS_Variable_Instance_Set
*/


/// @function TGMS_BuildProperty("label", setter, getter)
/// @param {Any} "label"	string to associate with property
/// @param {Any} setter		setter function to associate with property
/// @param {Any} getter		getter function to associate with property
/// @description Prepares a property to be optimised for TweenGMS
function TGMS_BuildProperty(_label, _setter, _getter) 
{
	global.__PropertySetters__[? _label] = method(undefined, _setter);
	global.__PropertyGetters__[? _label] = method(undefined, _getter);
}


/// TGMS_BuildPropertyNormalize("label", setter, getter)
/// @param {Any} "label"	string to associate with property
/// @param {Any} setter		setter script to associate with property
/// @param {Any} getter		getter script to assocaite with property
/// @description Prepares a normalized property to be usable by TweenGMS
function TGMS_BuildPropertyNormalize(_label, _setter, _getter)
{
	/*
		Info:
			Normalized property scripts receive an eased value between 0 and 1
			with additional data passed for the start/dest values.
			See image_blend__ script for an example.
	*/

	global.__NormalizedProperties__[? _label] = 1;
	TGMS_BuildProperty(_label, _setter, _getter);
}


/// @ignore
function TGMS_DefaultProperties()
{
	// Feather ignore all
	/*
		Set up default properties for optimisation or normalization purposes.
		This is NOT REQUIRED for custom properties/variables to be used, but they will
		perform slower than tweens set up with TGMS_BuildProperty().
	
		It is advised to create your own list of custom properties elsewhere.
		It is safe to delete any properties and their associated scripts.
	
		Note:
			Properties like "image_blend" require to be built in order 
			to function as intended since they are normalized.
	*/
	
	// NOTE:
	//	_v = value
	//  _t = target
	//  _d = data

	//=========================
	// GLOBAL PROPERTIES
	//=========================
	TGMS_BuildProperty("score", function(_v){ score = _v; }, function(){ return score; });
	TGMS_BuildProperty("health", function(_v){ health = _v; }, function(){ return health; });
	TGMS_BuildPropertyNormalize("background_colour", function(_v,_d){ background_colour = merge_colour(_d[0], _d[1], _v); }, function(){ return background_colour; });
	TGMS_BuildPropertyNormalize("background_color", function(_v,_d){ background_color = merge_colour(_d[0], _d[1], _v); }, function(){ return background_color; });
		
	//=====================
	// INSTANCE VARIABLES
	//=====================
	TGMS_BuildProperty("", function(){}, function(){ return 0; });
	TGMS_BuildProperty("x", function(_v,_t){ _t.x = _v; }, function(_t){ return _t.x; });
	TGMS_BuildProperty("y", function(_v,_t){ _t.y = _v; }, function(_t){ return _t.y; });
	TGMS_BuildProperty("z", function(_v,_t){ _t.z = _v; }, function(_t){ return _t.z; });
	TGMS_BuildProperty("round(x)", function(_v,_t){ _t.x = round(_v); }, function(_t){ return _t.x; });
	TGMS_BuildProperty("round(y)", function(_v,_t){ _t.y = round(_v); }, function(_t){ return _t.y; });
	TGMS_BuildProperty("round(z)", function(_v,_t){ _t.z = round(_v); }, function(_t){ return _t.z; });
	TGMS_BuildProperty("direction", function(_v,_t){ _t.direction = _v; }, function(_t){ return _t.direction; });
	TGMS_BuildProperty("speed", function(_v,_t){ _t.speed = _v; }, function(_t){ return _t.speed; });
	TGMS_BuildProperty("hspeed", function(_v,_t){ _t.hspeed = _v; }, function(_t){ return _t.hspeed; });
	TGMS_BuildProperty("vspeed", function( _v,_t){ _t.vspeed= _v; }, function(_t){ return _t.vspeed; });
	TGMS_BuildProperty("image_alpha", function(_v,_t){ _t.image_alpha= _v; }, function(_t){ return _t.image_alpha; });
	TGMS_BuildProperty("image_angle", function(_v,_t){ _t.image_angle= _v; }, function(_t){ return _t.image_angle; });
	TGMS_BuildProperty("image_scale", function(_v,_t){ _t.image_xscale = _v; _t.image_yscale = _v; }, function(){ return _t.image_xscale; });
	TGMS_BuildProperty("image_xscale", function(_v,_t){ _t.image_xscale = _v; }, function(_t){ return _t.image_xscale; });
	TGMS_BuildProperty("image_yscale", function(_v,_t){ _t.image_yscale = _v; }, function(_t){ return _t.image_yscale; });
	TGMS_BuildProperty("image_index", function(_v,_t){ _t.image_index = _v; }, function(_t){ return _t.image_index; });
	TGMS_BuildProperty("image_speed", function(_v,_t){ _t.image_speed = _v; }, function(_t){ return _t.image_speed; });
	TGMS_BuildPropertyNormalize("image_blend", function(_v,_d,_t){ _t.image_blend = merge_colour(_d[0], _d[1], _v); }, function(_t){ return _t.image_blend; });
	TGMS_BuildProperty("path_orientation", function(_v,_t){ _t.path_orientation = _v; }, function(_t){ return _t.path_orientation; });
	TGMS_BuildProperty("path_position", function(_v,_t){ _t.path_position = _v; }, function(_t){ return _t.path_position; });
	TGMS_BuildProperty("path_scale", function(_v,_t){ _t.path_scale = _v; }, function(_t){ return _t.path_scale; });
	TGMS_BuildProperty("path_speed", function(_v,_t){ _t.path_speed = _v; }, function(_t){ return _t.path_speed; });
}


//===============================
// GENERIC AUTO PROPERTY SETTERS
//===============================

/// function TGMS_Variable_Global_Set(value,unused_1,unused_1,variable)
/// @param {Real} value
/// @param {Any} unused_1
/// @param {Any} unsued_2
/// @param {String} variable
/// @ignore
function TGMS_Variable_Global_Set()
{
	//  Feather ignore all
	variable_global_set(argument[3], argument[0]);
}


/// function TGMS_Variable_Instance_Set(value, unused, target, variable);
/// @param {Real} value
/// @param {Any} unsused
/// @param {Any} target
/// @param {String} variable
/// @ignore
function TGMS_Variable_Instance_Set() 
{
	//  Feather ignore all
	variable_instance_set(argument[2], argument[3], argument[0]);
}


//=====================
// ADVANCED PROPERTIES
//=====================

/// @function TPNull()
/// @description			Returns a null tween property
function TPNull()
{	
	return "";
}_=TPNull;


/// @function TPExt(property, arg0, ...)
/// @param {Any} property	property script
/// @param {Any} arg0		argument to pass to extended property scripts
/// @param {Any} ...		additional arguments to pass to extended property scripts
/// @return {Any}
/// @description			Prepares an extended property script with custom arguments
function TPExt(_property)
{	
	/*
		[Example]
		
		/// CREATE A SETTER SCRIPT
		function ExtColourBlend(_value, _data, _target)
		{
			_target.image_blend = merge_colour(_data[0], _data[1], _value);
		}
		
		// CREATE A DEFINED TWEEN WITH AN EXTENDED PROPERTY
		tween = TweenCreate(id, EaseInQuad, 0, true, 0.0, 3.0, TPExt(extColourBlend, c_red, c_blue), 0, 1);
	*/
	// Feather ignore all

	// CONVERT METHOD TO INDEX
	if (is_method(_property)) { _property = method_get_index(_property); }

	// ADD PROPERTY INDEX TO GLOBAL PROPERTY SETTERS MAP
	if (global.__PropertySetters__[? _property] == undefined) {
		global.__PropertySetters__[? _property] = _property;
	}
	
	if (argument_count == 2)
	{
		return [_property, argument[1]];
	}
	else
	{
	    var _args;
	    var _iArg = -1;
	    repeat(argument_count-1)
	    {
	        ++_iArg;
	        _args[_iArg] = argument[_iArg+1];
	    }
    
		return [_property, _args];
	}
}_=TPExt;


/// @function TPInst(inst, name)
/// @param {Any} inst 
/// @param {Any} name
/// @return {Any}
/// @description			Allows variable of another instance to be passed as a property
function TPInst(_inst, _name)
{
	// data = [instance, name, getter, setter]
	
	static _ = TGMS_BuildProperty(TPInst,
		function(_value, _data) // SETTER
		{
			if (instance_exists(_data[0]))
			{
				if (is_undefined(_data[3])) { _data[0][$ _data[1]] = _value; }
				else						{ _data[3](_value, _data[0]); }
			}
		},
		function (_data) // GETTER
		{	
			if (instance_exists(_data[0]))
			{
				if (is_undefined(_data[2])) { return _data[0][$ _data[1]]; }
				else						{ return _data[2](_data[0]); }
			}
			
			return 0;
		}
	);
	
	return [ TPInst, [_inst, _name, global.__PropertyGetters__[? _name], global.__PropertySetters__[? _name]] ];
}


/// @function TPStruct(struct, name)
/// @param {Any} struct
/// @param {Any} name
/// @return {Any}
function TPStruct(_struct, _name)
{	
	static _ = TGMS_BuildProperty(TPStruct,
		function(_value, _data) 
		{ 
			_data[0][$ _data[1]] = _value; // data = [struct, name]
		},
		function(_data)
		{	
			return _data[0][$ _data[1]]; // data = [struct, name] 
		}
	);
	
	return [TPStruct, [_struct, _name]];
}


/// @function TPArray(array, x, [y])
/// @param {Any} array
/// @param {Any} x
/// @param {Any} [y]
/// @return {Any}
/// @description			Allows array index to be tweened as a property
function TPArray(_array, _x, _y=undefined)
{
	static _ = TGMS_BuildProperty(TPArray, 
		function(_value,_data) 
		{
			_data[0][@ _data[1]] = _value; 
		},
		function(_data) 
		{ 
			return _data[0][_data[1]]; 
		}
	);	
	
	return [ TPArray, (is_undefined(_y) ? [_array, _x] : [_array[_x], _y]) ];
}



/// @function TPGrid(grid, x, y)
/// @param grid
/// @param x
/// @param y
/// @return {array}
function TPGrid(grid, _x, _y)
{	
	// CALL ONLY ONCE
	static _ = TGMS_BuildProperty(TPGrid,
		function(_value, _data) 
		{
			ds_grid_set(_data[0], _data[1], _data[2], _value);
		},
		function(_data)
		{
			return ds_grid_get(_data[0], _data[1], _data[2]);
		}
	);
	
	return [ TPGrid, [ grid, _x, _y] ];
}



/// @function TPList(list, index)
/// @param list
/// @param index
/// @return {array}
function TPList(_list, _index)
{
	static _ = TGMS_BuildProperty(TPList,
		function(_value, _data)
		{
			ds_list_replace(_data[0], _data[1], _value);
		},
		function(_data)
		{
			return ds_list_find_value(_data[0], _data[1]);
		}
	);

	return [ TPList, [_list, _index] ];
}


/// @function TPMap(map, key)
/// @param map
/// @param key
/// @return {array}
function TPMap(_map, _key)
{
	static _ = TGMS_BuildProperty(TPMap,
		function(_value, _data)
		{
			ds_map_replace(_data[0], _data[1], _value);
		},
		function(_data)
		{
			return ds_map_find_value(_data[0], _data[1]);
		}
	);
		
	return [ TPMap, [_map, _key] ];
}



/// @function TPUser(event, [...])
/// @param {Any} event
/// @return {Any}
function TPUser(_user_event)
{
	/*
		[EXAMPLE 1] --> Use user event as tween property
			[SOME EVENT]
			// Fire a tween using TPUser as the property
			TweenFire(id, EaseLinear, 0, true, 0, 1.0, TPUser(0), 0, 100);
		
			[USER EVENT 0]
			// Update value in user event 0
			abc = TWEEN_USER_VALUE;
		
		[EXAMPLE 2] --> Have extended data passed to user event
			[SOME EVENT]
			// Fire a tween using TPUser as the property with extra data
			TweenFire(id, EaseLinear, 0, true, 0, 1.0, TPUser(1, c_white, c_red), 0, 1);
		
			[USER EVENT 1]
			var _value = TWEEN_USER_VALUE;
			var _data = TWEEN_USER_DATA; // This will contain c_white/c_red values
			image_blend = merge_colour(_data[0], _data[1], _value);
		
		[EXAMPLE 3] --> How to set up a user event to support TweenFireTo/From()
			[SOME EVENT]
			// Fire a tween using TPUser as the property
			TweenFireTo(id, EaseLinear, 0, true, 0, 1.0, TPUser(2), 100);
		
			[USER EVENT 0]
			// User Event 2
			if (TWEEN_USER_GET) // GETTER
			{
			    TWEEN_USER_GET = abc;
			}
			else // SETTER
			{
			    abc = TWEEN_USER_VALUE;
			}
	*/
	// Feather ignore all
	
	// BUILD PROPERTY SETTER/GETTER
	static _ = TGMS_BuildProperty(TPUser,
		function(_value, _event, _target)
		{
			TWEEN_USER_VALUE = _value;
			TWEEN_USER_TARGET = _target;
			
			with(_target)
			{
				if (is_real(_event)) 
				{
				    event_perform_object(object_index, ev_other, _event);
				}
				else 
				{
				    TWEEN_USER_DATA = _event[1];
				    event_perform_object(object_index, ev_other, _event[0]);
				}
			}
		},
		function(_event, _target)
		{
			TWEEN_USER_TARGET = _target;
			TWEEN_USER_GET = 1;

			with(_target)
			{
				if (is_real(_event)) 
				{
				    event_perform_object(object_index, ev_other, _event);
				}
				else 
				{
				    TWEEN_USER_DATA = _event[1];
				    event_perform_object(object_index, ev_other, _event[0]);
				}

				var _return = TWEEN_USER_GET;
				TWEEN_USER_GET = 0;
				return _return;
			}
		}
	);
	
	
	if (argument_count == 1)
	{
		return [TPUser, ev_user0+_user_event];
	}
	else // Extended Data
	{
	    var _args;
	    var i = -1;
	    repeat(argument_count-1)
	    {
	        ++i;
	        _args[i] = argument[i+1];
	    }
    
		return [TPUser, [ev_user0+_user_event, _args]];
	}
}













