///scr_consoleGetInput();
/* Will allow a user to type in something in the console,
 * then use that typed string
*/

with (obj_guiController) {
    inputConsoleString = keyboard_string;
        if (keyboard_check_pressed(vk_return) || keyboard_check_pressed(vk_enter)) {
            /* reset keyboard string which 
             * will in turn reset console string 
             * in the next step
            */
            // make previous console add what was typed and a space after
            // In other words, show a history list of what was typed or outputed
            outputConsoleString = inputConsoleString + "#" + outputConsoleString;
            keyboard_string = "";
            
            return inputConsoleString;
        }
}

// if nothing entered yet, return an empty string
return "";