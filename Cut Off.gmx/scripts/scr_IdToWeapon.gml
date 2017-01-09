///scr_IdToWeapon(ID)
// will return the coressponding name for the weapon id
// will return default if id / weapon doesn't exist

/* Note! To get total weapons, type global.totalWeapons
 * (set in obj_roomObjectsInit). This DOESN'T include fists
*/

ID = argument0;

switch(ID) {
    case 0: 
        return "fists";
    break;
    case 1:
        return "Wimps Pistol";
    break;
    case 2:
        return "M16";
    break;
    case 3:
        return "Rocket Launcher";
    break;
    case 4:
        return "Flashlight";
    break;
    case 5:
        return "Loot Key";
    break;
    case 6:
        return "Sniper Rifle";
    break;
    case 7:
        return "Molotov Cocktail";
    break;
    case 8:
        return "Frag Grenade";
    break;
    case 9:
        return "Iron Sword";
    break;
    case 10:
        return "Chainsaw";
    break;
    default: return "default";
}