///scr_consoleRunFunc
// Runs a typed function

var _input = argument0;
var _inputLength = ds_list_size(_input);
var commandList = ds_list_create(); // list of commands

for (var i=0; i<_inputLength; i++) {
    // replace input of px with player x pos
    if (_input[| i] == "px") {
        _input[| i] = string(obj_player.x);
    }
    // replace input of py with player y pos
    if (_input[| i] == "py") {
        _input[| i] = string(obj_player.y);
    }
    // replace input of mx with mouse x pos
    if (_input[| i] == "mx") {
        _input[| i] = string(mouse_x);
    }
    // replace input of my with mouse y pos
    if (_input[| i] == "my") {
        _input[| i] = string(mouse_y);
    }
}

switch (_inputLength) {
    case 1:
        // Help screen
        if (_input[| 0] == "help") {
            scr_consoleHelp("null", true);
            return 0;
        }
        //restart
        if (_input[| 0] == "restart") {
            //room_restart();
            obj_save.doLoadSaveIntoGame = true; // load save into game after map loads
            scr_loadSave(obj_save.saveNum);
            return 0;
        }
        //clear (clears the console)
        if (_input[| 0] == "clear") {
            scr_consoleClear();
            return 0;
        }
        // Save game
        if (_input[| 0] == "save") {
            scr_reSave(obj_save.saveNum);
            return 0;
        }
    break;
    case 2:
        //toggle ZombieSpawn
        if (_input[| 0] == "toggle" && _input[| 1] == "ZombieSpawn") {
            // toggle the natural spawning of zombies
            with (obj_waveController) {
                if (preventSpawn) {
                    preventSpawn = false;
                }
                else {
                    preventSpawn = true;
                }
                scr_consoleOutPrintln("Natural zombie spawning set to: " + scr_boolToString(!preventSpawn));
                return 0;
            }  
        }
        //toggle hidden (toggles the view of hidden objects)
        if (_input[| 0] == "toggle" && _input[| 1] == "hidden") {
            with (obj_light) {
                if (visible) {
                    visible = false;
                }
                else {
                    visible = true;
                }
            }
            
            with (obj_collision) {
                if (visible) {
                    visible = false;
                }
                else {
                    visible = true;
                }
            }
            return 0;
        }
        // toggle fullscreen
        if (_input[| 0] == "toggle" && _input[| 1] == "fullscreen") { 
            window_set_fullscreen(!window_get_fullscreen());
            
            return 0;
        }
        // toggle lights
        // Toggles all the lights in the map to change from off to on or on to off
        if (_input[| 0] == "toggle" && _input[| 1] == "lights") {
            with (obj_light) {
                isOn = !isOn;
            }
        }
        // timeScale
        if (_input[| 0] == "timeScale") {
            var spd = real(_input[| 1]);
            var newTimeScale = scr_setTimeScale(spd);
            scr_consoleOutPrintln("Set timeScale to " + string(newTimeScale) + "x");
            return 0;
        }
        // map <mapName>
        // Loads and runs the map typed
        if (_input[| 0] == "map") {
            var _map = asset_get_index(_input[| 1]);
            if (room_exists(_map)) {
                room_goto(_map);
            }
            else {
                scr_consoleOutPrintln("Map " + _input[| 1] + " doesn't exist!");
                return 0;
            }
        }
        // toggle navGrid
        // toggles drawing of navGrid
        if (_input[| 0] == "toggle" && _input[| 1] == "navGrid") {
            if (instance_exists(obj_navGrid)) {
                obj_navGrid.visible = !obj_navGrid.visible;
                scr_consoleOutPrintln("show Navgrid: " + string(obj_navGrid.visible)); 
            }
            else {
                scr_consoleOutPrintln("navGrid doesn't exist in map!");
            }
        }
        
        // load <saveNum>
        // loads the save of the save number specified
        if (_input[| 0] == "load") {
            scr_loadSave(clamp(real(_input[| 1]), 0, 2));
            return 0;
        }
    break;
    case 3: 
        if (_input[| 0] == "set" && _input[| 1] == "hp") {
            obj_player.hp = real(_input[| 2]);
            return 0;
        }
        // set wave
        if (_input[| 0] == "set" && _input[| 1] == "wave") {
            // kills all zombies
            with (obj_zombie) {
                instance_destroy();
            }
            // sets wave to desired wave
            global.currentWave = real(_input[| 2]);
            return 0;
        }
        // set player spd
        if (_input[| 0] == "set" && _input[| 1] == "speed") {
            obj_player.playerSpd = real(_input[| 2]);
            scr_consoleOutPrintln("Player speed set to: " + _input[| 2]);
            return 0;
        }
        
        // sets the zoom of the camera
        // set zoom (zoomAmt 1-infinity)
        if (_input[| 0] == "set" && _input[| 1] == "zoom") {
            obj_camera.zoom = real(_input[| 2]);
            scr_consoleOutPrintln("Set zoom to " + _input[| 2] + "x");
            return 0;
        }
        
        // Gives points to player
        // give [amt]
        if (_input[| 0] == "give" && _input[| 1] == "points") {
            obj_player.points += real(_input[| 2]);
            scr_consoleOutPrintln("Gave player " + _input[| 2] + " points.");
            return 0;
        }
        
        // Counts the number of object in game and prints it in console
        // object count <object>
        if (_input[| 0] == "object" && _input[| 1] == "count") {
            var _obj = asset_get_index(_input[| 2]);
            if (object_exists(_obj)) {
                if (instance_exists(_obj)) {
                    scr_consoleOutPrintln(string(instance_number(_obj)));
                }
                else {
                    scr_consoleOutPrintln("0");
                }
            }
            else {
                scr_consoleOutPrintln("Object " + _input[| 2] + " does not exist!");
            }
            return 0;
        }
    case 4:
        // build [buildingName] [x] [y]
        // ex. build GreenBuilding 50 25
        if (_input[| 0] == "build") {
           var obj = asset_get_index("b_" + string(_input[| 1]));
           if (obj > -1) {
                instance_create(real(_input[| 2]), real(_input[| 3]), obj); 
                scr_consoleOutPrintln("Built building: " 
                                        + string(_input[| 1]) 
                                        + " at X: " + _input[| 2] 
                                        + ", Y: " + _input[| 3]);
           }
           else {
                scr_consoleOutPrintln("Unknown building, That building doesn't exist!");
           }
           return 0;
        }
        // spawnRaw [object_index] [x] [y]
        // spawnRaw obj_collision 50 50
        if (_input[| 0] == "spawnRaw") {
            var obj = asset_get_index(string(_input[| 3]));
            if (obj > -1) {
                instance_create(real(_input[| 1]), real(_input[| 2]), obj);
            }
            else {
                scr_consoleOutPrintln("Unknown object, That object doesn't exist!");
            }
            return 0;
        }
        // Gives ammo to player in the weapon of the specified slot
        // give [amt]
        if (_input[| 0] == "give" && _input[| 1] == "ammo") {
            var _slot = real(_input[| 2]);
            var _amt = real(_input[| 3]);
            
            if (_slot >= 0 && _slot < array_length_1d(obj_player.inventoryAmmo)) {
                obj_player.inventoryAmmo[_slot] += _amt;
                scr_consoleOutPrintln("Gave player " + _input[| 3] + " ammo in slot" + _input[| 2]);
            }
            else {
                scr_consoleOutPrintln("Slot " + string(_slot) + " doesn't exist");
            }
            return 0;
        }
        // set window [width] [height]
        // sets the size of the window of the game
        if (_input[| 0] == "set" && _input[| 1] == "window") {
            var _w = real(_input[| 2]);
            var _h = real(_input[| 3]);
            
            //scr_consoleOutPrintln("Command not developed yet");
            //return 0;
            
            if (_w > 0 || _h > 0) {
                window_set_size(_w, _h);
                view_wport[0] = _w;
                view_hport[0] = _h;
                scr_consoleOutPrintln("Window size set to: W: " + string(_w) + ", H: " + string(_h));
            }
            else {
                scr_consoleOutPrintln("Size cannot be 0 or less");
            }
            return 0;
        }
    break;
    case 5:
        // spawn zombie [x] [y] [isCrawler]
        if (_input[| 0] == "spawn" && _input[| 1] == "zombie") {
            with (instance_create(real(_input[| 2]), real(_input[| 3]), obj_zombie)) {
                isCrawler = scr_stringToBool(_input[| 4]);
            } 
            scr_consoleOutPrintln("Spawned zombie at X: " + _input[| 2] + ", Y: " + _input[| 3]);
            return 0;
        }
                
        // set envCol 5 255 50
        // sets the environment light colour in r g b
        if (_input[| 0] == "set" && _input[| 1] == "envCol") {
            var col = make_color_rgb(real(_input[| 2]), real(_input[| 3]), real(_input[| 4]));
            scr_setEnvColor(col);
            scr_consoleOutPrintln("Set environment color to: " + "R=" + _input[| 2] + " G=" + _input[| 3] + " B=" + _input[| 4]);
            return 0;
        }
    break;
    case 6:
        // spawn weapon x y 2 25
        // spawn weapon [x] [y] [id] [ammo]
        if (_input[| 0] == "spawn" && _input[| 1] == "weapon") {
            
            var isWeapon = scr_createWeapon(real(_input[| 2]), real(_input[| 3]), real(_input[| 4]), real(_input[| 5]));
            if (isWeapon == -1) {
                scr_consoleOutPrintln("Weapon id: " + _input[| 4] + " is not a real weapon");
            }
            return 0;
        }
    break;
    case 8:
        // spawn force x y 25 256 true true
        // spawn force [xcoord] [ycoord] [amt] [range] [doEffectPlayer] [doEffectZombies]
        if (_input[| 0] == "spawn" && _input[| 1] == "force") {
            scr_createForce(real(_input[| 2]), real(_input[| 3]), real(_input[| 4]), real(_input[| 5]), _input[| 6], _input[| 7]);
            return 0;
        }
    break;
}

// If no commands match what was typed, test if player is using 'help <function>'
if (_inputLength > 1) {
    if (_input[| 0] == "help") {
        scr_consoleHelp(_input[| 1], false);
        return 0;
    }
}

// If an unknown command, say it was
scr_consoleOutPrintln("Unknown Command, type 'help' for help");
