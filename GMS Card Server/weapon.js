class Weapon
{
    constructor(x, y, direction, ammoInClip, maxAmmo, ownerId, weaponType, damage)
    {
        this.x = x;
        this.y = y;
        this.ammoInClip = ammoInClip;
        this.direction = direction;
        this.ownerId = ownerId;
        this.type = weaponType;
        this.maxAmmo = maxAmmo;
        this.damage = damage;
    }
}

module.exports = Weapon;