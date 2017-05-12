///scr_addItemWeaponToWOG(id);
// This adds the specified obj_itemWeapon entity to the weaponsOnGround ds_list database
// stored in obj_weaponDB.

var instId = argument0;
var weaponData = ds_map_create();

// Put the instance weapon data into a ds_map
ds_map_add(weaponData, "x", instId.x);  
ds_map_add(weaponData, "y", instId.y);
ds_map_add(weaponData, "weapon", instId.weapon);

// Add instance weapon data to weapons on ground database
ds_list_add(obj_weaponDB.weaponsOnGround, weaponData);
