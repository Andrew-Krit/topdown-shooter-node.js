function Weapon() constructor
{
	damage = undefined;
	ammo = undefined;
	ammoInClip = undefined;
	sound = undefined;
	shootDelay = undefined;
	soundReload = undefined;
}

function HandGun() : Weapon() constructor
{
	ammo = 12;
	ammoInClip = 12;
	sound = snd_handGun;
	type = "handgun";
	damage = 10;
	shootDelay = 0.3;
	reloadSpeed = 50;
	soundReload = snd_handGunReload;
}


function ShotGun() : Weapon() constructor
{
	ammo = 5;
	ammoInClip = 5;
	sound = snd_shotgun;
	type = "shotgun";
	damage = 20;
	shootDelay = 0.7;
	reloadSpeed = 80;
	soundReload = snd_shotgunReload;
}

function Rifle() : Weapon() constructor
{
	ammo = 15;
	ammoInClip = 15;
	sound = snd_rifle;
	type = "rifle";
	damage = 5;
	shootDelay = 0.1;
	reloadSpeed = 60;
	soundReload = snd_handGunReload;
}

