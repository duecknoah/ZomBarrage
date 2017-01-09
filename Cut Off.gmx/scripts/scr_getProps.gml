///scr_getProps();
// returns a ds_list of all props, don't forget to destroy the ds_list after!

var _props = ds_list_create();

ds_list_add(_props, obj_propBookshelf, 
                    obj_propIndoorWall, 
                    obj_propBench, 
                    obj_propLightPost,);

return _props;