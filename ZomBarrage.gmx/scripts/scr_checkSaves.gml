///scr_checkSaves();
// Checks which saves exist and are used, it will keep this information in obj_save
// which is persistant as long as the game is running

for (var i = 0; i < 3; i++) { 
    var dir = "save" + string(i) + "/";
    var dynamicSaveName = "saveDynamic" + string(i) + ".ini"; // saveDynamic (this) holds dynamically created resources that will get loaded after game_load
    var saveName = "save" + string(i) + ".ini"; // game_save creates save[i].ini

    // If there is no save directory there for save, save doesn't exist
    if (!directory_exists(dir)) {
        obj_save.saveUsed[i] = false;
        continue;
    }

    // If dynamic game saveDynamic.ini is not there, game save is not considered to be used
    if (file_exists(dir + dynamicSaveName)) {
        ini_open(dir + dynamicSaveName);
        //var dsData = ds_list_create();
        var dataStr = ini_read_string("data", "save", "");
        //ds_list_read(dsData, ini_read_string("data", "save", ""));
        ini_close();
        
        if (dataStr == "") {
            // No data written, save is not used
            obj_save.saveUsed[i] = false;
        }
        else {
            // All files intact, save is used
            obj_save.saveUsed[i] = true;
        }
    }
    else { // no dynamic save exists at all, save is not used
        obj_save.saveUsed[i] = false;
    }
}
