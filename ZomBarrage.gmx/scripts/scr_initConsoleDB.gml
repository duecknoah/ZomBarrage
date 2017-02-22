///scr_initConsoleDB();
/* initializes the strings in the dslist for the console database
*/

obj_guiController.consoleHelpDB = ds_list_create();

ds_list_add(obj_guiController.consoleHelpDB,
            "restart - restarts the level",
            "clear - clears the console from text",
            "toggle ZombieSpawn - toggles the natural spawning of zombies",
            "toggle hidden - toggles the view of hidden objects",
            "give points [amt] - gives [amt] of points to player", 
            "give ammo [slot] [amt] - gives [amt] of ammo to the weapon in slot [slot]",
            "set hp [amt] - sets the players hp to [amt]",
            "set wave [number] - sets the wave to [number]",
            "set speed [spd] - sets the speed of player movement",
            "build [buildingName] [x] [y] - creates a building at a desired location",
            "spawnRaw [x] [y] [object_index]  - creates a instance directly off its name#    ex. spawnRaw obj_collision 50 50",
            "spawn weapon [x] [y] [id] [ammo] - spawns a weapon at the desired location",
            "spawn force [x] [y] [amt] [range] [doEffectPlayer] [doEffectZombies]#  - creates a force (ex. explosion) at a desired location", 
            "spawn zombie [x] [y] [isCrawler] - spawn a zombie at coords provided", 
            "set window [width] [height] - sets the size of the window of the game");
            
ds_list_add(obj_guiController.consoleHelpDB, 
            "toggle fullscreen - toggles the windows fullscreen mode",
            "timeScale <amt> - changes games speed based on <amt>", 
            "map <mapName> - starts the map <mapName>",
            "toggle navGrid - toggles drawing of navGrid", 
            "toggle lights - toggles all lights in map (not env_light)", 
            "set envCol r g b - sets the environment light colourt in r g b", 
            "set zoom <multiplier> - sets the zoom of the camera", 
            "object count <object> - prints the number of <object> in game");

// set to defaults
obj_guiController.inputConsoleString = "";
obj_guiController.consoleLineOffset = 0;
obj_guiController.outputConsoleString = "";
obj_guiController.showConsole = false;
obj_guiController.showPause = false;
