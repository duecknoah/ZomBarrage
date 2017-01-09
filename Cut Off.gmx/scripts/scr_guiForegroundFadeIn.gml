///scr_guiForegroundFadeIn(seconds);
// fades in from foreground image, returns true when done
// spd is in seconds total to finish

var fadeSpd = 1 / room_speed / argument[0];

if (obj_guiController.foregroundImageAlpha > 0) {
    obj_guiController.foregroundImageAlpha = clamp(obj_guiController.foregroundImageAlpha - fadeSpd, 0, 1);
    return false; // still fading
}

return true; // done fading