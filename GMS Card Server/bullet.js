class Bullet
{
    constructor(id, x, y, direction, speed, ownerId)
    {
        this.id = id;
        this.x = x;
        this.y = y;
        this.direction = direction;
        this.speed = speed;
        this.ownerId = ownerId;
    }
}

module.exports = Bullet;