///scr_shootRocket(x, y, dir, exploDmg, shootDelay, rocketAccel, creator);
// shoots a rocket in a given direction from a given point
xx = argument0;
yy = argument1;
dir = argument2;
_rocketDmg = argument3;
delay = argument4;
_rocketAccel = argument5;
_creator = argument6;

with (obj_player) {
    if (inventoryAmmo[selectedSlot] <= 0) {
        return false; // unable to shoot rocket, no more ammo
    }
}

with (instance_create(xx, yy, obj_rocket)) {
   creator = other._creator;
   rocketDir = other.dir;
   rocketAccel = other._rocketAccel;
   rocketDmg = other._rocketDmg;
}

with (obj_player) {
    inventoryAmmo[selectedSlot] --;
    shootDelay[selectedSlot] = other.delay;
}

scr_cameraShake(10);

return true; // able to shoot rocvket