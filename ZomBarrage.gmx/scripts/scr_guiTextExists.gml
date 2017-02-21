///scr_guiTextExists(text);
// checks if a specific gui text exists or not based off the string of text
// returns the id of the text if true
// returns noone if no matches were found

with (obj_guiText) {
        if (text == argument0) {
            return id;
        }
}

return noone; // none of that text exists
