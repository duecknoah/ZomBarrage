///scr_scriptRunnerAddScript(ds_list);

// script runner makes it so you can add a ds_list with the script you want
// to run and its arguments following that. This is all contained
// within the script list of type ds_list. To add a script to keep running:
//      MyScriptList = ds_list_create();
//      ds_list_add(MyScriptList, "scrFoo");
//      ds_list_add(MyScriptList, 2);
//      scr_scriptRunnerAddScript(MyScriptList);

var _list = argument0; // must contain (script, arg0, arg1, ...)

ds_list_add(obj_scriptRunner.scriptList, _list);