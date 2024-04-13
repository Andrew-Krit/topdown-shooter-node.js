const dgram = require("dgram");
const server = dgram.createSocket("udp4");

const Player = require("./player.js");
const Weapon = require("./weapon.js");
const Host = require("./host.js");
const Bullet = require("./bullet.js");

var hosts = [];

const messageType =
{
    CREATE_HOST : 0,
    JOIN_HOST : 1,
    STOP_HOST : 2,
    GET_NEW_PLAYERS : 3,
    GET_HOSTS : 4,
    SET_PLAYER_STAT : 5,
    GET_PLAYER_STAT : 6,
    SET_WEAPON_STAT : 7,
    GET_WEAPON_STAT : 8,
    WEAPON_PICKUP : 9,
    WEAPON_SHOOT : 10,
    WEAPON_RELOAD : 11,
    GET_BULLETS : 12,
    SET_BULLET_STAT : 13,
    GET_BULLET_STAT : 14,
    BULLET_DESTROY : 15,
    SET_PLAYER_DAMAGE : 16,
    REFRESH_HP : 17
}

const weaponType =
{
    HandGun : "HandGun",
    ShotGun : "Shotgun",
    Rifle : "Rifle"
}

server.on('error', (error) => 
{
    console.log('Error occured: ' + error.message);
    server.close();
});

server.on('listening', () =>
{
    const address = server.address();
    console.log('Server is listening on ' + address.address + ":" + address.port); 
}
);

server.on('message', (msg, rinfo) =>
{
    data = JSON.parse(msg);
    switch(data.type)
    {
        case messageType.CREATE_HOST:
            create_host(data, rinfo);
            break;

         case messageType.JOIN_HOST:
            join_host(data, rinfo);
            break;

        case messageType.STOP_HOST:
            stop_host(data, rinfo);
            break;

        case messageType.GET_NEW_PLAYERS:
            get_new_players(data, rinfo);
            break;
            
        case messageType.GET_HOSTS:
            get_hosts(data, rinfo);
            break;

        case messageType.SET_PLAYER_STAT:
            set_player_stat(data, rinfo);
            break;

        case messageType.GET_PLAYER_STAT:
            get_player_stat(data, rinfo);
            break;

        case messageType.SET_WEAPON_STAT:
            set_weapon_stat(data, rinfo);
            break;

        case messageType.GET_WEAPON_STAT:
            get_weapon_stat(data, rinfo);
            break;

        case messageType.WEAPON_PICKUP:
            weapon_pickup(data, rinfo);
            break; 
        
        case messageType.WEAPON_SHOOT:
            weapon_shoot(data, rinfo);
            break;

        case messageType.WEAPON_RELOAD:
            weapon_reload(data, rinfo);
            break;

        case messageType.GET_BULLETS:
            get_bullets(data, rinfo);
            break;

        case messageType.SET_BULLET_STAT:
            set_bullet_stat(data, rinfo);
            break;
        case messageType.GET_BULLET_STAT:
            get_bullet_stat(data, rinfo);
            break;
        
        case messageType.BULLET_DESTROY:
            bullet_destroy(data, rinfo);
            break;

        case messageType.SET_PLAYER_DAMAGE:
            set_player_damage(data, rinfo);
            break;
        case messageType.REFRESH_HP:
            refresh_hp(data,rinfo);
            break;
        default:
            console.log('Package received: unknown message type!');
            console.log(data);
            break;
    }

});

function refresh_hp(data, rinfo)
{
    data.playerStat = hosts[data.hostNumber]["players"][data.id];
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
}

function set_player_damage(data, rinfo)
{
    console.table(data);
    hosts[data.hostNumber]["players"][data.damagedId].player_health -= 3;
    data.damagedId = data.damagedId;
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
}

function bullet_destroy(data, rinfo)
{
    var bulletIndex = hosts[data.hostNumber].FindBulletIndex(data.id);
    if(bulletIndex > -1)
    {
        data.destroyedBullet = data.id;
        hosts[data.hostNumber].DestroyBullet(bulletIndex);
    }

}

