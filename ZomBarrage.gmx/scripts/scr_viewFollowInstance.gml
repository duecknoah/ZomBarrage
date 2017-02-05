///scr_viewFollowInstance(inst);
// This sets the cameras follow instance to the specified instace. Making
// the camera track inst.
var _inst = argument0;

if (instance_exists(obj_camera)) {
    obj_camera.followInst = _inst;
}
