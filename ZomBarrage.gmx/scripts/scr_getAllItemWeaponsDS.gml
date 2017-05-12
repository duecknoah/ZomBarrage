///scr_getAllItemWeaponsDS();
// This gets all weapon dynamic data and returns it in a ds_list to be saved
// stored in obj_weaponDB.

var weaponData = ds_map_create();
var allWeapons = ds_list_create();

for (var i = 0; i < instance_number(obj_itemWeapon); i ++) {
    var instId = instance_find(obj_itemWeapon, i);
    
    // Put the instance weapon data into a ds_map
    ds_map_add(weaponData, "weapon", instId.weapon);
    ds_map_add(weaponData, "x", instId.x);
    ds_map_add(weaponData, "y", instId.y);
    
    // Add instance weapon data to weapons on ground database
    // First create a new ds_map inside weaponsOnGround to be copied onto
    ds_list_add(allWeapons, ds_map_create());
    // Next copy the weaponData into that newly created ds_map within WOG
    ds_map_copy(allWeapons[| (ds_list_size(allWeapons) - 1)], weaponData);
    // reset
    ds_map_clear(weaponData);
}
ds_map_destroy(weaponData);
return allWeapons;
