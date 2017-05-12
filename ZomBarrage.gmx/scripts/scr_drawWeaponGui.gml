/// scr_drawWeaponGui(x, y, weapon, showAmmo, scale);
// draws a weapon at the specific gui coordinates

var _x = argument0;
var _y = argument1;
var _weapon = argument2;
var _showAmmo = argument3;
var _scale = argument4;

// The width and height of the weapon sprite
var _width = sprite_get_width(spr_itemWeapon) / 4;
var _height = sprite_get_height(spr_itemWeapon) / 4;
// Be affected by the scale
_width *= _scale;
_height *= _scale;
var ammoX = _x + _width;
var ammoY = _y + _height;

// weapon sprites in slots
// Draw weapon sprite
var ID = scr_WeaponToId(_weapon);
draw_sprite_ext(spr_itemWeapon, ID, _x, _y, _scale, _scale, 0, c_white, 1);

// Draw ammo amount (ceiled to remove decimals for certain weapons)
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
var ammoAmt = ceil(scr_WeaponAmmoOf(_weapon));
if (ammoAmt > 1) {
    draw_text(ammoX, ammoY, string(ammoAmt));
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
