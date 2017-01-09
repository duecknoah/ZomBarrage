///scr_loadCurrentMapSave(num);
// this loads all data from save to obj_save, 
// it just loads the ds_map into obj_save from the save ini file requested and then
// overwrites the games instances with the proper variable values.

var _num = argument[0];

return true;

ini_open("save" + string(obj_save.saveNum) + ".ini");

if (ini_section_exists("data")) {
    if (ini_key_exists("data", "save")) {
        // Load data into the games instances and variables
        with (obj_save) {
            // Map data
            //room = save[? "Map.CurrentMap"]; NOT DONE AS MAP IS ALREADY SET
            obj_cutscene.cutscene = save[? "Map.Cutscene"];
            obj_cutscene.activate = save[? "Map.CutsceneActivate"];
            // Player data
            obj_player.x = save[? "Player.x"];
            obj_player.y = save[? "Player.y"];
            obj_player.sittingOnEntity = save[? "Player.sittingOnEntity"];
            
        }         
        return true; // success
    }
}
return false; // error or no file