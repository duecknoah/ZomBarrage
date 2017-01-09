///scr_createGuiText(x, y, text, halign, valign, font, color, alpha, fadeinT, fadeoutT, time);
with (instance_create(0, 0, obj_guiText)) {
    textX = argument[0];
    textY = argument[1];
    text = argument[2];
    textHAlign = argument[3];
    textVAlign = argument[4];
    font = argument[5];
    textCol = argument[6];
    textAlpha = argument[7];
    fadeInTime = argument[8];
    fadeOutTime = argument[9];
    time = argument[10];
}