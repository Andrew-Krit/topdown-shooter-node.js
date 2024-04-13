if(owner != undefined)
{
	if(owner.weapon != undefined)
	{
		var s = scribble("[scale, 20][fnt_arial]" +string(owner.weapon.weaponData.ammoInClip) + " / " + string(owner.weapon.weaponData.ammo));
		s.draw(1000, 9000);
	}
}