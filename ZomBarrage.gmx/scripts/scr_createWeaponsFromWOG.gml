///scr_createWeaponsFromWOG();
// This will create all of the itemWeapon instances based off the WOG ds_list
// stored in obj_weaponDB.

for (var i = 0; i < ds_list_size(obj_weaponDB.weaponsOnGround); i ++) {
    var weaponData = obj_weaponDB.weaponsOnGround[| i];
    
    with (instance_find(obj_itemWeapon, i)) {
        weapon = other.weaponData[? "weapon"];
    }
}
