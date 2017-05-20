///scr_hurtRadius(x, y, amt, radius, forceAmt, fade?, doAffectPlayer, doAffectZombie);
/* This will hurt any entity within the specified
 * radius at the x and y pos.
 * x - xcoord of hurtRadius
 * y - ycoord of hurtRadius
 * amt - amount of damage to inflict
 * radius - radius of hurt
 * forceAmt - amount of force created (if any)
 * fade? - fade damage based on distance from center and radius
 * doAffectPlayer - inflict damage on the player?
 * doAffectZombie - inflict damage on the zombie?
 *
 * RETURNS TRUE if hurt an entity
 * RETURNS FALSE if not
*/

var _x = argument0;
var _y = argument1;
var _amt = argument2;
var _radius = argument3;
var _forceAmt = argument4;
var _fade = argument5;
var _doAffectPlayer = argument6;
var _doAffectZombie = argument7;

var didHurt = false; // did hurt an entity?
// Debugging
/*
draw_set_colour(c_red);
draw_set_alpha(0.5);
draw_ellipse(_x - (_radius / 2), _y - (_radius / 2), _x + (_radius / 2), _y + (_radius / 2), false); 
draw_set_alpha(1);
draw_set_colour(c_white);
*/

scr_createForce(_x, _y, _forceAmt, _radius, _doAffectPlayer, _doAffectZombie);

if (_doAffectPlayer) {
    with (obj_player) {
        var _dist = scr_getAbsoluteDistance(x, y, _x, _y);
        var _dmg = _amt;
        if (_dist <= _radius) {
            // Fade damage based on damage
            if (_fade) {
                _dmg = lerp(0, _dmg, _dist / _radius);
            }
            scr_hurt(id, _dmg);
            didHurt = true;
        }
    }
}

if (_doAffectZombie) {
    with (obj_zombieP) {
        var _dist = scr_getAbsoluteDistance(x, y, _x, _y);
        var _dmg = _amt;
        if (_dist <= _radius) {
            // Fade damage based on damage
            if (_fade) {
                _dmg = lerp(0, _dmg, _dist / _radius);
            }
            scr_hurt(id, _dmg);
            didHurt = true;
        }
    }
}

with (obj_lootCrate) {
    var _dist = scr_getAbsoluteDistance(x, y, _x, _y);
    var _dmg = _amt;
    if (_dist <= _radius) {
        instance_destroy();
    }
}

return didHurt;
