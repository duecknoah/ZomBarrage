/// scr_scriptRunnerAddScriptByArgs(script, arg0, arg1, ...);

// script runner makes it so you can add a ds_list with the script you want
// to run and its arguments following that. This is all contained
// within the script list of type ds_list. To add a script to keep running:
//      MyScript = ds_list_create();
//      scr_scriptRunnerAddScript(script, arg0, arg1, ...);

var scriptToAdd = ds_list_create();

for (var i = 0; i < argument_count; i ++) {
    ds_list_add(scriptToAdd, argument[i]);
}

scr_scriptRunnerAddScript(scriptToAdd);