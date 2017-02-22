///scr_reSave(num);
// overwrites the save <num>

/* Data in a ini save file, the [] indicates a section, and the symbols indicate ds map data
 * [data] 
 * save: #%@$#^#@$^%@#RFSDGSR%&YES$YH$R%YQA#$%@
 * 
*/

var saveNum = argument[0];
var dir = "save" + string(saveNum) + "/";
var dynamicSaveName = "saveDynamic" + string(saveNum) + ".ini"; // saveDynamic (this) holds dynamically created resources that will get loaded after game_load
var saveName = "save" + string(saveNum) + ".ini"; // game_save creates save[i].ini

game_save(dir + saveName);

// Make sure there is already a save there to overwrite
if (obj_save.saveUsed[saveNum] == true) {
    ini_open(dir + dynamicSaveName);
    // if this is not the first time saving, overwrite the values in the ds_list
    if (!ds_map_empty(obj_save.saveDynamic)) {
        // ... ADD MORE ...
        // Only add dynamic resources in here
        // Permanent player stats
        obj_save.saveDynamic[? "Player.maxHp"] = obj_player.maxHp;
        obj_save.saveDynamic[? "Player.points"] = obj_player.points;
        obj_save.saveDynamic[? "Player.lootRange"] = obj_player.lootRange;
        obj_save.saveDynamic[? "Player.lootTime"] = obj_player.lootTime;
    }
    else {
        show_debug_message("saveDynamic is empty!");
    }
    ini_write_string("data", "save", ds_map_write(obj_save.saveDynamic));
    ini_close();
}
else {
    show_debug_message("Unable to overwrite save " + string(saveNum) + ", it does not exist!");
}
