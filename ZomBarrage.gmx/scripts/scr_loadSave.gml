///scr_loadCurrentMapSave(num);
// 

var saveNum = argument[0];
var dir = "save" + string(saveNum) + "/";
var dynamicSaveName = "saveDynamic" + string(saveNum) + ".ini"; // saveDynamic (this) holds dynamically created resources that will get loaded after game_load
var entityDataSaveName = "entityData.ini"; // holds all entity data (itemWeapons on ground for ex), only exists when playing a map
var saveName = "save" + string(saveNum) + ".ini"; // game_save creates save[i].ini

game_load(dir + saveName);

/***************************************************
  Entity data (temporary, not kept with saveDynamic
 ***************************************************/
ini_open(dir + entityDataSaveName);
    if (ini_section_exists("entity")) {
        if (ini_key_exists("entity", "weaponsOnGround")) {
            var weaponsOnGroundData = ds_list_create(); // init save 
            var strData = ini_read_string("entity", "weaponsOnGround", "");
            
            // If there is proper data for weaponsOnGround, load and create the weapons
            if (strData != "") {
                ds_list_read(weaponsOnGroundData, strData);
                scr_createWeaponsFromDS(weaponsOnGroundData); // create weapons from weapons on ground database that was just loaded
            }
        }
        // Player Inventory loading
        if (ini_key_exists("entity", "playerInventory")) {
            var inventoryData = ds_list_create();
            var strData = ini_read_string("entity", "playerInventory", "");
            
            // If there is proper data for the players inventory, set the players inventory based off the save
            if (strData != "") {
                ds_list_read(inventoryData, strData);
                scr_PlayerInventoryClear(); // reset any dynamic player inventory data left after player may have died
                //ds_list_clear(obj_player.inventory);
                //ds_list_copy(obj_player.inventory, inventoryData);
            }
            ds_list_destroy(inventoryData);
        }
    }
ini_close();