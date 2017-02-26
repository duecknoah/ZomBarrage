///scr_loadCurrentMapSave(num);
// this loads all data from save to obj_save, 
// it just loads the dynamic ds_map data into obj_save from the save ini file requested and then
// overwrites the games instances with the proper variable values.

var saveNum = argument[0];
var dir = "save" + string(saveNum) + "/";
var dynamicSaveName = "saveDynamic" + string(saveNum) + ".ini"; // saveDynamic (this) holds dynamically created resources that will get loaded after game_load
var saveName = "save" + string(saveNum) + ".ini"; // game_save creates save[i].ini

//show_message("HG");
ini_open(dir + dynamicSaveName);

if (ini_section_exists("data")) {
    if (ini_key_exists("data", "save")) {
        // Load data into the games instances and variables
        with (obj_save) {
            var saveStr = ini_read_string("data", "save", "");
            if (saveStr == "") {
                show_message("Loading save error: save dynamic data string empty! No data.");
                room_goto(rm_Menu);
            }
            obj_save.saveDynamic = ds_map_create(); // init save file, this is the current one being used in game that holds dynamic resources while game_save loads everything else
            ds_map_read(obj_save.saveDynamic, saveStr);
            /* LIST OF DYNAMIC RESOURCES:
            - All ds variables
            - all dynamic data
            */
            // Player Stats
            with (obj_player) {
                // Permanent (stats that last the whole game)
                maxHp = obj_save.saveDynamic[? "Player.maxHp"];
                points = obj_save.saveDynamic[? "Player.points"]; // how many points the player has, used in buying upgrades
                lootRange = obj_save.saveDynamic[? "Player.lootRange"]; // range where player can loot from (using loot key)
                lootTime = obj_save.saveDynamic[? "Player.lootTime"]; // time it takes (in seconds) to loot a building
            }
            scr_initConsoleDB();
            
        }         
        return true; // success
    }
}
show_message("Loading save error: error or no save dynamic data");
room_goto(rm_Menu);
return false; // error or no file