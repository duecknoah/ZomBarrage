///scr_buttonGuiUpgrade(x, y, icon, description, cost, currentStat, minStat, maxStat, scale, alpha);
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
 * currentStat - the current number this upgrade stat is (ex. 100)
 * minStat - the lowest number this stat can be
 * maxStat - the highest number this stat can be
 * scale - the scale to draw the button
*/

var _x = argument0;
var _y = argument1;
var _icon = argument2;
var _desc = argument3;
var _cost = argument4;
var _currentStat = argument5;
var _minStat = argument6;
var _maxStat = argument7;
var _scale = argument8;
var _alpha = argument9;

// Draw button background n stuff
var _w = sprite_get_width(spr_upgradeButton) * _scale;
var _h = sprite_get_height(spr_upgradeButton) * _scale;
var _canAfford = (obj_player.points >= _cost); // can the player afford the upgrade?

// Draw red button if can't afford or if the current stat number is 
// at it's max or minimum
if (!_canAfford || _currentStat == _minStat || _currentStat == _maxStat) {
    draw_sprite_ext(spr_upgradeButton, 3, _x, _y, _scale, _scale, 0, c_white, _alpha);
}
else {
// else If button pressed, purchase upgrade, run script provided
    if (scr_buttonGuiSprite(_x, _y, spr_upgradeButton, _scale) == 2) {
        obj_player.points -= _cost;
        return true; // button pressed
    }
}

// Keep current stat within range
_currentStat = clamp(_currentStat, _minStat, _maxStat);

if (_currentStat == _minStat) {
    _desc += " (at Minimum Level)";
    _cost = -1;
}

if (_currentStat == _maxStat) {
    _desc += " (at Maximum Level)";
    _cost = -1;
}

// Draw icon

// Draw description
var _xOff = 20 * _scale;
var _yOff = 1 * _scale; 
draw_text(_x + _xOff, _y + _yOff, _desc);

// Draw Cost (amt of points)
if (_cost != -1) {
    var _xOff = 141 * _scale;
    var _yOff = 1 * _scale; 
    draw_text(_x + _xOff, _y + _yOff , string(_cost) + " points");
}
