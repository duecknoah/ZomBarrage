///scr_isBeingPushed(id);
// checks if specified entity (id) is being pushed by a force or not

_id = argument0;

if (instance_exists(_id)) {
    with (_id) {
        if (round(xPush) == 0 && round(yPush) == 0) {
            return false; // is not being pushed (or by a very small amount)
        }
        else return true; // being pushed
    }
}

// emergency break
return false;