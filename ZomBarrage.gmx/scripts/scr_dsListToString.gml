///scr_dsListToString(ds_list);
// Converts the entire ds_list to a single string

var _list = argument0;
var _str = "";

if (ds_exists(_list, ds_type_list)) {
    for(var _i = 0; _i < ds_list_size(_list); _i ++) {
        _str += _list[| _i];                
    }
}

return _str;