///scr_WeaponToId(name)
// will return the coressponding id for the weapon name
// will return -1 if name / weapon doesn't exist

/* Note! To get total weapons, type global.totalWeapons
 * (set in obj_roomObjectsInit). This DOESN'T include fists
*/

_nameToSearch = argument0;

var currentWeaponObject;
var currentWeaponObjectName;
// Iterate through all of the weapons until we find the
// one we are looking for
for (var i = 0; i < obj_weaponDB.totalWeapons; i ++) {
    currentWeaponObject = obj_weaponDB.weapon[| i];
    currentWeaponObjectName = currentWeaponObject[? "name"];
    
    // If this object's name is the one we are looking for
    // return its id.
    if (currentWeaponObjectName == _nameToSearch) {
        return i;
    }
}
return 0; // return fists by default
