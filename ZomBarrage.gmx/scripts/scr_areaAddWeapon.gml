/// scr_areaAddWeapon(area, weaponType, ammo);
/* Adds weapon to an loot areas inventory
returns false, unable to add weapon
returns true, able to add weapon
*/

var _area = argument0;
var _weaponName = argument1;
var _ammo = argument2;

/* Loop through the inventory and see if it
 * can fit into an empty slot.
*/

for(var i=0; i<array_length_1d(_area.inventory); i++) {
    // If empty slot
    if (_area.inventory[i] == "") {
        _area.inventory[i] = _weaponName;
        _area.inventoryAmmo[i] = _ammo;
        return true;
    }
}

return false;
