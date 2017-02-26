///scr_mapSaveExists(saveNum);
// This will return true if the map save (not dynamic save) exists, else 
// it will return false

var saveNum = argument[0];
var dir = "save" + string(saveNum) + "/";
var saveName = "save" + string(saveNum) + ".ini"; // game_save creates save[i].ini

if (!file_exists(dir + saveName)) {
    return false;
}

return true;
