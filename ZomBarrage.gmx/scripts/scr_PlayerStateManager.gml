///scr_PlayerStateManager();
// manages the players states
if (isDead) {
    state = "dead";
    flashLightOn = false;
}

// Get weapon data for the id of the weapon being held. 
// NOTE: This is just going off the weapon database. So something like 
// ammo of this is NOT the same as the players ammo
// for this weapon. Rather, its a blueprint of the weapon the total 
var currentWeapon = scr_WeaponNameToWeapon(inventory[selectedSlot]);

// If not showing the upgrade menu, allow things to happen
if (!obj_guiController.showUpgradeScreen) {
    switch(state) {
        case "dead":
            draw_sprite_ext(spr_PlayerDead, 0, x, y, image_xscale, image_yscale, rotation, c_white, 1);
        break;
        case "punch":
            // Once done animating punch, return to default state
            if (img_index == 0) {
                state = "default";
                img_index = 0; 
                img_speed = 0;
            }
            
            // create hurt radius at frame 2 in the animation
            if (img_index >= 2 && shootDelay[selectedSlot] <= 0) {
                var _x = x + lengthdir_x(16, rotation + 90);
                var _y  = y + lengthdir_y(16, rotation + 90);
                var didHurt = scr_hurtRadius(_x, _y, 2, 16, currentWeapon[? "damage"], false, false, true);
                if (didHurt) {
                    audio_play_sound_on(s_emit, choose(snd_body_hit_1, snd_body_hit_2, snd_body_hit_3), false, 5);
                }
                shootDelay[selectedSlot] = 0.15;
            }
            draw_sprite_ext(spr_index, img_index, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "shoot Wimps Pistol": // shoot Wimps Pistol
            var dirSpread = (rotation + 90) + random_range(-7 * (1 - shotAcc), 7 * (1 - shotAcc));
            if (scr_shootBullet(x, y, dirSpread, currentWeapon[? "damage"] + bulletDmg, 0.15, 400, 425, instance_id)) {
                audio_play_sound_on(s_emit, snd_pistol_shot, false, 5);
            }
            draw_sprite_ext(spr_PlayerWimpPistol, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "shoot M16": // shoot M16
            var dirSpread = (rotation + 90) + random_range(-10 * (1 - shotAcc), 10 * (1 - shotAcc));
            if (scr_shootBullet(x, y, dirSpread, currentWeapon[? "damage"] + bulletDmg, 0.1, 500, 400, instance_id)) {
                audio_play_sound_on(s_emit, choose(snd_m16_shot_1, snd_m16_shot_2, snd_m16_shot_3), false, 5);
            }
            draw_sprite_ext(spr_PlayerM16, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "shoot Rocket Launcher": // shoot Rocket Launcher
            var dirSpread = (rotation + 90) + random_range(-5 * (1 - shotAcc), 5 * (1 - shotAcc));
            // explo radius is stored in rocket explosion entity
            scr_shootRocket(x, y, dirSpread, currentWeapon[? "damage"] + exploDmg, 2, 0.1, instance_id);
            draw_sprite_ext(spr_PlayerRocketLauncher, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "toggle Flashlight": // toggle Flashlight
            audio_play_sound_on(s_emit, snd_flashlight_toggle, false, 5);
            if (flashLightOn) {
                flashLightOn = false;
            }
            else {
                flashLightOn = true;
            }
            draw_sprite_ext(spr_PlayerFlashlight, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "Loot Key use": // Loot Key use
            draw_sprite_ext(spr_PlayerFists1, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            // If selecting loot area, then allow use
            if (place_meeting(mouse_x, mouse_y, obj_lootArea)) {
                var _area = instance_place(mouse_x, mouse_y, obj_lootArea);
                // is loot area in range and not already looted?
                if (distance_to_object(_area) <= lootRange
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
                    // Play sound effect
                    audio_play_sound_on(s_emit, snd_unlock_and_open, false, 5);
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
        case "Sniper Rifle scoped": // Sniper Rifle scoped
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
        case "Sniper Rifle scoped shoot": // Sniper Rifle scoped shoot
            draw_sprite_ext(spr_PlayerSniperRifle, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            var dirSpread = (rotation + 90) + random_range(-2 * (1 - shotAcc), 2 * (1 - shotAcc)); // have a narrow spread
            if (scr_shootBullet(x, y, dirSpread, currentWeapon[? "damage"] + bulletDmg, 2, 400, 700, instance_id)) {
                with (sniperScopeLight) {
                    x = mouse_x;
                    y = mouse_y;
                }
                audio_play_sound_on(s_emit, snd_sniper_shot, false, 5);
                audio_play_sound_on(s_emit, snd_sniper_reload, false, 5);
            }
            state = "Sniper Rifle scoped"; // "Sniper Rifle scoped" stop the shooting
        break;
        case "Sniper Rifle unscoped shoot": // Sniper Rifle unscoped shoot
            draw_sprite_ext(spr_PlayerSniperRifle, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            var dirSpread = (rotation + 90) + random_range(-6 * (1 - shotAcc), 6 * (1 - shotAcc)); // have a wider spread (when unscoped)
            if (scr_shootBullet(x, y, dirSpread, currentWeapon[? "damage"] + bulletDmg, 2, 400, 700, instance_id)) {
                audio_play_sound_on(s_emit, snd_sniper_shot, false, 5);
                audio_play_sound_on(s_emit, snd_sniper_reload, false, 5);
            }
            state = "Sniper Rifle"; // Sniper Rifle
        break;
        case "throw Molotov Cocktail": // throw Molotov Cocktail
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
            state = "Molotov Cocktail"; // Molotov Cocktail
        break;
        case "throw Frag Grenade": // Throw Frag Grenade
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
            state = "Frag Grenade"; // Frag Grenade
            shootDelay[selectedSlot] = 1; // 1 second delay
        break;
        case "swing Iron Sword": // swing Iron Sword
            // Once done animating sword, return to default state
            // show_message(string(image_index) + " " + string(image_number) + " " + string(sprite_get_number(spr_PlayerFists)) + " " + string(sprite_index));
            // When at end of animation, return to default state 
            if (img_index == 0 || currentWeapon[? "name"] != "Iron Sword") {    
                state = "default";
                img_index = 0; 
                img_speed = 0;
                img_number = 0;
            }
            // If on frame where player swung sword, create hurt radius
            if (img_index >= 1 && shootDelay[selectedSlot] <= 0) {
                var _rotOff = 30;
                var _x = x + lengthdir_x(16, rotation + 90 + _rotOff);
                var _y = y + lengthdir_y(16, rotation + 90 + _rotOff);
                scr_hurtRadius(_x, _y, currentWeapon[? "damage"], currentWeapon[? "radius"], currentWeapon[? "force"], false, false, true);
                shootDelay[selectedSlot] = 0.5;
            }
            draw_sprite_ext(spr_PlayerIronSword, img_index, x, y, drawScale, drawScale, rotation, c_white, 1);
        break;
        case "run Chainsaw": // run Chainsaw
            if (inventoryAmmo[selectedSlot] > 0) {
                // Do constant amounts of small damage
                var _rotOff = -15;
                var _x = x + lengthdir_x(8, rotation + 90 + _rotOff);
                var _y = y + lengthdir_y(8, rotation + 90 + _rotOff);
                scr_hurtRadius(_x, _y, currentWeapon[? "damage"], currentWeapon[? "radius"], currentWeapon[? "force"], false, false, true);
                // Cancel idle sound
                if (audio_is_playing(snd_chainsaw_idle)) {
                    audio_stop_sound(snd_chainsaw_idle);
                }
                // Play chainsaw use sound
                if (!audio_is_playing(snd_chainsaw_use)) {
                    audio_play_sound_on(s_emit, snd_chainsaw_use, false, 5);
                }
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
            switch(scr_WeaponNameToId(obj_player.inventory[selectedSlot])) {
                case 0: // fists
                    draw_sprite_ext(spr_index, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case 1: //"Wimps Pistol"
                     draw_sprite_ext(spr_PlayerWimpPistol, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case 2: //"M16"
                     draw_sprite_ext(spr_PlayerM16, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case 3: //"Rocket Launcher"
                      draw_sprite_ext(spr_PlayerRocketLauncher, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case 4: //"Flashlight"
                    draw_sprite_ext(spr_PlayerFlashlight, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case 5: //"Loot Key"
                    draw_sprite_ext(spr_PlayerFists1, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                    // If selecting loot area and in range, then make visible
                    var _area = instance_place(mouse_x, mouse_y, obj_lootArea);
                    // is loot area in range and not already looted?
                    if (distance_to_object(_area) <= lootRange) {
                        with (instance_place(mouse_x, mouse_y, obj_lootArea)) {
                            // If not already looted, make visible
                            if (!looted) {
                                visible = true;
                            }
                        }
                    }
                break;
                case 6: //"Sniper Rifle"
                    draw_sprite_ext(spr_PlayerSniperRifle, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case 7: //"Molotov Cocktail"
                    draw_sprite_ext(spr_PlayerMolotovCocktail, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case 8: //"Frag Grenade"
                    draw_sprite_ext(spr_PlayerFragGrenade, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
                break;
                case 9: //"Iron Sword"
                    draw_sprite_ext(spr_PlayerIronSword, 0, x, y, drawScale, drawScale, rotation, c_white, 1);  
                break;
                case 10: //"Chainsaw"
                    draw_sprite_ext(spr_PlayerChainsaw, 0, x, y, drawScale, drawScale, rotation, c_white, 1);  
                    // Cancel use sound (if playing)
                    if (audio_is_playing(snd_chainsaw_use)) {
                        audio_stop_sound(snd_chainsaw_use);
                    }
                    // Play idle sound if there is still fuel / ammo
                    if (inventoryAmmo[selectedSlot] > 1) {
                        if (!audio_is_playing(snd_chainsaw_idle)) {
                            audio_play_sound_on(s_emit, snd_chainsaw_idle, false, 5);
                        }
                    }
                break;
                default:
                    // If nothing after all of that, just draw player default sprite
                    draw_sprite_ext(spr_PlayerFists1, 0, x, y, drawScale, drawScale, rotation, c_white, 1);
            }
    }
}

// Update shoot delay
if (shootDelay[0] > 0) {
    shootDelay[0] -= (1 / room_speed) * global.timeScale;
}
if (shootDelay[1] > 0) {
    shootDelay[1] -= (1 / room_speed) * global.timeScale;
}
