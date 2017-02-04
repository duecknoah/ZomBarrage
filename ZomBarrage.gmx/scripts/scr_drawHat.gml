///scr_drawHat(xoff, yoff);
// Draws the entity's (the one executing this script) hat on them (if any)
// based on there position and offsets given

var _xoff = argument0;
var _yoff = argument1;

// If entity is not dead, draw hat offset from it's position
if (!isDead && hat != noone) {
    draw_sprite_ext(spr_hat, hat, x + _xoff, y + _yoff, drawScale, drawScale, rotation, c_white, 1);
}