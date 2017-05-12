///scr_createWeapon(x, y, weapon);
/* Creates a weapon entity at
 * specified coords
 */

xx = argument0;
yy = argument1;
weapon = argument2; 

with (instance_create(xx, yy, obj_itemWeapon)) {
    weapon = other.weapon;
}