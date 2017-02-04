///scr_checkSaves();
// Checks which saves exist and are used, it will keep this information in obj_save
// which is persistant as long as the game is running

for (var i = 0; i < 3; i++) { 
    var filename = "save" + string(i) + ".ini";
    if (file_exists(filename)) {
        ini_open(filename);
        //var dsData = ds_list_create();
        var dataStr = ini_read_string("data", "save", "");
        //ds_list_read(dsData, ini_read_string("data", "save", ""));
        ini_close();
        
        if (dataStr == "") {
            obj_save.saveUsed[i] = false;
        }
        else {
            obj_save.saveUsed[i] = true;
        }
    }
    else { // if no file exists at all, save is not used
        obj_save.saveUsed[i] = false;
    }
}

obj_save.saveUsed[1] = true;