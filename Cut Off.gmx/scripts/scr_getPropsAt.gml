/// scr_getPropsAt(x, y);
// returns an array of props at x and y
// don't forget to delete ds_list after!

var _x = argument0;
var _y = argument1;
var _props = scr_getProps();
var propAmt = ds_list_size(_props);
var _propsAtPos = ds_list_create();

for (var i = 0; i < propAmt; i ++) {
    _propsAtPos[| i] = instance_place(_x, _y, _props[| i]);
}
/*
ds_list_add(_props, instance_place(_x, _y, obj_propBookshelf)
                    , instance_place(_x, _y, obj_propIndoorWall)
                    , instance_place(_x, _y, obj_propBench)
                    , instance_place(_x, _y, obj_propLightPost));
*/
ds_list_destroy(_props); // destroy props list but keep _propsAtPos (as we are returning that)                    
return _propsAtPos; 