/// scr_isSelectingPrimaryInvSlot();
// Returns true if the player is selecting a primary inventory slot
// Returns false if the player is selecting a secondary inventory slot
if (obj_player.selectedSlot <= 1) {
    return true;
}
else if (obj_player.selectedSlot <= ds_list_size(obj_player.inventory)) {
    return false;
}

return false;
