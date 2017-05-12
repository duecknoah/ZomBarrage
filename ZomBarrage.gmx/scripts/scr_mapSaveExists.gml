///scr_mapSaveExists(saveNum);
// This will return true if the map save or any other map data (not dynamic save) exists, else 
// it will return false

var saveNum = argument[0];
var dir = "save" + string(saveNum) + "/";
var saveName = "save" + string(saveNum) + ".ini"; // game_save creates save[i].ini
var entityDataSaveName = "entityData.ini"; // holds all entity data (itemWeapons on ground for ex), only exists when playing a map

if (!file_exists(dir + saveName)) {
    return false;
}
if (!file_exists(dir + entityDataSaveName)) {
    return false;
}

return true;
