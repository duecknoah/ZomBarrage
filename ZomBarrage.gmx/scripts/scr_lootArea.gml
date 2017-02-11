///scr_lootArea(instance_id);
// Will loot the area with instance_id for player

var _area = argument0;

var gunDropChance = 5 - lootRank;
var ammoAmountDropMin = (lootRank + 1) * 32;
var ammoAmountDropMax = (lootRank + 1) * 64;
var lootKeyAmountDrop = lootRank + 1;

var hasFoundWeapon = false;

if (round(random(gunDropChance))) {
    // We add one to totalWeapons to not include fists (1 - totalWeapons is the range)
    // and global.totalWeapons already doesn't include fists
    var _weaponName = scr_IdToWeaponName(round(random_range(1, obj_weaponDB.totalWeapons)));
    var _ammo = round(random_range(ammoAmountDropMin, ammoAmountDropMax));
    
    // provide a specific amount of ammo for loot keys
    if (_weaponName == "Loot Key") {
        _ammo = lootKeyAmountDrop;
    }
    // Add weapon to area inventory
    scr_areaAddWeapon(_area, _weaponName, _ammo);
    hasFoundWeapon = true;
}

// Prevent area from being looted again by marking it as looted
with (_area) {
    looted = true;
}
