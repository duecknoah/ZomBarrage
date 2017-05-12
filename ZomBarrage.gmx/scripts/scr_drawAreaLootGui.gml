///scr_drawAreaLootGui(x, y, area, scale, alpha);
// draws the area's loot in a tradable and usuable gui
var _x = argument0;
var _y = argument1;
var _area = argument2;
var _scale = argument3;
var _alpha = argument4;

// iterate through the inventory, drawing each slot
for(var _i = 0; _i < ds_list_size(_area.inventory); _i ++) {
    var xoff = _i * (sprite_get_width(spr_itemWeapon) + 8) * guiScale;
    
    if (scr_WeaponToId(_area.inventory[| _i]) != 0) {
        /*
        draw_sprite_ext(spr_itemWeapon, 
                        scr_WeaponToId(_area.inventory[| _i]), 
                        _x + xoff, 
                        _y, 
                        _scale, 
                        _scale, 
                        0, 
                        c_white, 
                        _alpha);
        */
        scr_drawWeaponGui(_x + xoff, _y, _area.inventory[| _i], true, _scale);
        // Swap weapon with one in inventory (selected weapon)
        var swapYoff = ((sprite_get_height(spr_itemWeapon) / 2) + 4) * guiScale; 
        // If swap button pressed, swap this weapon with current selected inventory weapon
        if (scr_buttonGuiSpriteCentered(_x + xoff, _y + swapYoff, spr_lootSwap, _scale) == 2) {
            // holds weapon in swap
            var holdPlayerW = ds_map_create();
            var holdAreaW = ds_map_create();
            ds_map_copy(holdPlayerW, obj_player.inventory[| obj_player.selectedSlot]);
            ds_map_copy(holdAreaW, _area.inventory[| _i]);
            
            // Just take the ammo If the player is selecting the same weapon as the one being swapped with
            if (scr_WeaponToId(holdPlayerW) == scr_WeaponToId(holdAreaW)) {
                var playerWeapon = obj_player.inventory[| obj_player.selectedSlot];
                var areaWeapon = _area.inventory[| _i];
                playerWeapon[? "ammo"] += areaWeapon[? "ammo"];
                areaWeapon[? "ammo"] = 0;
            }
            else {
            // Else if it is a different weapon, just swap it
                obj_player.inventory[| obj_player.selectedSlot] = holdAreaW;
                _area.inventory[| _i] = holdPlayerW;
            }
        }
    }
}

// Checkmark button, when pressed, teleport player back to outside of house, end looting
if (scr_buttonGuiSprite(view_wport[0] / 2, view_hport[0] - 128, spr_checkMarkButton, _scale) == 2) {
    with (obj_player) {
        state = "default";
        x = lootXPrev;
        y = lootYPrev;
        hidePlayer = false; // re-show player
        lootTimer = -1;
        lootArea = noone;
    }
}
