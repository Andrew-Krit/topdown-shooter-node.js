class Player
{
    constructor(id, x, y, direction, userName, key_left, key_right, key_up, key_down, key_shoot, player_health)
    {
        this.id = id;
        this.x = x;
        this.y = y;
        this.direction = direction;
        this.userName = userName;
        this.key_left = key_left;
        this.key_right = key_right;
        this.key_down = key_down;
        this.key_up = key_up;
        this.key_shoot = key_shoot;
        this.player_health = player_health;
    }
}

module.exports = Player;