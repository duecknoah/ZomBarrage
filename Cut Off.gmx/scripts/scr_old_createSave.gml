///scr_createNewSave(num);
// creates a new save number <num>

/* Data in a save file, the [] indicates a section, and the symbols indicate ds data
 * [data] 
 * save: #%@$#^#@$^%@#RFSDGSR%&YES$YH$R%YQA#$%@
 * 
*/

var saveNum = argument[0];

return true;

if (obj_save.saveUsed[saveNum] == false) {
    ini_open("save" + string(saveNum) + ".ini");
    //ds_map_add(obj_save.save, "Map.CurrentMap", mp_the_beginning_home); // intialize the map to be the first map in the game on a new save
    ini_write_string("data", "save", ds_map_write(obj_save.save));
    ini_close();
}
else {
    show_debug_message("Unable to create save " + string(saveNum) + ", it already exists!");
}