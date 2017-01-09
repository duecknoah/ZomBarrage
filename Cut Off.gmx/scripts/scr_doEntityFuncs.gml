///scr_doEntityFuncs
/* This is responsible for doing all functions
 * associated with an entity
*/

if (round(xPush) != 0 || round(yPush) != 0) {
    var newX = (x + power(xPush, global.timeScale));
    var newY = (y + power(yPush, global.timeScale));
    
    // Calculate bounce off collisions from push
    /* Note if you want the entity to bounce,
     * make xPush and ypush = -xpush and -ypush (reversing the
     * push and effectivly bouncing off the wall
    */
    // Bounce
    /*
    if (place_meeting(newX, y, obj_collision)) {
        xPush = -xPush; // flip x push (bounce off collision)
    }
    
    if (place_meeting(x, newY, obj_collision)) {
        yPush = -yPush; // flip x push (bounce off collision)
    }
    */
    if (place_meeting(newX, y, obj_collision)) {
        xPush = 0; // stop x movement (hit collision)
    }
    // add push forces to x of entity (horizontal movement)
    // force calculations separated to prevent getting stuck in corner collisions
    x += xPush;
    xPush *= power(pushResist, global.timeScale); // resist the force over time, slowly down for example
    
    if (place_meeting(x, newY, obj_collision)) {
        yPush = 0; // stop y movement (hit collision)
    }
    // add push forces to y of entity (vertical movement)
    y += yPush;
    yPush *= power(pushResist, global.timeScale); // resist the force over time, slowly down for example
    
    /* If a zombie, their pathfinding path
     * must be ended in order to affect their
     * x and y vals
    */
    if (object_index == obj_zombie || object_index == obj_civilian) {
        path_end();
    }
}

if (isHurt) {
    if (hurtTimer >= 0) {
        hurtTimer -= 1 * global.timeScale;
    }
    else {
        hurtTimer = hurtTime;
        isHurt = false;
    }
}

// If on fire and not already on fire
if (place_meeting(x, y, obj_fire) && !isOnFire) {
    isOnFire = true;
    hurtTimer = 0;
    // have fireLight parented to entity
    fireLight = instance_create(x, y, obj_light);
    
    fireTimer = fireTime;
    
    with (fireLight) {
        parent = other.id;
        radius = 128;
        orgRadius = 128;
        flicker = true;
        color = c_orange;
    }
}

// If entity was lit on fire and hurt timer interval finished, hurt entity again
if (isOnFire && hurtTimer <= 0) {
    // If emitter already exists, burst particle
    if (part_emitter_exists(obj_particleIndex.fireSpark, fireSparkEmitter)) {
        part_emitter_region(obj_particleIndex.fireSpark, fireSparkEmitter, x - 5, x + 5, y - 5, y + 5, ps_shape_ellipse, ps_distr_linear); 
        part_emitter_burst(obj_particleIndex.fireSpark, fireSparkEmitter, obj_particleIndex.fireSpark, 2);
    }
    else {
        // Init fire spark particle
        fireSparkEmitter = part_emitter_create(obj_particleIndex.fireSpark);
    }
    scr_hurt(id, 1); // constant hurts
    hurtTimer = room_speed; // 1 second delay between each hurt
}
// If on fire, keep counting down the fireTimer
if (isOnFire) {
    if (fireTimer > 0) {
        fireTimer --;
    }
    else {
        // Make entity no longer on fire
        isOnFire = false;
    }
}

// If no longer or not on fire, destroy fireSpark emitter if it exists
if (!isOnFire) {
    if (part_emitter_exists(obj_particleIndex.fireSpark, fireSparkEmitter)) {
        part_emitter_destroy(obj_particleIndex.fireSpark, fireSparkEmitter);
    }
    with (fireLight) {
        instance_destroy();
    }
    fireLight = noone; // reset firelight variable
}

// If entity is discovered dead, make it dead
if (hp <= 0) {
    isDead = true;
    // Do not destroy player object if hp of entity is 0
    if (object_index != obj_player) {
        instance_destroy();
    }
    else {
        // If player
        // create blood pool
        instance_create(x, y, obj_bloodPool);
        gameOver = true; // since player is dead, set it to game over
    }
}

depth = scr_getDepth(y, 0, true);

// prevent entity from leaving the room

if (x < 0) {
    x = 0;
    xPush = 0;
}
if (x > room_height) {
    x = room_height;
    xPush = 0;
}
if (y < 0) {
    y = 0;
    yPush = 0;
}
if (y > room_height) {
    y = room_height;
    yPush = 0;
}

// Use replacement img_index and img_speed and img_number
// for more info on why I use this look at:
// scr_initEntityVars()
img_index += img_speed * global.timeScale;
if (img_index > img_number) {
    img_index = 0;
}

var bobHeight = 0.15; //def 0.15
var movementAmt;
if (object_index == obj_zombie || object_index == obj_civilian) {
    movementAmt = path_speed;
}
else if (object_index == obj_bigZombie) {
    // Make big zombie slam down when bobbing down (showing lots of weight)
    if (isBobbingUp) {
        movementAmt = path_speed;
    }
    else {
        movementAmt = path_speed * 5;
    }
    bobHeight = 0.5;
}
else {
   movementAmt = sqrt(sqr(abs(x - xprevious)) + sqr(abs(y - yprevious))); 
}

if (isBobbingUp) {
    bobbing = clamp(bobbing + (movementAmt / 16), 0, 1);
}
else {
    bobbing = clamp(bobbing - (movementAmt / 16), 0, 1);
}

drawScale = 1 + (bobbing * bobHeight);

// At top of bob, begin shrinking down
if (bobbing == 1) {
    isBobbingUp = false;
}
// At bottom of bob, begin enlarging up
else if (bobbing == 0) {
    isBobbingUp = true;
}