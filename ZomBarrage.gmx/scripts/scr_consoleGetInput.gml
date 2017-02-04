///scr_consoleGetInput();
/* Will allow a user to type in something in the console,
 * then use that typed string and return it as an array
 * The string is separated by the spaces, which indicate
 * a new entry in the array
 * ex. "create zombie 3"
 *     would return an array of:
        [0] = "create"
        [1] = "zombie"
        [3] = "3"
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
            
            // Split the string into an array
            return scr_stringSplit(inputConsoleString, " ", false);
        }
}

// if nothing entered yet, return an empty string
return -1;