function set_bullet_stat(data, rinfo)
{
    var bulletIndex = hosts[data.hostNumber].FindBulletIndex(data.id);
    if(bulletIndex > -1)
    {
        hosts[data.hostNumber]["bullets"][bulletIndex].x = data.x;
        hosts[data.hostNumber]["bullets"][bulletIndex].y = data.y;
    }
    
}

function get_bullet_stat(data, rinfo)
{
    var bulletIndex = hosts[data.hostNumber].FindBulletIndex(data.id);
    if(bulletIndex > -1)
    {
        data.bulletStat = hosts[data.hostNumber]["bullets"][bulletIndex];
        server.send(JSON.stringify(data), rinfo.port, rinfo.address);
    }
}

function get_bullets(data, rinfo)
{
    data.bullets = hosts[data.hostNumber]["bullets"];
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
}

function weapon_shoot(data, rinfo)
{
    hosts[data.hostNumber]["weapons"][data.weaponId].ammoInClip -= 1;
    data.weaponStat = hosts[data.hostNumber]["weapons"][data.weaponId];
    data.weaponId = data.weaponId;

    var shootedWeapon = hosts[data.hostNumber]["weapons"][data.weaponId];

    var weaponDirection = shootedWeapon.direction;

    var bulletId = undefined;

    switch(hosts[data.hostNumber]["weapons"][data.weaponId].type)
    {
        case "HandGun":
            do
            {
                bulletId = random_Id();
            }
            while(hosts[data.hostNumber].FindBulletIndex(bulletId) != -1)
            hosts[data.hostNumber].AddBullet(new Bullet(bulletId, shootedWeapon.x, shootedWeapon.y, weaponDirection+random_number(0,10), 40, shootedWeapon.ownerId));
        break;
        case "Rifle":
            do
            {
                bulletId = random_Id();
            }
            while(hosts[data.hostNumber].FindBulletIndex(bulletId) != -1)
            hosts[data.hostNumber].AddBullet(new Bullet(bulletId, shootedWeapon.x, shootedWeapon.y, weaponDirection+random_number(0,10), 40, shootedWeapon.ownerId));
        break;
        case "Shotgun":
            do
            {
                bulletId = random_Id();
            }
            while(hosts[data.hostNumber].FindBulletIndex(bulletId) != -1) 
            hosts[data.hostNumber].AddBullet(new Bullet(bulletId, shootedWeapon.x, shootedWeapon.y, weaponDirection+random_number(-20,20), 40, shootedWeapon.ownerId));

            do
            {
                bulletId = random_Id();
            }
            while(hosts[data.hostNumber].FindBulletIndex(bulletId) != -1)
            hosts[data.hostNumber].AddBullet(new Bullet(bulletId, shootedWeapon.x, shootedWeapon.y, weaponDirection+random_number(-20,20), 40, shootedWeapon.ownerId));

            do
            {
                bulletId = random_Id();
            }
            while(hosts[data.hostNumber].FindBulletIndex(bulletId) != -1)
            hosts[data.hostNumber].AddBullet(new Bullet(bulletId, shootedWeapon.x, shootedWeapon.y, weaponDirection+random_number(-20,20), 40, shootedWeapon.ownerId));
         break;
            
    }
    
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
}

function weapon_reload(data, rinfo)
{
    hosts[data.hostNumber]["weapons"][data.weaponId].ammoInClip = hosts[data.hostNumber]["weapons"][data.weaponId].maxAmmo;
    data.weaponStat = hosts[data.hostNumber]["weapons"][data.weaponId];
    data.weaponId = data.weaponId;
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
    //console.table(data);
}

function weapon_pickup(data, rinfo)
{

    if(data.ownerId == undefined)
    {
        data.previousOwnerId = hosts[data.hostNumber]["weapons"][data.weaponId].ownerId;
        hosts[data.hostNumber]["weapons"][data.weaponId].ownerId = undefined;
        data.weaponId = data.weaponId;
        data.weaponStat = hosts[data.hostNumber]["weapons"][data.weaponId];
    }
    else
    {
        hosts[data.hostNumber]["weapons"][data.weaponId].ownerId = data.ownerId;
        data.weaponId = data.weaponId;
        data.weaponStat = hosts[data.hostNumber]["weapons"][data.weaponId];
    }
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
    //console.table(data);
}

