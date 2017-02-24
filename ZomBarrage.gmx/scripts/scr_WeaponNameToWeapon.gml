///scr_WeaponNameToWeapon(name)
// will return the coressponding weapon from the weapon name
// will return fists if name / weapon doesn't exist

_nameToSearch = argument0;

var _id = scr_WeaponNameToId(_nameToSearch);

if (_id >= 0 && _id < obj_weaponDB.totalWeapons) {
    return obj_weaponDB.weapon[| _id];
}

return 0; // return fists by default
