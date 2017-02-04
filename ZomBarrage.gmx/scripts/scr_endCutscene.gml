/// scr_endCutscene();
// Ends the cutscene and sets gui data back to normal
with (obj_guiController) {
    showUpgrade = true; // show upgrade gui?
    showUpgradeButton = true; // show upgrade button?
    showPause = true; // show pause gui?
    showPauseButton = true; // show pause button?
    showWeaponPickupText = true; // show weapon pickup text?
    showWaveBar = true; // show the wave bar?
    showOnFireGuiAlpha = true; // run the code to do with the on fire on the screen?
    showInventory = true; // Weapon slots and inventory
    showHealthBar = true;
}
obj_cutscene.cutscene = noone; // mark cutscene as done