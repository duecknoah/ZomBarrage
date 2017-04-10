///scr_lootArea(instance_id);
// Will loot the area with instance_id for player

var _area = argument0;

var gunDropChance = 5 - lootRank;
// Ammo multiplier goes from 0 at the very least and 2 at the very most. 
// The higher the loot rank, the more the minimum raises, and the more the maximum raises
var ammoMultiplierDropMin = 1 - (1 / lootRank);
var ammoMultiplierDropMax = 1 - (1 / lootRank) + 1;
var lootKeyAmountDrop = lootRank + 1;

var hasFoundWeapon = false;

if (round(random(gunDropChance))) {
    // We add one to totalWeapons to not include fists (1 - totalWeapons is the range)
    // and global.totalWeapons already doesn't include fists
    var _weaponData = scr_IdToWeapon(round(random_range(1, obj_weaponDB.totalWeapons)));
    var _weaponName = _weaponData[? "name"];
    var _ammo = _weaponData[? "ammo"] * random_range(ammoMultiplierDropMin, ammoMultiplierDropMax);
    _ammo = floor(_ammo);
    // Make it so weapons don't start empty on ammo
    if (_ammo <= 0) {
        _ammo = 1;
    }
    
    // Add weapon to area inventory
    scr_areaAddWeapon(_area, _weaponName, _ammo);
    hasFoundWeapon = true;
}

// Prevent area from being looted again by marking it as looted
with (_area) {
    looted = true;
}
