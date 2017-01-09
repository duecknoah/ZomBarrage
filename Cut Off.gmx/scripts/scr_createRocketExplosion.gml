///scr_createRocketExplosion(x, y);
// Creates a rocket explosion at specific coordinates

with (obj_particleIndex) {
    part_emitter_region(explosion, explosionEmitter, x - 5, x + 5, y - 5, y + 5, ps_shape_ellipse, ps_distr_linear); 
    part_emitter_burst(explosion, explosionEmitter, explosion, 1);
}