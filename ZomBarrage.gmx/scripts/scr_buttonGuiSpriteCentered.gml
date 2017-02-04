///scr_buttonGuiSpriteCentered(x, y, sprite, scale);
/* returns 0 when not hovering, not pressed
 * returns 1 when hovering, not pressed
 * returns 2 when hovering, and pressed
*/
// The above numbers will coordinate with
// the intensity of the button sprite

var _x = argument0;
var _y = argument1;
var _sprite = argument2;
var _scale = argument3;

var _w = sprite_get_width(_sprite) * _scale;
var _h = sprite_get_height(_sprite) * _scale;
var val = scr_buttonGui(_x - (_w / 2), _y - (_h / 2), _w, _h);
var _alpha = 1;

switch (val) {
    case 0: _alpha /= 2;
    break;
    case 1: draw_set_blend_mode(bm_normal);
    break;
    case 2: draw_set_blend_mode(bm_add);
    break;
}

draw_sprite_ext(_sprite, val, _x, _y, _scale, _scale, 0, c_white, _alpha);
draw_set_blend_mode(bm_normal);

return val;