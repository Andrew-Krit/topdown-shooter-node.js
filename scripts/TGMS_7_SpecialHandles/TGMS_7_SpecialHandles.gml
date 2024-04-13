// Feather ignore all
var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER);

/*
	User Functions:
		TweenNull			-- SAFE TO DELETE
		TweenDefault		-- SAFE TO DELETE
*/


/// @function TweenNull()
/// @returns {undefined}
/// @description			Returns a null tween id
function TweenNull()
{
	/*
	    return:
	        NULL
        
	    INFO:
	        Returns a NULL tween id which can be safely called by any tween script
        
	    Example:
	        // Declare null tween id
	        tween = TweenNull()
        
	        // No error will occur
	        TweenStop(tween);
        
	*/

	return undefined;
}_=TweenNull;


/// @function TweenDefault()
/// @description			Returns the default tween for setting default tween data
function TweenDefault()
{
	/*
	    Returns default tween data which is used as base for each new tween.
	    You can, for example, use this to set default groups and time scales for new tweens
    
	    e.g. 
	        // Change default tween properties
	        TweenSetGroup(TweenDefault(), 5);
	        TweenSetTimeScale(TweenDefault(), 0.5);
    
	        // Following tweens will belong to GROUP 5 and have a TIME SCALE of 0.5
	        tween1 = TweenCreate(id);
	        tween2 = TweenCreate(id);
	*/

	return 1;
}_=TweenDefault;


