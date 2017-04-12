///scr_buttonGui(x, y, w, h);
/* returns 0 when not hovering, not pressed
 * returns 1 when hovering, not pressed
 * returns 2 when hovering, and pressed
*/

var _x = argument0;
var _y = argument1;
var _w = argument2;
var _h = argument3;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// if mouse is within button
if (mx >= _x && mx <= _x + _w
 && my >= _y && my <= _y + _h) {
    if (mouse_check_button_pressed(mb_left)) {
        audio_play_sound(snd_button_click, 5, false);
        return 2; // pressed, hovering
    }
    else return 1; // not pressed, hovering
}
return 0; // not pressed, not hovering
