///scr_IdToWeaponName(id)
// will return the coressponding name for the weapon id
// will return -1 if name / weapon doesn't exist

/* Note! To get total weapons, type global.totalWeapons
 * (set in obj_roomObjectsInit). This DOESN'T include fists
*/

_idToSearch = argument0;

if (_idToSearch > 0 && _idToSearch < obj_weaponDB.totalWeapons) {
    var _weapon = obj_weaponDB.weapon[| _idToSearch];
    return _weapon[? "name"];
}

return "fists"; // return fists by default
