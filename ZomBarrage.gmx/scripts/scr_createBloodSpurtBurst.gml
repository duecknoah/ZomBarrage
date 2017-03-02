///scr_createBloodSpurtBurst(x, y, _partAmt);
// Creates blood spurt at the specified pos
var _x = argument0;
var _y = argument1;
var _partAmt = argument2;

part_emitter_region(obj_particleIndex.bloodSpurt, obj_bloodSpurt.bloodSpurtEmitter, x - 5, x + 5, y - 5, y + 5, ps_shape_ellipse, ps_distr_linear); 
part_emitter_burst(obj_particleIndex.bloodSpurt, obj_bloodSpurt.bloodSpurtEmitter, obj_particleIndex.bloodSpurt, _partAmt);