/// scr_areaAddWeapon(area, weapon);
/* Adds weapon to an loot areas inventory
returns false, unable to add weapon
returns true, able to add weapon
*/

var _area = argument0;
var _weapon = argument1;

/* Loop through the inventory and see if it
 * can fit into an empty slot.
*/

for(var i = 0; i < ds_list_size(_area.inventory); i ++) {
    // If empty slot
    if (scr_WeaponToId(_area.inventory[| i]) == 0) {
        _area.inventory[| i] = _weapon;
        return true;
    }
}
// No room in inventory
return false;