function set_weapon_stat(data, rinfo)
{
    hosts[data.hostNumber]["weapons"][data.weaponId].x = data.x;
    hosts[data.hostNumber]["weapons"][data.weaponId].y = data.y;
    hosts[data.hostNumber]["weapons"][data.weaponId].direction = data.direction; 
    //console.table(hosts[data.hostNumber]["weapons"][0]);
}

function get_weapon_stat(data, rinfo)
{
    data.weaponStat = hosts[data.hostNumber]["weapons"][data.weaponId];
    data.weaponId = data.weaponId;
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
    //console.table(data.weaponStat);
}

function get_player_stat(data, rinfo)
{
    data.playerStat = hosts[data.hostNumber]["players"][data.id];
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
}

function set_player_stat(data, rinfo)
{
    hosts[data.hostNumber]["players"][data.id].key_left = data.key_left;
    hosts[data.hostNumber]["players"][data.id].key_right = data.key_right;
    hosts[data.hostNumber]["players"][data.id].key_up = data.key_up;
    hosts[data.hostNumber]["players"][data.id].key_down = data.key_down;
    hosts[data.hostNumber]["players"][data.id].key_shoot = data.key_shoot;
    hosts[data.hostNumber]["players"][data.id].x = data.x;
    hosts[data.hostNumber]["players"][data.id].y = data.y;
    hosts[data.hostNumber]["players"][data.id].direction = data.direction;
    hosts[data.hostNumber]["players"][data.id].image_blend = data.image_blend;
    //console.table(hosts[data.hostNumber]["players"][data.id]);
}

function get_new_players(data, rinfo)   
{
    data.players = hosts[data.hostNumber];
    //console.table(data.players);
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
}

function join_host(data, rinfo)
{    
    var number_of_players = hosts[data.hostNumber]["players"].length;
    hosts[data.hostNumber].AddPlayer(new Player(number_of_players, 0, 0, 0, data.userName, 0, 0, 0, 0, 0, 100));
    //console.log("Player "+ data.userName +" joined to: " + hosts[data.hostNumber][0].userName);
    data.id = number_of_players;
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
}

function get_hosts(data, rinfo)
{
    data.hosts = hosts;
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
}

function create_host(data, rinfo)
{
    var hostNumber = hosts.length;

    data.hostNumber = hostNumber;
    data.id = 0;
    hosts.push(new Host());
    hosts[data.hostNumber].AddPlayer(new Player(data.id, 288, 722, 0, data.userName, 0, 0, 0, 0, 0, 100));
    hosts[data.hostNumber].AddWeapon(new Weapon(580, 200, 0, 5, 5, undefined, weaponType.ShotGun, 20));
    hosts[data.hostNumber].AddWeapon(new Weapon(512, 384, 0, 12, 12, undefined,  weaponType.HandGun, 10));
    hosts[data.hostNumber].AddWeapon(new Weapon(160, 350, 0, 15, 15, undefined,  weaponType.Rifle, 5));
    hosts[data.hostNumber].AddWeapon(new Weapon(220, 800, 0, 5, 5, undefined, weaponType.ShotGun, 20));
    hosts[data.hostNumber].AddWeapon(new Weapon(860, 415, 0, 12, 12, undefined,  weaponType.HandGun, 10));
    hosts[data.hostNumber].AddWeapon(new Weapon(608, 640, 0, 15, 15, undefined,  weaponType.Rifle, 5));
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);

    console.table(hosts);
}

function stop_host(data, rinfo)
{
    console.log("host stopped!");
    var host_to_stop = hosts.indexOf(data.hostNumber);
    hosts.splice(host_to_stop, 1);
    data.res = "stopped";
    server.send(JSON.stringify(data), rinfo.port, rinfo.address);
    //console.table(hosts);
}

function random_number(min, max) 
{
    var number = Math.random() * (max - min) + min;
    return number;
}

function random_Id(length = 6) 
{
    return Math.random().toString(36).substring(2, length+2);
}
server.bind(8080);