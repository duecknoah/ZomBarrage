///scr_charSeparate(inst, interactInst);
// makes character stop interacting (separate) with the specified instance (ex. chair, vehicle)
// if they are interacting with that instance
var _char = argument0; // the instance
var _interactInst = argument1; // the instance to interact with

// If interact instance is locked, prevent the char from separating from it
if (_interactInst.isLocked) {
    return false;
}

// If the character is interacting with the interact instance and the character is 
// interacting with some instance
if (_char.interactEntity == _interactInst && _char.interactEntity != noone) {
    _char.interactEntity = noone; // make character interact with the interact instance
    _interactInst.interactEntity = noone; // make the interact instance interact with the character
    // Make character "jump off" from the entity it is interacting with and be teleported
    // to the position where it originally got on from.
    _char.x = _interactInst.xPreviousInteractEntity; 
    _char.y = _interactInst.yPreviousInteractEntity;
    // reset
    _interactInst.xPreviousInteractEntity = noone;
    _interactInst.yPreviousInteractEntity = noone;
}