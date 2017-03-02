///scr_createRunnerZombieGoreBurst(x, y, _partAmt);
// Creates RunnerZombie gore at the specified pos
var _x = argument0;
var _y = argument1;
var _partAmt = argument2;

part_emitter_region(obj_particleIndex.runnerZombieGore, obj_runnerZombieGore.runnerZombieGoreEmitter, _x - 5, _x + 5, _y - 5, _y + 5, ps_shape_ellipse, ps_distr_linear); 
part_emitter_burst(obj_particleIndex.runnerZombieGore, obj_runnerZombieGore.runnerZombieGoreEmitter, obj_particleIndex.runnerZombieGore, _partAmt);
