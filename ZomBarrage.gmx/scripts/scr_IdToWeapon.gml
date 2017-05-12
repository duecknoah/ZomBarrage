 ///scr_IdToWeapon(id);
// will return the coressponding name for the weapon id
// will return default if id / weapon doesn't exist

/* Note! To get total weapons, type global.totalWeapons
 * (set in obj_roomObjectsInit). This DOESN'T include fists
*/

var _searchId = argument0;

// If id is within the range of weapon id's
if (_searchId < obj_weaponDB.totalWeapons && _searchId >= 0) {
    var _weapon = ds_map_create(); 
    ds_map_copy(_weapon, obj_weaponDB.weapon[| _searchId]);
    return _weapon;
}
return 0;
