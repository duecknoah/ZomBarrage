///scr_removeOtherEntityTargeting();
// All entities targeting this instance will no longer target it.
// Note that it doesn't mean the entities won't re-target that entity
// right afterwords.

/// If a zombie is targeting this, make that zombies target noone
with (obj_zombie) {
    // If target is this, make it noone
    if (target == other.id) {
        target = noone;
    }
}

with (obj_civilian) {
    // If lookAtEntity is this, make it noone
    if (lookAtEntity == other.id) {
        lookAtEntity = noone;
    }
}
