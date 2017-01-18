///scr_addDialogue(message, speakerImg);
// Adds dialogue to the chatbox, used in cutscenes
var _message = argument0;
var _speakerSprite = argument1;
var _speakerSubImg = argument2;

ds_list_add(obj_guiController.chatBarMessage, _message);
ds_list_add(obj_guiController.chatBarSpeakerSprite, _speakerSprite);
ds_list_add(obj_guiController.chatBarSpeakerSubimg, _speakerSubImg);
