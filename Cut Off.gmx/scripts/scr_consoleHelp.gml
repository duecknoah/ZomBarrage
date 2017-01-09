///scr_consoleHelp(function, showAll?);
/* This is the database and script to access it
 * for the help screen for all of the functions
 * within the console in game.
*/

var _func = argument0;
var _doShowAll = argument1;

if (_doShowAll) {
    var _str = "";
    for(var _i = 0; _i < ds_list_size(obj_guiController.consoleHelpDB); _i ++) {
        _str += obj_guiController.consoleHelpDB[| _i];  
        _str += "#"; // new line  
    }
    
    scr_consoleOutPrintln(_str);
}
else { // if not showing all, then show individual function help

   var _keyword;
   var keyFound = false; // found the desired help page?
   // Iterate through the console help DB, see if the first word in each line matches the _func keyword
   for(var _i = 0; _i < ds_list_size(obj_guiController.consoleHelpDB); _i ++) {
        // make a ds_list of the first word of every line in the help page to get the function name keywords.
        _keyword = scr_stringSplit(obj_guiController.consoleHelpDB[| _i], ' ', false);
        
        // Does the searched function match the first word of this help page?
        if (_func == _keyword[| 0]) {
            scr_consoleOutPrintln(obj_guiController.consoleHelpDB[| _i]);
            keyFound = true;
        }
   }
   ds_list_destroy(_keyword);
   
   if (!keyFound) {
        scr_consoleOutPrintln("Help page: [" + _func + "] doesn't exist");
   }
}