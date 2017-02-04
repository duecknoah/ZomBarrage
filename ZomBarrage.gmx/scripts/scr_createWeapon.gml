///scr_createWeapon(x, y, weaponId, ammo);
/* Creates a weapon entity at
 * specified coords
 */

xx = argument0;
yy = argument1;
weaponId = argument2; 
ammo = argument3;

if (weaponId == -1) {
    return -1;
}

with (instance_create(xx, yy, obj_itemWeapon)) {
    weaponType = scr_IdToWeapon(other.weaponId);
    initWeaponType = weaponType; // prevent reseting ammo
    image_index = scr_WeaponToId(weaponType);
    ammo = other.ammo;
}