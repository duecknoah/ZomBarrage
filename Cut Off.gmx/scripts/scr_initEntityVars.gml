///scr_initEntityVars();
/* This initializes all variables required by an entity.
 * An entity is something that can move, gets
 * affected by forces, rotates, and can be
 * killed when their health reaches 0
*/
// Sprite replacement vars
/* We use these rather than image_index and image_speed
 * due to the actual sprites of a entity being its hitbox
 * sprite, so the number of subimages cycled when using the
 * default image_index is looped between the hitbox sprite
 * images
 * ex. hitbox sprite - 1 subimage
 *     the used sprite - 5 subimages
 */
    spr_index = sprite_index; // similiar to sprite_index
    img_index = 0; // similiar as image_index
    img_speed = 0; // similiar as image_speed
    img_number = 0; // similiar as image_number
    drawScale = 1; // basically image_xscale and image_yscale combined, this is to prevent effecting the hitbox when bobbing
// Main    
    rotation = 0; // use this rather than image_angle (that rotates the hitbox)
    rotationPrevious = rotation;
    maxHp = 10;
    hp = maxHp;
    isHurt = false; // was the entity just hurt?
    isOnFire = false; // is the entity on fire?
    isDead = false; // is the entity dead?
    hurtTime = 10; // time entity is hurt (game steps)
    hurtTimer = hurtTime; // timer used to keep track of how long entity has been hurt
    fireTime = room_speed * 2.5; // time (in game steps) that the player will be lit on fire for
    fireTimer = -1;

// Movement Variables
    path = noone; // no path by default
    doBackupPathFinding = false; // used for pathfinding
    xPush = 0; // push in x movement (usually when hit by another entity or force)
    yPush = 0; // push in y movement (usually when hit by another entity or force)
    pushResist = 0.8; // resistance of other forces (0=fully resistant, 1=no resistance)
    bobbing = 0; // a number between 0-1 where 0 is at the bottom of the bob and 1 is at the top
    isBobbingUp = true; // when true, as entity moves, the image_scale will enlarge, when false, it will shrink, giving an illusion of footsteps
// Extra
    hat = noone; // an index within spr_hat to represent the hat being worn (noone means no hat)
    
// Part systems
fireSparkEmitter = noone; // fire spark particle system (when ent is on fire, this is the particle shown)
fireLight = noone; // light that is created and parented to entity