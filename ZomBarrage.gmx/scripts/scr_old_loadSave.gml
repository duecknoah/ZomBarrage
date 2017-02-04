///scr_loadCurrentMapSave(num);
// This loads all data from the save(num).ini file into obj_save's save (ds_map).
// Then changes to the proper map based off the save. When the game
// is launched, obj_save will automatically load the save (ds_map) into the games variables
// and entitys.

var _num = argument[0];

game_load("save" + string(obj_save.saveNum) + ".ini");
return true;

ini_open("save" + string(obj_save.saveNum) + ".ini");

if (ini_section_exists("data")) {
    if (ini_key_exists("data", "save")) {
        var saveStr = ini_read_string("data", "save", "");
        ds_map_read(obj_save.save, saveStr);
        // Load data
        room_goto(asset_get_index(obj_save.save[? "Map.CurrentMap"]));
        return true; // success
    }
}
show_debug_message("Loading save error: error or no file");
return false; // error or no file