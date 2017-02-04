///scr_PlayerStateManager();
// manages the players states
if (isDead) {
    state = "dead";
    flashLightOn = false;
}

// If not showing the upgrade menu, allow things to happen
if (!obj_guiController.showUpgradeScreen) {
    switch(state) {
        case "dead":
            draw_sprite_ext(spr_PlayerDead, 0, x, y, image_xscale, image_yscale, rotation, c_white, 1);
        break;
        case "punch":
            // Once done animating punch, return to default state
            // show_message(string(image_index) + " " + string(image_number) + " " + string(sprite_get_number(spr_PlayerFists)) + " " + string(sprite_index));
            if (img_index >= img_number) {
                var _x = x + lengthdir_x(16, rotation + 90);
                var _y = y + lengthdir_y(16, rotation + 90);
                scr_hurtRadius(_x, _y, 2, 16, 1, false, false, true);
                state = "default";
                img_index = 0; 
                img_speed = 0;
            }
            draw_sprite_ext(spr_index, img_index, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "shoot " + "Wimps Pistol":
            var dirSpread = (rotation + 90) + random_range(-7 * shotAcc, 7 * shotAcc);
            scr_shootBullet(x, y, dirSpread, 1 + bulletDmg, 0.15, 400, 425, instance_id);
            draw_sprite_ext(spr_PlayerWimpPistol, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "shoot " + "M16":
            var dirSpread = (rotation + 90) + random_range(-10 * shotAcc, 10 * shotAcc);
            scr_shootBullet(x, y, dirSpread, 0.625 + bulletDmg, 0.1, 500, 400, instance_id);
            draw_sprite_ext(spr_PlayerM16, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "shoot " + "Rocket Launcher":
            var dirSpread = (rotation + 90) + random_range(-5 * shotAcc, 5 * shotAcc);
            scr_shootRocket(x, y, dirSpread, 50 + exploDmg, 2, 0.1, instance_id);
            draw_sprite_ext(spr_PlayerRocketLauncher, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "toggle Flashlight":
            if (flashLightOn) {
                flashLightOn = false;
            }
            else {
                flashLightOn = true;
            }
            draw_sprite_ext(spr_PlayerFlashlight, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "Loot Key use":
            draw_sprite_ext(spr_PlayerFists1, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            // If selecting loot area, then allow use
            if (place_meeting(mouse_x, mouse_y, obj_lootArea)) {
                var _area = instance_place(mouse_x, mouse_y, obj_lootArea);
                // is loot area in range and not already looted?
                if (scr_getAbsoluteDistance(x, y, mouse_x, mouse_y) <= lootRange
                 && _area.looted == false) {
                    state = "looting"; // change state to looting ...
                    lootArea = _area; // set lootArea of looting
                    lootTimer = lootTime; // set loot timer
                    hidePlayer = true; // make player invisible (like there in the building)
                    lootXPrev = x;
                    lootYPrev = y;
                    x = _area.x;
                    y = _area.y;
                    // First use player selected slot (use Loot Key)
                    inventoryAmmo[selectedSlot] --;
                    // Then if no keys (ammo) left, remove key and make it fists
                    if (inventoryAmmo[selectedSlot] <= 0) {
                        inventory[selectedSlot] = "fists";
                    }
                }
            }
        break;
        case "looting":
            if (lootTimer > 0) {
                lootTimer -= (1 / room_speed) * global.timeScale;
            }
            else {
                scr_lootArea(lootArea);
                state = "loot choose";
            }
        break;
        case "loot choose":
        // After looting, the player can choose which weapons they want to take
        // NOTE: gui is drawn in obj_guiController draw GUI event
        break;
        case "Sniper Rifle scoped":
            draw_sprite_ext(spr_PlayerSniperRifle, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            with (sniperScopeLight) {
                x = mouse_x;
                y = mouse_y;
            }
           // surface_getpixel_ext
            //background_create_from_surface(index, x, y, w, h, removeback, smooth);
            //application_surface
           // draw_surface(application_surface, mouse_x, mouse_y);
        break;
        case "Sniper Rifle scoped shoot":
            draw_sprite_ext(spr_PlayerSniperRifle, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            var dirSpread = (rotation + 90) + random_range(-2 * shotAcc, 2 * shotAcc); // have a narrow spread
            scr_shootBullet(x, y, dirSpread, 40 + bulletDmg, 1, 400, 700, instance_id);
            with (sniperScopeLight) {
                x = mouse_x;
                y = mouse_y;
            }
            state = "Sniper Rifle scoped"; // stop the shooting
        break;
        case "Sniper Rifle unscoped shoot":
            draw_sprite_ext(spr_PlayerSniperRifle, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            var dirSpread = (rotation + 90) + random_range(-6 * shotAcc, 6 * shotAcc); // have a wider spread (when unscoped)
            scr_shootBullet(x, y, dirSpread, 40 + bulletDmg, 1, 400, 700, instance_id);
            state = "Sniper Rifle" // stop the shooting
        break;
        case "throw Molotov Cocktail":
            draw_sprite_ext(spr_PlayerMolotovCocktail, 1, x, y, drawScale, drawScale, rotation, c_white, 1);
            var _throwDist = 128;
            var _dir = rotation + 90;
            var _startX = x;
            var _startY = y;
            scr_createMolotovCocktail(_startX, _startY, _dir, _throwDist);
            // Make ammo go down by one, if no more ammo, remove cocktail
            // As them item itself is the quantity
            inventoryAmmo[selectedSlot] --;
            if (inventoryAmmo[selectedSlot] <= 0) {
                inventory[selectedSlot] = "fists";
            }
            shootDelay[selectedSlot] = 1.5; // 1 second delay
            state = "Molotov Cocktail";
        break;
        case "throw Frag Grenade":
            draw_sprite_ext(spr_PlayerFragGrenade, 1, x, y, drawScale, drawScale, rotation, c_white, 1);
            var _throwDist = 128;
            var _dir = rotation + 90;
            var _startX = x;
            var _startY = y;
            scr_createFragGrenade(_startX, _startY, _dir, _throwDist);
            // Make ammo go down by one, if no more ammo, remove cocktail
            // As them item itself is the quantity
            inventoryAmmo[selectedSlot] --;
            if (inventoryAmmo[selectedSlot] <= 0) {
                inventory[selectedSlot] = "fists";
            }
            // Go back to normal state of holding frag grenade
            state = "Frag Grenade";
            shootDelay[selectedSlot] = 1; // 1 second delay
        break;
        case "swing Iron Sword":
            // Once done animating sword, return to default state
            // show_message(string(image_index) + " " + string(image_number) + " " + string(sprite_get_number(spr_PlayerFists)) + " " + string(sprite_index));
            // If on frame where player swung sword, create hurt radius
            if (img_index == 1) {
                var _rotOff = 30;
                var _x = x + lengthdir_x(16, rotation + 90 + _rotOff);
                var _y = y + lengthdir_y(16, rotation + 90 + _rotOff);
                scr_hurtRadius(_x, _y, 5, 16, 25, false, false, true);
            }
            // When at end of animation, return to default state 
            if (img_index >= img_number) {    
                state = "default";
                img_index = 0; 
                img_speed = 0;
                img_number = 0;
            }
            draw_sprite_ext(spr_PlayerIronSword, img_index, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "run Chainsaw":
            if (inventoryAmmo[selectedSlot] > 0) {
                // Do constant amounts of small damage
                var _rotOff = -15;
                var _x = x + lengthdir_x(8, rotation + 90 + _rotOff);
                var _y = y + lengthdir_y(8, rotation + 90 + _rotOff);
                scr_hurtRadius(_x, _y, 1, 20, 25, false, false, true);
                draw_sprite_ext(spr_PlayerChainsaw, img_index, x, y, drawScale, drawScale, rotation, c_white, 1);
                inventoryAmmo[selectedSlot] -= 0.05; // lose ammo every step (chainsaw has lots)
                shootDelay[selectedSlot] = 0.5; // shoot delay only effects the startup of the chainsaw, once running, it is unaffected
            }
            else {
                state = "Chainsaw"; // prevent running once out of ammo
            }
        break;
        case "typing":
            img_speed = 0.5;
            img_number = 3;
            draw_sprite_ext(spr_PlayerTyping, img_index, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        default:
        // if no special state, show player holding selected item
            switch(obj_player.inventory[selectedSlot]) {
                case "fists": 
                    draw_sprite_ext(spr_index, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case "Wimps Pistol":
                     draw_sprite_ext(spr_PlayerWimpPistol, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case "M16":
                     draw_sprite_ext(spr_PlayerM16, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case "Rocket Launcher":
                      draw_sprite_ext(spr_PlayerRocketLauncher, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case "Flashlight":
                    draw_sprite_ext(spr_PlayerFlashlight, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case "Loot Key":
                    draw_sprite_ext(spr_PlayerFists1, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                    // If selecting loot area and in range, then make visible
                    if (place_meeting(mouse_x, mouse_y, obj_lootArea) && scr_getAbsoluteDistance(x, y, mouse_x, mouse_y) <= lootRange) {
                        with (instance_place(mouse_x, mouse_y, obj_lootArea)) {
                            // If not already looted, make visible
                            if (!looted) {
                                visible = true;
                            }
                        }
                    }
                break;
                case "Sniper Rifle":
                    draw_sprite_ext(spr_PlayerSniperRifle, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case "Molotov Cocktail":
                    draw_sprite_ext(spr_PlayerMolotovCocktail, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case "Frag Grenade":
                    draw_sprite_ext(spr_PlayerFragGrenade, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case "Iron Sword":
                    draw_sprite_ext(spr_PlayerIronSword, 0, x, y, drawScale, drawScale, rotation, c_white, 1);  
                break;
                case "Chainsaw":
                    draw_sprite_ext(spr_PlayerChainsaw, 0, x, y, drawScale, drawScale, rotation, c_white, 1);  
                break;
                default:
                    // If nothing after all of that, just draw player default sprite
                    draw_sprite_ext(spr_PlayerFists1, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            }
    }
}

// Player sitting on something (chair)
if (sittingOnEntity != noone) {
    x = sittingOnEntity.x;
    y = sittingOnEntity.y;
}

// Update shoot delay
if (shootDelay[0] > 0) {
    shootDelay[0] -= (1 / room_speed) * global.timeScale;
}
if (shootDelay[1] > 0) {
    shootDelay[1] -= (1 / room_speed) * global.timeScale;
}
