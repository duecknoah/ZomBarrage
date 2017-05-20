///scr_createWoodBurst(x, y, _partAmt);
// Creates wood particle burst at the specified pos
var _x = argument0;
var _y = argument1;
var _partAmt = argument2;

part_emitter_region(obj_particleIndex.woodBurst, obj_woodBurst.woodBurstEmitter, x - 5, x + 5, y - 5, y + 5, ps_shape_ellipse, ps_distr_linear); 
part_emitter_burst(obj_particleIndex.woodBurst, obj_woodBurst.woodBurstEmitter, obj_particleIndex.woodBurst, _partAmt);
