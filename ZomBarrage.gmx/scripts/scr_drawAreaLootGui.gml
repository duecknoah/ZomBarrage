///scr_drawAreaLootGui(x, y, area, scale, alpha);
// draws the area's loot in a tradable and usuable gui
var _x = argument0;
var _y = argument1;
var _area = argument2;
var _scale = argument3;
var _alpha = argument4;

// iterate through the inventory, drawing each slot
for(var _i = 0; _i < array_length_1d(_area.inventory); _i ++) {
    var xoff = _i * (sprite_get_width(spr_itemWeapon) + 8) * guiScale;
    
    if (_area.inventory[_i] != "") {
        draw_sprite_ext(spr_itemWeapon, 
                        scr_WeaponToId(_area.inventory[_i]), 
                        _x + xoff, 
                        _y, 
                        _scale, 
                        _scale, 
                        0, 
                        c_white, 
                        _alpha);
        // Swap weapon with one in inventory (selected weapon)
        var swapYoff = ((sprite_get_height(spr_itemWeapon) / 2) + 4) * guiScale; 
        // If swap button pressed, swap this weapon with current selected inventory weapon
        if (scr_buttonGuiSpriteCentered(_x + xoff, _y + swapYoff, spr_lootSwap, _scale) == 2) {
            var holdW = obj_player.inventory[obj_player.selectedSlot];
            var holdA = obj_player.inventoryAmmo[obj_player.selectedSlot];
            
            obj_player.inventory[obj_player.selectedSlot] = _area.inventory[_i];
            obj_player.inventoryAmmo[obj_player.selectedSlot] = _area.inventoryAmmo[_i];
            _area.inventory[_i] = holdW;
            _area.inventoryAmmo[_i] = holdA;
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