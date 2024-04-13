// Feather ignore all
var _; // USED TO HIDE SYNTAX WARNINGS (PRE-FEATHER)

/*
	Learn more about Easy Tweens from this link: 
	https://stephenloney.com/_/TweenGMS/120/TGMS_Script_Reference.html#EASY_TWEENS

	User Functions:
		TweenEasyUseDelta		-- SAFE TO DELETE
		TweenEasyMove			-- SAFE TO DELETE
		TweenEasyScale			-- SAFE TO DELETE
		TweenEasyRotate			-- SAFE TO DELETE
		TweenEasyFade			-- SAFE TO DELETE
		TweenEasyTurn			-- SAFE TO DELETE
		TweenEasyBlend			-- SAFE TO DELETE
		TweenEasyImage			-- SAFE TO DELETE
		TweenEasySpeed			-- SAFE TO DELETE
		TweenEasySpeedHV		-- SAFE TO DELETE
*/


/// @function TweenEasyUseDelta(use_seconds?)
/// @param {Any} use_seconds?	Use seconds timing? true = seconds | false = steps
/// @description				Toggle between using step or delta timing for "Easy Tweens"
function TweenEasyUseDelta(_use_seconds) 
{
	SharedTweener();
	global.TGMS_EasyDelta = _use_seconds;
}_=TweenEasyUseDelta;


/// @function TweenEasyMove(x1, y1, x2, y2, delay, duration, ease, [mode])
/// @param {Any} x1
/// @param {Any} y1
/// @param {Any} x2
/// @param {Any} y2
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's x/y position
function TweenEasyMove(_x1, _y1, _x2, _y2, _delay, _dur, _ease, _mode=0) 
{
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasyMove") && TweenExists(__TweenEasyMove))
	{
		TweenDestroy(__TweenEasyMove);
	}

	__TweenEasyMove = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "x", _x1, _x2, "y", _y1, _y2);
	return __TweenEasyMove;
}_=TweenEasyMove;


/// @function TweenEasyScale(x1, y1, x2, y2, delay, dur, ease, [mode])
/// @param {Any} x1
/// @param {Any} y1
/// @param {Any} x2
/// @param {Any} y2
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's image scale
function TweenEasyScale(_x1, _y1, _x2, _y2, _delay, _dur, _ease, _mode=0)
{
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasyScale") && TweenExists(__TweenEasyScale))
	{
		TweenDestroy(__TweenEasyScale);
	}

	__TweenEasyScale = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "image_xscale", _x1, _x2, "image_yscale", _y1, _y2);
	return __TweenEasyScale;
}_=TweenEasyScale;


/// @function TweenEasyRotate(angle1, angle2, delay, dur, ease, [mode])
/// @param {Any} angle1
/// @param {Any} angle2
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's image angle
function TweenEasyRotate(_angle1, _angle2, _delay, _dur, _ease, _mode=0)
{
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasyRotate") && TweenExists(__TweenEasyRotate))
	{
		TweenDestroy(__TweenEasyRotate);
	}

	__TweenEasyRotate = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "image_angle", _angle1, _angle2);
	return __TweenEasyRotate;
}_=TweenEasyRotate;


/// @function TweenEasyFade(alpha1, alpha2, delay, dur, ease, [mode])
/// @param {Any} alpha1
/// @param {Any} alpha2 
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's image alpha
function TweenEasyFade(_alpha1, _alpha2, _delay, _dur, _ease, _mode=0)
{	
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasyFade") && TweenExists(__TweenEasyFade))
	{
		TweenDestroy(__TweenEasyFade);
	}

	__TweenEasyFade = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "image_alpha", _alpha1, _alpha2);
	return __TweenEasyFade;
}_=TweenEasyFade;


/// @function TweenEasyTurn(dir1, dir2, delay, dur, ease, [mode])
/// @param {Any} dir1
/// @param {Any} dir2
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's direction
function TweenEasyTurn(_dir1, _dir2, _delay, _dur, _ease, _mode=0)
{	
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasyTurn") && TweenExists(__TweenEasyTurn))
	{
		TweenDestroy(__TweenEasyTurn);
	}

	__TweenEasyTurn = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "direction", _dir1, _dir2);
	return __TweenEasyTurn;
}_=TweenEasyTurn;


/// @function TweenEasyBlend(col1, col2, delay, dur, ease, [mode])
/// @param {Any} col1
/// @param {Any} col2
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's image blend colour
function TweenEasyBlend(_col1, _col2, _delay, _dur, _ease, _mode=0)
{
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasyBlend") && TweenExists(__TweenEasyBlend))
	{
		TweenDestroy(__TweenEasyBlend);
	}

	__TweenEasyBlend = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "image_blend", _col1, _col2);
	return __TweenEasyBlend;
}_=TweenEasyBlend;


/// @function TweenEasyImage(index1, index2, delay, dur, ease, [mode])
/// @param {Any} index1
/// @param {Any} index2 
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's image index
function TweenEasyImage(_index1, _index2, _delay, _dur, _ease, _mode=0)
{	
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasyImage") && TweenExists(__TweenEasyImage))
	{
		TweenDestroy(__TweenEasyImage);
	}

	__TweenEasyImage = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "image_index", _index1, _index2);
	return __TweenEasyImage;
}_=TweenEasyImage;


/// @function TweenEasySpeed(spd1, spd2, delay, dur, ease, [mode])
/// @param {Any} spd1
/// @param {Any} spd2 
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's speed
function TweenEasySpeed(_spd1, _spd2, _delay, _dur, _ease, _mode=0)
{
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasySpeed") && TweenExists(__TweenEasySpeed))
	{
		TweenDestroy(__TweenEasySpeed);
	}

	__TweenEasySpeed = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "speed", _spd1, _spd2);
	return __TweenEasySpeed;
}_=TweenEasySpeed;


/// @function TweenEasySpeedHV(hspd1, vspd1, hspd2, vspd2, delay, dur, ease, [mode])
/// @param {Any} hspd1
/// @param {Any} vspd1 
/// @param {Any} hspd2
/// @param {Any} vspd2 
/// @param {Any} delay
/// @param {Any} duration
/// @param {Any} ease
/// @param {Any} [mode]
/// @description Tweens instance's hspeed/vspeed
function TweenEasySpeedHV(_hspd1, _vspd1, _hspd2, _vspd2, _delay, _dur, _ease, _mode=0)
{
	SharedTweener();

	if (variable_instance_exists(id, "__TweenEasySpeedHV") && TweenExists(__TweenEasySpeedHV))
	{
		TweenDestroy(__TweenEasySpeedHV);
	}

	__TweenEasySpeedHV = TweenFire(id, _ease, _mode, global.TGMS_EasyDelta, _delay, _dur, "hspeed", _hspd1, _hspd2, "vspeed", _vspd1, _vspd2);
	return __TweenEasySpeedHV;
}_=TweenEasySpeedHV;



