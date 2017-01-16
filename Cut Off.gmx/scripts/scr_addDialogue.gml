///scr_addDialogue(message, speakerImg);
// Adds dialogue to the chatbox, used in cutscenes
var _message = argument0;
var _speakerImg = argument1;

ds_list_add(obj_guiController.chatBarMessage, _message);
ds_list_add(obj_guiController.chatBarSpeakerImage, _speakerImg);