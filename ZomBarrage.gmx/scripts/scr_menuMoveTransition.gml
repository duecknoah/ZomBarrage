///scr_menuMoveTransition(Menu, xUnit, yUnit);
// Note this must be used within the MenuController as
// it uses variables menuX and menuY to keep track of it
var _menu = argument[0];
// new x (or y) = -room_width (or room_height) * xUnit (or yUnit)
// this is relative to 0, 0 where one unit
// is -room_width (for x) or -room_height (for y)
var _xUnits = argument[1]; 
var _yUnits = argument[2];

// formula for transition: X += ((finalX) - currentX) * CONSTANT

var _finalX = -view_wport[0] * _xUnits;
var _finalY = -view_hport[0] * _yUnits;

menuX += (_finalX - menuX) * 0.1;
menuY += (_finalY - menuY) * 0.1;

// If done transitioning, return the value of the new menu, so the currentMenu will be equal to _menu (what we were transitioning to)
if (menuX == _finalX && menuY == _finalY) {
    currentMenu = _menu;
}
