///scr_mapMenuGui(x, y, mapAssetIndex, mapImage, desc, scale);
// draw map menu gui and make it interactive
// NOTE that this will not properly work when used
// outside of the obj_MenuController Draw GUI event due to
// it using some variables that are not just temporary.

var _x = argument0; // x coordinate (top left) of the gui
var _y = argument1; // y coordinate (top left) of the gui
var _map = argument2; // The asset of the level, using rm_level for example
var _mapImage = argument3; // The sprite being used as the map image
var _mapDesc = argument4; // The description of the map
var _scale = argument5; // The draw scale of the gui

var _mapImageX = _x + (9 * menuScale); // The x coordinate of the mapImageX
var _mapImageY = _y + (9 * menuScale); // The y coordinate of the mapIamgeY
var _mapDescX = _x + (27 * menuScale);
var _mapDescY = _y + (74 * menuScale);
var _mapDescW = (224 * menuScale) - (27 * menuScale);

draw_sprite_ext(spr_mapMenuGui, 0, _x, _y, _scale, _scale, 0, c_white, 1);
// If _mapImage is string "NULL", don't draw mapImage
if (!is_string(_mapImage)) {
draw_sprite_ext(_mapImage, 0, _mapImageX, _mapImageY, _scale / 4, _scale / 4, 0, c_white, 1);
}

// Buttons
var _backArrowMapX = _x + (sprite_get_width(spr_arrowButton) * menuScale) + (2 * menuScale); // The back arrow to go to previous map in menu
var _backArrowMapY = _y + (73 * menuScale); // The back arrow to go to the previous map in menu
var _forwardArrowMapX = _x + (238 * menuScale); // The back arrow to go to the next map in menu
var _forwardArrowMapY = _y + (73 * menuScale); // The forward arrow to go to the next map in menu
var _scoresX = _x + (21 * menuScale); // the x coordinate of the button that opens the scores for the current map
var _scoresY = _y + (113 * menuScale); // the y coordinate of the button that opens the scores for the current map
var _difficultyX = _x + (101 * menuScale); // the x coordinate of the button that opens the difficulty menu
var _difficultyY = _y + (113 * menuScale); // the y coordinate of the button that opens the difficulty menu
var _surviveX = _x + (185 * menuScale); // the x coordinate of the button that starts the map
var _surviveY = _y + (113 * menuScale); // the y coordinate of the button that starts the map
// Symbols
var _lockX = _x + (119 * menuScale); // the x coordinate of the lock / unlock symbol that says if the map is locked or not
var _lockY = _y + (25 * menuScale); // the x coordinate of the lock / unlock symbol that says if the map is locked or not

// Back arrow button
if (scr_buttonGuiSpriteExt(_backArrowMapX, _backArrowMapY, spr_arrowButton, -menuScale, menuScale) == 2) {
    if (mapViewed == 0) {
        currentMenu = "LevelSelect-Start";
    }
    else {
        mapViewed --;
    }
}

// Forward arrow button
if (scr_buttonGuiSpriteExt(_forwardArrowMapX, _forwardArrowMapY, spr_arrowButton, menuScale, menuScale) == 2) {
    if (mapViewed < array_length_1d(map) - 1) {
        mapViewed ++;
    }
}

// Score button
scr_buttonGuiSprite(_scoresX, _scoresY, spr_scoresButton, menuScale);

// Difficulty button
scr_buttonGuiSprite(_difficultyX, _difficultyY, spr_difficultyButton, menuScale);

// Survive Button
if (scr_buttonGuiSprite(_surviveX, _surviveY, spr_surviveButton, menuScale) == 2) {
    // Start Game transition
    currentMenu = "LevelSelect-Game";
}

draw_text_ext(_mapDescX, _mapDescY, _mapDesc, -1, _mapDescW);