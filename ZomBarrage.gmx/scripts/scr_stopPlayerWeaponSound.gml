///scr_stopPlayerWeaponSound();
// This stops all looping or long sounds created by the player (ex. Chainsaw)
// However, it WILL NOT stop sounds like a gunshot where it is better for the sound to
// finish
audio_stop_sound(snd_chainsaw_idle);
audio_stop_sound(snd_chainsaw_use);
