/// scr_PlayerAddWeapon(weapon);
/* adds a weapon to a players inventory,
returns -1
    -   nothing happened 
returns 0
    -   user just picked up just the ammo
returns 1 
    -   user picked up weapon
*/

var weapon = argument0;
var totalPrimarySlots = 2; // total primary slots
var totalSecondarySlots = 4; // total secondary slots

/* Loop through the inventory and see if it
can fit into an empty slot. If player already
has the weapon being picked up, just add the ammo
from it
*/
if (scr_WeaponToId(weapon) == 0) {
    show_debug_message("Cannot add an empty item!!");
    return -1;
}

// iSearchTypes
// 0 - inventory same weapon stacking (ammo only)
// 1 - Empty slot search
for (var iSearchType = 0; iSearchType <= 1; iSearchType ++) {
    for (var i = 0; i < ds_list_size(obj_player.inventory); i ++) {
        var isInValidInventory = false; // is true when the item being put in the players inventory is in the correct place (primary or secondary?)
        // Primary inventory weapon handling
        if (i < totalPrimarySlots) {
            if (weapon[? "isPrimary"] == true) {
                isInValidInventory = true;
            }
        }
        // Secondary inventory Weapon handling
        else if (i < totalPrimarySlots + totalSecondarySlots) {
            if (weapon[? "isPrimary"] == false) {
                isInValidInventory = true;
            }   
        }
        
        // Don't try to add this weapon if its not able to
        // fit into the proper inventory area (primary or secondary?)
        if (!isInValidInventory) {
            continue;
        }
        
        switch(iSearchType) {
            case 0: // 0 - inventory same weapon stacking (ammo only)
                if (scr_WeaponToId(inventory[| i]) == weapon[? "id"]) {
                    var playerWeaponData = obj_player.inventory[| i];
                    playerWeaponData[? "ammo"] += weapon[? "ammo"]; // add ammo
                    // Turn on flashlight if it is one
                    if (weapon[? "name"] = "Flashlight") {
                        obj_player.flashLightOn = true;
                    }
                    return 0; 
                }
            break;
            case 1: // 1 - Empty slot search
                // If empty slot
                if (scr_WeaponToId(inventory[| i]) == 0) {
                    // Copy weapon data into players inventory
                    ds_map_copy(obj_player.inventory[| i], weapon);
                    // Turn on flashlight if it is one
                    if (weapon[? "id"] == 4) {
                        obj_player.flashLightOn = true;
                    }
                    return 1;
                }
            break;
        }
    }
}

return -1;
