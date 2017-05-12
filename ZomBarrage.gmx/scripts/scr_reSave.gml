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
var entityDataSaveName = "entityData.ini"; // holds all entity data (itemWeapons on ground for ex), only exists when playing a map
var saveName = "save" + string(saveNum) + ".ini"; // game_save creates save[i].ini

game_save(dir + saveName); // save game state

// Make sure there is already a save there to overwrite
if (obj_save.saveUsed[saveNum] == true) {
    /***************************************************
      Dynamic Save
     ***************************************************/
    ini_open(dir + dynamicSaveName);
    // if this is not the first time saving, overwrite the values in the ds_list
    if (!ds_map_empty(obj_save.saveDynamic)) {
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
    /***************************************************
      Items on Ground Save (Only exists during gameplay)
     ***************************************************/
    ini_open(dir + entityDataSaveName);
        // Weapons on ground data
        var weaponsOnGroundDS = scr_getAllItemWeaponsDS();
        ini_write_string("entity", "weaponsOnGround", ds_list_write(weaponsOnGroundDS));
        // Player inventory data
        ini_write_string("entity", "playerInventory", ds_list_write(obj_player.inventory));
    ini_close();
}
else {
    show_debug_message("Unable to overwrite save " + string(saveNum) + ", it does not exist!");
}
