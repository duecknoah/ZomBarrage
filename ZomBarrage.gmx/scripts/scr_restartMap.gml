///scr_restartLevel();
// restarts the current level off the save

obj_save.doLoadSaveIntoGame = true; // load save into game after map loads

// First make sure map save exists, if it doesn't, then just restart the entire
// room using room_restart();
if (scr_mapSaveExists(obj_save.saveNum)) {
    scr_loadSave(obj_save.saveNum);
}
else {
    room_restart();
}
// Reset all audio
audio_stop_all();
