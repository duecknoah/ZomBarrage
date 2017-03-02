///scr_createZombieGoreBurst(x, y, _partAmt);
// Creates Zombie gore at the specified pos
var _x = argument0;
var _y = argument1;
var _partAmt = argument2;

part_emitter_region(obj_particleIndex.zombieGore, obj_zombieGore.zombieGoreEmitter, _x - 5, _x + 5, _y - 5, _y + 5, ps_shape_ellipse, ps_distr_linear); 
part_emitter_burst(obj_particleIndex.zombieGore, obj_zombieGore.zombieGoreEmitter, obj_particleIndex.zombieGore, _partAmt);
