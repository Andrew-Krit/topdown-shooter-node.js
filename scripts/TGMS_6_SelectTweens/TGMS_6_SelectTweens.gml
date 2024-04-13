// Feather ignore all
var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

/*
	User Functions:
		TweensIncludeDeactivated	-- SAFE TO DELETE
		Tweens						-- SAFE TO DELETE
		TweensAll					-- SAFE TO DELETE
		TweensTarget				-- SAFE TO DELETE
		TweensGroup					-- SAFE TO DELETE
*/


/// @function TweensIncludeDeactivated(include_deactivated)
/// @param include_deactivated?
/// @description			Whether or not to include tweens associated with deactivated target instances
function TweensIncludeDeactivated(_include_deactivated)
{	
	/*
		When true, Tweens*() scripts will include tweens belonging to deactivated target instances.
		By default, this is set to false.

		e.g. 
			TweensIncludeDeactiavted(true); // include deactivated targets with Tweens*() scripts
	*/

	SharedTweener();

	global.TGMS_TweensIncludeDeactivated = _include_deactivated;
}_=TweensIncludeDeactivated;


/// @function Tweens(tween1,tween2,[...])
/// @param {Any} tween1		first selected tween
/// @param {Any} tween2		second selected tween
/// @param {Any} [...]		additional tweens
/// @description			Returns selected tween ids, for scripts supporting 'tween{s}' argument
function Tweens()
{	
	/*
	    The Tweens*() selection scripts can be used with any tween scripts
	    which show 'tween{s}' as an argument.
    
	    e.g.
			var _tweens = Tweens(tween1, tween2);
	        TweenSet(_tweens, "time_scale", 0.5); // Set time scale for tween1 and tween2
	*/

	var _tweens;
	var i = -1;

	repeat(argument_count)
	{
	    ++i;
	    _tweens[i] = argument[i];
	}

	ds_stack_push(global.TGMS_TweensStack, _tweens);

	return "00";
}_=Tweens;


/// @function TweensAll()
/// @description			Returns all tween ids, for scripts supporting 'tween{s}' argument
function TweensAll()
{	
	/*
	    The Tweens*() scripts can be used with any tween scripts
	    which show 'tween{s}' as an argument.
    
	    e.g.
	        TweenStop(TweensAll()); // Stop all tweens
        
	    The keyword [all] can be used as a shortand version for TweensAll()
    
	    e.g.
	        TweensPause(all);
	        TweensResume(all);
	*/

	return "10";
}_=TweensAll;


/// @function TweensTarget(target)
/// @param {Any} target		target instance associated with tween
/// @description			returns tween ids associated with target, for scripts supporting 'tween{s}' argument
function TweensTarget(_target) 
{
	/*
	    The Tweens*() scripts can be used with any tween scripts
	    which show 'tween{s}' as an argument.
    
	    e.g.
			TweenPause(TweensTarget(id)); // pause all tweens associated with target instance
			TweenResume(TweensTarget(obj_Player)); // resume all tweens associated with obj_Player
	*/
	
	_target = _target.id;

	return "3"+string(_target);
}_=TweensTarget;


/// @function TweensGroup(group)
/// @param {Any} group		tween group
/// @description			Returns tween ids associated with a group, for scripts supporting 'tween{s}' argument
function TweensGroup(_group)
{
	/*
	    The Tweens*() scripts can be used with any tween scripts
	    which show 'tween{s}' as an argument.
    
	    e.g.
			TweenPause(TweensGroup(2)); // pause all tweens associated with group '2'
	*/

	return "2"+string(_group);
}_=TweensGroup;







