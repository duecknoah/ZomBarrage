///scr_createWeaponsFromDS(ds_list);
// This will create all of the itemWeapon instances based off a ds_list

var weapons = argument0; 

// Remove all weapons on ground
with (obj_itemWeapon) {
    instance_destroy();
}

// recreate from WOG data
for (var i = 0; i < ds_list_size(weapons); i ++) {
    var totalWeaponData = weapons[| i];
    var weaponStatData = totalWeaponData[? "weapon"];
    var weaponInst = instance_create(totalWeaponData[? "x"], totalWeaponData[? "y"], obj_itemWeapon);
    
    ds_map_copy(weaponInst.setWeaponTo, weaponStatData);
}
