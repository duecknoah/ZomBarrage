///scr_buttonGuiSpriteExt(x, y, sprite, subimg, xscale, yscale);
/* returns 0 when not hovering, not pressed
 * returns 1 when hovering, not pressed
 * returns 2 when hovering, and pressed
*/
// The above numbers will coordinate with
// the intensity of the button sprite

var _x = argument0;
var _y = argument1;
var _sprite = argument2;
var _subimg = argument3;
var _xscale = argument4;
var _yscale = argument5;

var _w = sprite_get_width(_sprite) * _xscale;
var _h = sprite_get_height(_sprite) * _yscale;
var val;
var _alpha = 1;

if (_w < 0 && _h < 0) {
    // Since width and height is (-), we need to move the x
    // and y back by width and height, then set width and height to zero in the
    // scr_buttonGui, that way it detects properly
    var newX = _x + _w;
    var newY = _y + _h;
    var newW = -_w;
    var newH = -_h;
    val = scr_buttonGui(newX, newY, newW, newH);
}
else if (_w < 0) {
    // Since width is (-), we need to move the x
    // back by width and set width to zero in the
    // scr_buttonGui, that way it detects properly
    var newX = _x + _w;
    var newW = -_w;
    val = scr_buttonGui(newX, _y, newW, _h);
}
else if (_h < 0) {
    // Since height is (-), we need to move the y
    // back by height, then set height to zero in the
    // scr_buttonGui, that way it detects properly
    var newY = _y + _h;
    var newH = -_h;
    val = scr_buttonGui(_x, newY, _w, newH);
}
else {
    val = scr_buttonGui(_x, _y, _w, _h);
}

switch (val) {
    case 0: _alpha /= 1.5;
    break;
    case 1: draw_set_blend_mode(bm_normal);
    break;
    case 2: draw_set_blend_mode(bm_add);
    break;
}

draw_sprite_ext(_sprite, _subimg, _x, _y, _xscale, _yscale, 0, c_white, _alpha);
draw_set_blend_mode(bm_normal);

return val;
