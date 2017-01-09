///scr_WeaponToId(name)
// will return the coressponding id for the weapon name
// will return -1 if name / weapon doesn't exist

/* Note! To get total weapons, type global.totalWeapons
 * (set in obj_roomObjectsInit). This DOESN'T include fists
*/

name = argument0;

switch(name) {
    case "fists": 
        return 0;
    break;
    case "Wimps Pistol":
        return 1;
    break;
    case "M16":
        return 2;
    break;
    case "Rocket Launcher":
        return 3;
    break;
    case "Flashlight":
        return 4;
    break;
    case "Loot Key":
        return 5;
    break;
    case "Sniper Rifle":
        return 6;
    break;
    case "Molotov Cocktail":
        return 7;
    break;
    case "Frag Grenade":
        return 8;
    break;
    case "Iron Sword":
        return 9;
    break;
    case "Chainsaw":
        return 10;
    break;
    default: return -1;
}