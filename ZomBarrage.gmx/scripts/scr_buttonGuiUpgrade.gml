///scr_buttonGuiUpgrade(x, y, icon, description, cost, scale, alpha);
/* Draws / creates a usuable upgrade button for a specific 
 * upgrade, used in the obj_guiController to add upgrade options.
 * This function will return 'true' when purchasing the upgrade
 * This function will return 'false' otherwise.
 *
 * x - xpos of button
 * y - ypos of button
 * icon - the icon sprite to draw
 * description - the description of the upgrade
 * cost - the cost (in points) of the upgrade
 * scale - the scale to draw the button
*/

var _x = argument0;
var _y = argument1;
var _icon = argument2;
var _desc = argument3;
var _cost = argument4;
var _scale = argument5;
var _alpha = argument6;

// Draw button background n stuff
var _w = sprite_get_width(spr_upgradeButton) * _scale;
var _h = sprite_get_height(spr_upgradeButton) * _scale;
var _canAfford = (obj_player.points >= _cost); // can the player afford the upgrade?

// Draw red button if can't afford
if (!_canAfford) {
    draw_sprite_ext(spr_upgradeButton, 3, _x, _y, _scale, _scale, 0, c_white, _alpha);
}
else {
// else If button pressed, purchase upgrade, run script provided
    if (scr_buttonGuiSprite(_x, _y, spr_upgradeButton, _scale) == 2) {
        obj_player.points -= _cost;
        return true; // button pressed
    }
}

// Draw icon

// Draw description
var _xOff = 20 * _scale;
var _yOff = 1 * _scale; 
draw_text(_x + _xOff, _y + _yOff, _desc);

// Draw Cost (amt of points)
var _xOff = 141 * _scale;
var _yOff = 1 * _scale; 
draw_text(_x + _xOff, _y + _yOff , string(_cost) + " points");