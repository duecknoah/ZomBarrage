///scr_buttonGuiSpriteText(x, y, sprite, scale, text, textCol);
/* returns 0 when not hovering, not pressed
 * returns 1 when hovering, not pressed
 * returns 2 when hovering, and pressed
*/
// The above numbers will coordinate with
// the image_index within the sprite used

var _x = argument[0];
var _y = argument[1];
var _sprite = argument[2];
var _scale = argument[3];
var _text = argument[4];
var _textCol = argument[5];
var _alpha = 1;
if (argument_count == 7) {
    _alpha = argument[6];
}

var _w = sprite_get_width(_sprite) * _scale;
var _h = sprite_get_height(_sprite) * _scale;
var val = scr_buttonGui( _x, _y, _w, _h);

switch (val) {
    case 0: _alpha /= 2;
    break;
    case 1: draw_set_blend_mode(bm_normal);
    break;
    case 2: draw_set_blend_mode(bm_add);
    break;
}

draw_sprite_ext(_sprite, 0, _x, _y, _scale, _scale, 0, c_white, _alpha);
draw_set_blend_mode(bm_normal);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(_textCol);
draw_text(_x + (_w / 2), _y + (_h / 2), _text); // draw centered text
// reset settings after draw
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

return val;