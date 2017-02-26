///scr_createSave(num);
// creates a new save number <num> in its own save directory

var saveNum = argument[0];
var dir = "save" + string(saveNum) + "/";
var dynamicSaveName = "saveDynamic" + string(saveNum) + ".ini"; // saveDynamic (this) holds dynamically created resources that will get loaded after game_load
var saveName = "save" + string(saveNum) + ".ini"; // game_save creates save[i].ini

if (!directory_exists(dir)) {
    directory_create(dir);
}

// If save is not used
if (obj_save.saveUsed[saveNum] == false) {
    ini_open(dir + dynamicSaveName);
    // Init saveDynmic ds_map
    ds_map_add(obj_save.saveDynamic, "Used", true); // marks dynamic save as used
    // Permanent player stats
    ds_map_add(obj_save.saveDynamic, "Player.maxHp", 35);
    ds_map_add(obj_save.saveDynamic, "Player.points", 0);
    ds_map_add(obj_save.saveDynamic, "Player.lootRange", 32);
    ds_map_add(obj_save.saveDynamic, "Player.lootTime", 2);
    // Write dynamic data to saveDynamic<saveNum>.ini file
    ini_write_string("data", "save", ds_map_write(obj_save.saveDynamic));
    ini_close();
}
else {
    show_debug_message("Unable to create save " + string(dir + saveName) + ", it already exists!");
}
