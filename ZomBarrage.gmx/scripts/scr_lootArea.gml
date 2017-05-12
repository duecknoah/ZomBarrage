///scr_lootArea(instance_id_of_area);
// Will loot the area for the player

var _area = argument0;

var gunDropChance = obj_player.lootRank / 5;
var maxPossibleWeaponAmt = 3;
// Ammo multiplier goes from 0 at the very least and 2 at the very most. 
// The higher the loot rank, the more the minimum raises, and the more the maximum raises
var ammoMultiplierDropMin = 1 - (1 / obj_player.lootRank);
var ammoMultiplierDropMax = 1 - (1 / obj_player.lootRank) + 1;
var lootKeyAmountDrop = obj_player.lootRank + 1;

var hasFoundWeapon = false;

for (var i = 0; i < maxPossibleWeaponAmt; i ++) {
    if (random(1) < gunDropChance) {
        // We add one to totalWeapons to not include fists (1 - totalWeapons is the range)
        // and global.totalWeapons already doesn't include fists
        var _weapon = scr_IdToWeapon(round(random_range(1, obj_weaponDB.totalWeapons - 1)));
        _weapon[? "ammo"] *= random_range(ammoMultiplierDropMin, ammoMultiplierDropMax);
        _weapon[? "ammo"] = floor(_weapon[? "ammo"]);
        // Make it so weapons don't start empty on ammo
        if (_weapon[? "ammo"] <= 0) {
            _weapon[? "ammo"] = 1;
        }
        
        // Add weapon to area inventory
        scr_areaAddWeapon(_area, _weapon);
        hasFoundWeapon = true;
    }
}

// Prevent area from being looted again by marking it as looted
with (_area) {
    looted = true;
}
