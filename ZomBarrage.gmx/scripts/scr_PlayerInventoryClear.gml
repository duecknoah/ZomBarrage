/// scr_PlayerInventoryClear();
// Clears the players entire inventory
if (ds_exists(obj_player.inventory, ds_type_list)) {
    for (var i = 0; i < ds_list_size(obj_player.inventory); i ++) {
        obj_player.inventory[| i] = scr_IdToWeapon(0); // set to empty slots 
    }
}
