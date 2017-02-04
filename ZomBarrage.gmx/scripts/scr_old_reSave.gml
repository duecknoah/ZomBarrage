///scr_reSave(num);
// overwrites the save <num>

/* Data in a ini save file, the [] indicates a section, and the symbols indicate ds map data
 * [data] 
 * save: #%@$#^#@$^%@#RFSDGSR%&YES$YH$R%YQA#$%@
 * 
*/

var saveNum = argument[0];

game_save("save" + string(saveNum) + ".ini");
return true;

// Make sure there is already a save there to overwrite
if (obj_save.saveUsed[saveNum] == true) {
    ini_open("save" + string(saveNum) + ".ini");
    // If this is the first time saving (as only the map, add everything to the ds_map
    if (ds_map_empty(obj_save.save)) {
        // Map data
        show_message(obj_save.save[? "Map.CurrentMap"]);
        ds_map_add(obj_save.save, "Map.CurrentMap", room_get_name(room)); // current map
        show_message(obj_save.save[? "Map.CurrentMap"]);
        ds_map_add(obj_save.save, "Map.Cutscene", obj_cutscene.timeline_index); // current cutscene / timeline object
        ds_map_add(obj_save.save, "Map.CutsceneRunning", obj_cutscene.timeline_running); // is the cutscene / timeline running?
        // Player data
        ds_map_add(obj_save.save, "Player.x", obj_player.x);
        ds_map_add(obj_save.save, "Player.y", obj_player.y);
        ds_map_add(obj_save.save, "Player.maxHp", obj_player.maxHp);
        ds_map_add(obj_save.save, "Player.points", obj_player.points);
        ds_map_add(obj_save.save, "Player.lootRange", obj_player.lootRange);
        ds_map_add(obj_save.save, "Player.lootRank", obj_player.lootRank);
        ds_map_add(obj_save.save, "Player.lootTime", obj_player.lootTime);
        ds_map_add(obj_save.save, "Player.lootTimer", obj_player.lootTimer);
        ds_map_add(obj_save.save, "Player.shotAcc", obj_player.shotAcc);
        ds_map_add(obj_save.save, "Player.exploDmg", obj_player.exploDmg);
        ds_map_add(obj_save.save, "Player.bulletDmg", obj_player.bulletDmg);
        ds_map_add(obj_save.save, "Player.playerSpd", obj_player.playerSpd);
        
        ds_map_add(obj_save.save, "Player.isOnFire", obj_player.isOnFire);
        ds_map_add(obj_save.save, "Player.isDead", obj_player.isDead);
        ds_map_add(obj_save.save, "Player.fireTime", obj_player.fireTime);
        ds_map_add(obj_save.save, "Player.fireTimer", obj_player.fireTimer);
        ds_map_add(obj_save.save, "Player.hurtTime", obj_player.hurtTime);
        ds_map_add(obj_save.save, "Player.hurtTimer", obj_player.hurtTimer);
        ds_map_add(obj_save.save, "Player.sittingOnEntity", obj_player.sittingOnEntity);
        
        // Zombie data
        
        // Entity Weapon data
        
        //
        // ... ADD MORE ...
    }
    else {
        // Else if this is not the first time saving, overwrite the values in the ds_list
        obj_save.save[? "Map.CurrentMap"] = room_get_name(room);
        // ... ADD MORE ...
        
    }
    ini_write_string("data", "save", ds_map_write(obj_save.save));
    ini_close();
}
else {
    show_debug_message("Unable to overwrite save " + string(saveNum) + ", it does not exist!");
}