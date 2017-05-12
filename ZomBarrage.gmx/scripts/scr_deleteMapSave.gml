///scr_deleteMapSave(saveNum);
// This will clear the saved gamestate / obj_save.save and any other temporary data created
// during the process of gameplay.
// This is used when exiting a level or the game ends, we don't want
// the player to skip the beginning cutscene if there is a gamestate / obj_save.save
// save data when re-loading the level after already exiting the level.
// The map save (not saveDynamic) is only used when a player dies and wants
// to restart the level, this skips the intro cutscene.

var saveNum = argument[0];
var dir = "save" + string(saveNum) + "/";
var dynamicSaveName = "saveDynamic" + string(saveNum) + ".ini"; // saveDynamic (this) holds dynamically created resources that will get loaded after game_load
var entityDataSaveName = "entityData.ini"; // holds all entity data (itemWeapons on ground for ex), only exists when playing a map
var saveName = "save" + string(saveNum) + ".ini"; // game_save creates save[i].ini

if (saveNum == -1) {
    exit;
}
// If save exists
if (obj_save.saveUsed[saveNum]) {
    file_delete(dir + saveName);
    file_delete(dir + entityDataSaveName);
    show_debug_message("Map save deleted! (" + dir + saveName + ")");
}
else {
    show_debug_message("Map save is not used, not deleting it.");
}
