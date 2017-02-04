///scr_shootBullet(x, y, dir, damage, shootDelay, minDist, maxDist, creator)
xx = argument0;
yy = argument1;
dir = argument2;
damage = argument3;
delay = argument4;
_minDist = argument5;
_maxDist = argument6;
_creator = argument7;

with (obj_player) {
    if (inventoryAmmo[selectedSlot] <= 0) {
        return false; // unable to shoot bullet, no more ammo
    }
}

with (instance_create(xx, yy, obj_bullet)) {
   bulletMinDist = other._minDist;
   bulletMaxDist = other._maxDist;
   creator = other._creator;
   bulletDir = other.dir;
   damage = other.damage;
}

with (obj_player) {
    inventoryAmmo[selectedSlot] --;
    shootDelay[selectedSlot] = other.delay;
}

var flashRadius = 128;
scr_lightFlash(xx + lengthdir_x(flashRadius / 6, rotation + 90), 
               yy + lengthdir_y(flashRadius / 6, rotation + 90), 
               128, c_orange);
scr_cameraShake(4);
               
return true; // able to shoot bullet