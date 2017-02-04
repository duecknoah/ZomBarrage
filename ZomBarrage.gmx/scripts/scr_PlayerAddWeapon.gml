/// scr_PlayerAddWeapon(weaponType, ammo);
/* adds a weapon to a players inventory,
returns -1
    -   nothing happened 
returns 0
    -   user just picked up just the ammo
returns 1 
    -   user picked up weapon
*/

var weaponType = argument0;
var ammo = argument1;

/* Loop through the inventory and see if it
can fit into an empty slot. If player already
has the weapon being picked up, just add the ammo
from it
*/

for(var i=0; i<array_length_1d(obj_player.inventory); i++) {
    // If empty slot
    if (inventory[i] == "fists") {
        obj_player.inventory[i] = weaponType;
        obj_player.inventoryAmmo[i] = ammo;
        // Turn on flashlight if it is one
        if (weaponType = "Flashlight") {
            flashLightOn = true;
        }
        return 1;
    }
    else if (inventory[i] == weaponType) {
        obj_player.inventoryAmmo[i] += ammo;
        return 0;
    }
}

return -1;