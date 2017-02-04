///scr_createForce(xcoord, ycoord, amt, radius, doEffectPlayer, doEffectZombies);
/* creates a radial force that effects all entities
 * by pushing them in the given directions based off the
 * location of the force and the power of it with the radius
 * xcoord and ycoord - coordinate points of force
 * amt - the amount of force given
 * radius - the 
*/

xcoord = argument0;
ycoord = argument1;
amt = argument2;
radius = argument3;
doEffectPlayer = argument4;
doEffectZombies = argument5;

/* Loop through entities, doing one entity at a time, this is done
 * to prevent having the same code typed for each entity.
*/
for (var i = 0; i < 2; i ++) {
    var entityToEffect = noone;
    switch(i) {
        case 0:
            if (doEffectPlayer) {
                entityToEffect = obj_player;
            }
            else continue;
        break;
        case 1:
            if (doEffectPlayer) {
                entityToEffect = obj_zombie;
            }
            else continue;
        break;
        default: continue;
    }
    // Apply force on entity   
    with (entityToEffect) {
        // If within radius, add force
        if (distance_to_point(other.xcoord, other.ycoord) < other.radius) {
            var _angle = point_direction(other.xcoord, other.ycoord, x, y);
            var _xPush = cos(degtorad(_angle)) * other.amt; // x coordinate push
            var _yPush = -sin(degtorad(_angle)) * other.amt; // y coordinate push
            var _xDist = abs(x - other.xcoord); // x distance from center
            var _yDist = abs(y - other.ycoord); // y distance from center
            
            // fade out force based on distance
            _xPush = lerp(_xPush, 0, _xDist / other.radius);
            _yPush = lerp(_yPush, 0, _yDist / other.radius);  
            scr_addForce(id, _xPush, _yPush);
        }
    }
}