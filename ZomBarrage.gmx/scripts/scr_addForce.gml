///scr_addForce(id, xAmt, yAmt);
// adds a force to the given instance

instanceId = argument0;
xAmt = argument1;
yAmt = argument2;

if (instance_exists(instanceId)) {
    with (instanceId) {
        xPush += other.xAmt;
        yPush += other.yAmt;
        
        // If a player, add camera shake based on push average
        if (id == obj_player.id) {
            var _multiplier = 2;
            scr_cameraShake(((abs(xPush) + abs(yPush)) / 2) * _multiplier);
        }
    }
}