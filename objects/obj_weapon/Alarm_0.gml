d = ds_map_create();
ds_map_add(d, "hostNumber", global.hostNumber);
ds_map_add(d, "weaponId", weaponIDD);	
sendMapOverUDP("127.0.0.1", 8080, 1000, d, msgType.WEAPON_RELOAD);
