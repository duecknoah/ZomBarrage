///scr_drawInventoryGui(x, y, scale, alpha);
var _xx = argument0;
var _yy = argument1;
var _scale = argument2;
var _alpha = argument3;
// Draw inventory GUI

draw_sprite_ext(spr_inventory, obj_player.selectedSlot, _xx, _yy, _scale, _scale, 0, c_white, _alpha);

var weaponDrawOff = sprite_get_width(spr_itemWeapon) / 2 * _scale;
var inventorySlotX = _xx + (3 * _scale);
var inventorySlotY = _yy - ((sprite_get_height(spr_inventory) / 2) * _scale) + (4 * _scale);
inventorySlotX += weaponDrawOff;
inventorySlotY += weaponDrawOff;
var ammoX = inventorySlotX + weaponDrawOff + 8;
var ammoY = inventorySlotY;

// weapon sprites in slots

for(i = 0; i < 2; i ++) {
    // Draw weapon sprite
    var ID = scr_WeaponNameToId(obj_player.inventory[i]);
    draw_sprite_ext(spr_itemWeapon, ID, inventorySlotX, inventorySlotY, _scale, _scale, 0, c_white, _alpha);
    
    // Draw ammo amount (ceiled to remove decimals for certain weapons)
    draw_text(ammoX, ammoY, string(ceil(obj_player.inventoryAmmo[i])));
    
    inventorySlotY += 36 * _scale;
    ammoY += 36 * _scale;
}

//draw_sprite_ext(spr_itemWeapon, 5, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _scale / 2, _scale / 2, 0, c_white, 1);

// Shoot delay cooldown

for(i=0; i<2; i++) {
    // top == max shootdelay
    // bottom == 0
    
    // Keep max shoot delay updated
    if (obj_player.shootDelay[i] > shootDelayMax[i]) {
        shootDelayMax[i] = obj_player.shootDelay[i];
    }
    
    // If shoot delay is over, reset shootDelayMax and don't draw this one (continue to next slot)
    if (obj_player.shootDelay[i] <= 0) {
        shootDelayMax[i] = 0;
        continue;
    }
    
    var _delayPerc = obj_player.shootDelay[i] / shootDelayMax[i];
    var _x1, _y1, _x2, _y2;
    var _yoff = -37;
    
    if (i == 0) {
        // Slot 0
        _x1 = _xx + (52 * _scale);
        _y1 = _yy + ((2 + _yoff) * _scale);
        _x2 = _xx + (56 * _scale);
        _y2 = _yy + ((35 + _yoff) * _scale);
    }
    else {
        // Slot 1
        _x1 = _xx + (52 * _scale);
        _y1 = _yy + ((40 + _yoff) * _scale);
        _x2 = _xx + (56 * _scale);
        _y2 = _yy + ((73 + _yoff) * _scale);    
    }
    
    /*  Make delay bar be lerped between top and 
     * bottom of bar based on delay percentage
    */
    _y1 = lerp(_y2, _y1, _delayPerc);
    
    // Draw delay bar
    draw_set_colour(c_yellow);
    draw_rectangle(_x1, _y1, _x2, _y2, 0);
    draw_set_colour(c_white);
}
