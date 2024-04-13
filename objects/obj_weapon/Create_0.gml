owner = undefined;

isCanShoot = true;
isOnReloading = false;

initialize = function(_data)
{
	weaponData = _data;
	tweenShoot = TweenCreate(id, EaseInOutQuart, TWEEN_MODE_ONCE, true, weaponData.shootDelay, 0, "isCanShoot", isCanShoot, true);
}

shoot = function()
{
	if(isCanShoot == true && weaponData.ammoInClip > 0 && !isOnReloading)
	{
		isCanShoot = false;
		
		d = ds_map_create();
		ds_map_add(d, "hostNumber", global.hostNumber);
		ds_map_add(d, "weaponId", weaponIDD);	
		sendMapOverUDP("127.0.0.1", 8080, 1000, d, msgType.WEAPON_SHOOT);
		
		TweenPlay(tweenShoot);
	}
	else if(weaponData.ammoInClip <= 0 && !isOnReloading)
	{
		audio_play_sound(snd_noAmmo, 0, 0, 1, 0, 1);
	}
}

reload = function()
{
	isOnReloading = true;
	audio_play_sound(weaponData.soundReload, 0, 0, 1);
	alarm[0] = weaponData.reloadSpeed;
}

weaponAmount = instance_number(obj_weapon);
	
for(var i = 0; i < weaponAmount; i++)
{
	if(instance_find(obj_weapon, i).id == id)
	{
		weaponIDD = i;
	}
}
	
set_weapon_states = function()
{
	d = ds_map_create();
	
	ds_map_add(d, "x", x);
	ds_map_add(d, "y", y);
	ds_map_add(d, "direction", direction);
	ds_map_add(d, "hostNumber", global.hostNumber);
	ds_map_add(d, "weaponId", weaponIDD);	
	
	sendMapOverUDP("127.0.0.1", 8080, 1000, d, msgType.SET_WEAPON_STAT);
}

get_weapon_states = function()
{
	d = ds_map_create();
	
	ds_map_add(d, "hostNumber", global.hostNumber);
	ds_map_add(d, "weaponId", weaponIDD);	
	ds_map_add(d, "weaponStat", noone);
	
	
	sendMapOverUDP("127.0.0.1", 8080, 300, d, msgType.GET_WEAPON_STAT);
}