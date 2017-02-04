///scr_consoleKeyFuncs();

// Copying clipboard from console input
if (keyboard_check(vk_lcontrol) && keyboard_check_pressed(ord("C"))) {
    clipboard_set_text(keyboard_string);
}
// Pasting clipboard in console
if (keyboard_check(vk_lcontrol) && keyboard_check_pressed(ord("V"))) {
    if (clipboard_has_text()) {
        // Setting the keyboard string will in turn set inputConsoleString
        keyboard_string = string(keyboard_string) + clipboard_get_text();
    }
}