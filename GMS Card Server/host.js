const Player = require("./player");
const Weapon = require("./weapon");

class Host
{
    constructor()
    {
        this.players = [];
        this.weapons = [];
        this.bullets = [];
    }

    AddPlayer(newPlayer) 
    {
        this.players.push(newPlayer);
    }

    
    AddWeapon(newWeapon) 
    {
        this.weapons.push(newWeapon);
    }

    AddBullet(newBullet)
    {
        this.bullets.push(newBullet);

    }

    FindBulletIndex(id)
    {
        return this.bullets.map(e => e.id).indexOf(id);
    }

    DestroyBullet(id)
    {
        this.bullets.splice(id, 1);
    }
}

module.exports = Host;