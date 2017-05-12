///scr_drawInventoryGui(x, y, scale, alpha);
var _xx = argument0;
var _yy = argument1;
var _scale = argument2;
var _alpha = argument3;
// Draw inventory GUI

var primaryInvX = _xx;
var primaryInvY = _yy + (sprite_get_height(spr_inventory) / 2 * _scale);
var primaryInvSubimg = clamp(obj_player.selectedSlot, 0, 2);
draw_sprite_ext(spr_inventory, primaryInvSubimg, primaryInvX, primaryInvY, _scale, _scale, 0, c_white, _alpha);

var weaponDrawOff = sprite_get_width(spr_itemWeapon) / 2 * _scale;
var inventorySlotX = primaryInvX + (3 * _scale);
var inventorySlotY = primaryInvY - ((sprite_get_height(spr_inventory) / 2) * _scale) + (4 * _scale);
inventorySlotX += weaponDrawOff;
inventorySlotY += weaponDrawOff;
var pAmmoX = primaryInvX + 35 * _scale;
var pAmmoY = primaryInvY - (sprite_get_height(spr_inventory) / 2 * _scale) + 35 * _scale;


// weapon sprites in slots
for(i = 0; i < 2; i ++) {
    // Draw weapon sprite
    var ID = scr_WeaponToId(obj_player.inventory[| i]);
    draw_sprite_ext(spr_itemWeapon, ID, inventorySlotX, inventorySlotY, _scale, _scale, 0, c_white, 1);
    
    // Draw ammo amount (ceiled to remove decimals for certain weapons)
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    var ammoAmt = ceil(scr_WeaponAmmoOf(obj_player.inventory[| i]));
    if (ammoAmt > 1) {
        draw_text(pAmmoX, pAmmoY, string(ammoAmt));
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    inventorySlotY += 36 * _scale;
    pAmmoY += 36 * _scale;
}

// Shoot delay cooldown
for(i = 0; i < 2; i ++) {
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
        _x1 = primaryInvX + (41 * _scale);
        _y1 = primaryInvY + ((2 + _yoff) * _scale);
        _x2 = primaryInvX + (45 * _scale);
        _y2 = primaryInvY + ((35 + _yoff) * _scale);
    }
    else {
        // Slot 1
        _x1 = primaryInvX + (41 * _scale);
        _y1 = primaryInvY + ((40 + _yoff) * _scale);
        _x2 = primaryInvX + (45 * _scale);
        _y2 = primaryInvY + ((73 + _yoff) * _scale);    
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

// Secondary Inventory
var sInventoryX = _xx;
var sInventoryY = _yy + ((sprite_get_height(spr_inventory)) * _scale);
var secondaryInvsubImg = clamp(obj_player.selectedSlot - 1, 0, 4);
draw_sprite_ext(spr_secondaryInventory, secondaryInvsubImg, sInventoryX, sInventoryY, _scale, _scale, 0, c_white, _alpha);
for (var i = 2; i <= 5; i ++) {
    var slotX, slotY; // relative to top left of secondary inventory
    
    switch(i) {
        case 2: // Slot 2
            slotX = 3;
            slotY = 3;
        break;
        case 3: // Slot 3
            slotX = 22;
            slotY = 3;
        break;
        case 4: // Slot 4
            slotX = 3;
            slotY = 22;
        break;
        case 5: // Slot 5
            slotX = 22;
            slotY = 22;
        break;
    }
    // Make it offset by half due to centered sprite
    slotX += sprite_get_width(spr_itemWeapon) / 4;
    slotY += sprite_get_height(spr_itemWeapon) / 4;
    // Be affected by the scale of the gui
    slotX *= _scale;
    slotY *= _scale;
    var sAmmoX = sInventoryX + slotX + (8 * _scale);
    var sAmmoY = sInventoryY + slotY + (8 * _scale);
    
    // TODO: Draw sprite @ sInventory + slot coordinates
    var ID = scr_WeaponToId(obj_player.inventory[| i]);
    draw_sprite_ext(spr_itemWeapon, ID, sInventoryX + slotX, sInventoryY + slotY, _scale / 2, _scale / 2, 0, c_white, 1);
    
    // Draw ammo amount (ceiled to remove decimals for certain weapons)
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    var ammoAmt = ceil(scr_WeaponAmmoOf(obj_player.inventory[| i]));
    if (ammoAmt > 1) {
        draw_text(sAmmoX, sAmmoY, string(ammoAmt));
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
} 