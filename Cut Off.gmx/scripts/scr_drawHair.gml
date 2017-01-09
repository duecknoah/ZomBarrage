///scr_drawHat(xoff, yoff, col);
// Draws the entity's (the one executing this script) hat on them (if any)
// based on there position and offsets given

var _xoff = argument0;
var _yoff = argument1;
var _col = argument2;

// If entity is not dead, draw hat offset from it's position
if (hair != noone) {
    draw_sprite_ext(spr_CivilianHair, hair, x + _xoff, y + _yoff, drawScale, drawScale, rotation, _col, 1);
}